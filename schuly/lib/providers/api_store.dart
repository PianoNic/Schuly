import 'package:flutter/material.dart';
import 'package:schuly/api/lib/api.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../services/push_notification_service.dart';
import 'dart:convert';

class ApiStore extends ChangeNotifier {
  // Initialization state
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  // Auth
  String? _bearerToken;
  String? get bearerToken => _bearerToken;
  set bearerToken(String? token) {
    _bearerToken = token;
    if (token != null) {
      // Set token for all future requests
      defaultApiClient.addDefaultHeader('Authorization', 'Bearer $token');
    } else {
      defaultApiClient.defaultHeaderMap.remove('Authorization');
    }
    notifyListeners();
  }

  // API service
  final ApiService _apiService = ApiService();

  // Data for all endpoints
  // List<AbsenceNoticeStatusDto>? absenceNoticeStatus;
  List<Object>? absenceNotices;
  List<AbsenceDto>? absences;
  StudentIdCardDto? studentIdCard;
  List<AgendaDto>? agenda;
  // List<ExamDto>? exams;
  List<GradeDto>? grades;
  List<LatenessDto>? lateness;
  List<Object>? notifications;
  List<SettingDto>? settings;
  // List<Object>? topics;
  UserInfoDto? userInfo;
  Map<String, dynamic>? appInfo;

  // Selected absence ID for navigation
  String? _selectedAbsenceId;
  String? get selectedAbsenceId => _selectedAbsenceId;

  void setSelectedAbsenceId(String? id) {
    _selectedAbsenceId = id;
    notifyListeners();
  }

  void clearSelectedAbsenceId() {
    _selectedAbsenceId = null;
    notifyListeners();
  }

  // In-memory user map: email -> {email, password, access_token, refresh_token, expires_at}
  Map<String, Map<String, dynamic>> _users = {};
  String? _activeUserEmail;

  String? get activeUserEmail => _activeUserEmail;
  List<String> get userEmails => _users.keys.toList();
  Map<String, dynamic>? get activeUser => _activeUserEmail != null ? _users[_activeUserEmail] : null;

  // On startup, load users from secure storage
  Future<void> loadUsers() async {
    _users = await StorageService.getUsers();
    _activeUserEmail = await StorageService.getActiveUser();

    if (_activeUserEmail != null && _users[_activeUserEmail] != null) {
      await _setAuthFromUser(_users[_activeUserEmail]!);
    }
    notifyListeners();
  }

  // Initialize the app (load users and authenticate)
  Future<void> initialize() async {
    try {
      await loadUsers();
      if (_activeUserEmail != null && _users[_activeUserEmail] != null) {
        // Load cached data first for instant UI
        await loadAllFromCache();
      }
      await autoLoginIfNeeded();
      if (_activeUserEmail != null && _users[_activeUserEmail] != null) {
        // Then fetch fresh data in background (non-blocking)
        fetchAll(forceRefresh: true).catchError((e) {
          print('[initialize] Background fetch error: $e');
        });
      }
      _isInitialized = true;
    } catch (e) {
      print('[initialize] Error during initialization: $e');
      _isInitialized = true; // Still mark as initialized to show the app
    }
    notifyListeners();
  }

  // Add a user (login and store)
  Future<String?> addUser(String email, String password) async {
    print('[addUser] Attempting login for: $email');
    try {
      final response = await _apiService.authenticateWithResponse(email, password);
      print('[addUser] API response: statusCode=${response.statusCode}, body=${response.body}');
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        try {
          final result = jsonDecode(response.body);
          print('[addUser] Decoded result: $result');
          if (result['access_token'] != null) {
            final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
            final expiresIn = result['expires_in'] ?? 3600;
            final expiresAt = now + expiresIn;
            _users[email] = {
              'email': email,
              'password': password,
              'access_token': result['access_token'],
              'refresh_token': result['refresh_token'],
              'token_type': result['token_type'],
              'expires_at': expiresAt,
            };
            _activeUserEmail = email;
            try {
              await StorageService.saveUser(email, _users[email]!);
              await StorageService.setActiveUser(email);
              await _setAuthFromUser(_users[email]!);
              print('[addUser] User persisted and auth set.');
            } catch (storageError, stack) {
              print('[addUser] Error persisting user: $storageError');
              print(stack);
              return 'Login succeeded but failed to persist user: $storageError';
            }
            notifyListeners();
            return null; // Success
          } else {
            print('[addUser] No access_token in response.');
            return 'Login failed: No access_token in response. Body: \\${response.body}';
          }
        } catch (jsonError, stack) {
          print('[addUser] JSON decode error: $jsonError');
          print(stack);
          return 'Login failed: JSON decode error: $jsonError';
        }
      } else {
        print('[addUser] Login failed: statusCode=\\${response.statusCode}, body=\\${response.body}');
        return 'Login failed: statusCode=\\${response.statusCode}, body=\\${response.body}';
      }
    } catch (e, stack) {
      print('[addUser] Exception: $e');
      print(stack);
      return 'Login error: $e\\n$stack';
    }
  }

  // Switch active user
  Future<void> switchUser(String email) async {
    if (_users.containsKey(email)) {
      _activeUserEmail = email;
      await StorageService.setActiveUser(email);
      await _setAuthFromUser(_users[email]!);

      // Clear current data and load cached data for new user
      _clearCurrentData();
      await loadAllFromCache();

      notifyListeners();
    }
  }

  // Helper method to clear current in-memory data
  void _clearCurrentData() {
    absences = null;
    grades = null;
    agenda = null;
    lateness = null;
    userInfo = null;
    studentIdCard = null;
    settings = null;
    appInfo = null;
    absenceNotices = null;
    notifications = null;
  }

  // Remove a user
  Future<void> removeUser(String email) async {
    _users.remove(email);
    await StorageService.removeUser(email);
    
    if (_activeUserEmail == email) {
      _activeUserEmail = _users.keys.isNotEmpty ? _users.keys.first : null;
      await StorageService.setActiveUser(_activeUserEmail);
      if (_activeUserEmail != null) {
        await _setAuthFromUser(_users[_activeUserEmail]!);
      } else {
        bearerToken = null;
      }
    }
    notifyListeners();
  }

  // Auto-login if token expired
  Future<void> autoLoginIfNeeded() async {
    if (_activeUserEmail == null) return;
    final user = _users[_activeUserEmail];
    if (user == null) return;
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    if ((user['expires_at'] ?? 0) < now) {
      // Token expired, re-login
      await addUser(user['email'], user['password']);
    } else {
      await _setAuthFromUser(user);
    }
  }

  // Internal: set bearer token from user
  Future<void> _setAuthFromUser(Map<String, dynamic> user) async {
    bearerToken = user['access_token'];
  }

  // Internal: handle API errors consistently
  void _handleApiError(ApiException e) {
    if (e.code == 403 && e.message != null && e.message!.contains('Not authenticated')) {
      lastApiError = 'Not authenticated';
    } else {
      lastApiError = e.toString();
    }
  }

  // Cache helper methods
  Future<void> _cacheAbsences(List<AbsenceDto> data) async {
    final jsonList = data.map((item) => item.toJson()).toList();
    await StorageService.cacheData('absences_${_activeUserEmail ?? 'default'}', jsonList);
  }

  Future<void> _cacheGrades(List<GradeDto> data) async {
    final jsonList = data.map((item) => item.toJson()).toList();
    await StorageService.cacheData('grades_${_activeUserEmail ?? 'default'}', jsonList);
  }

  Future<void> _cacheAgenda(List<AgendaDto> data) async {
    final jsonList = data.map((item) => item.toJson()).toList();
    await StorageService.cacheData('agenda_${_activeUserEmail ?? 'default'}', jsonList);
  }

  Future<void> _cacheLateness(List<LatenessDto> data) async {
    final jsonList = data.map((item) => item.toJson()).toList();
    await StorageService.cacheData('lateness_${_activeUserEmail ?? 'default'}', jsonList);
  }

  Future<void> _cacheUserInfo(UserInfoDto data) async {
    await StorageService.cacheData('userInfo_${_activeUserEmail ?? 'default'}', data.toJson());
  }

  Future<void> _cacheStudentIdCard(StudentIdCardDto data) async {
    await StorageService.cacheData('studentIdCard_${_activeUserEmail ?? 'default'}', data.toJson());
  }

  Future<void> _cacheSettings(List<SettingDto> data) async {
    final jsonList = data.map((item) => item.toJson()).toList();
    await StorageService.cacheData('settings_${_activeUserEmail ?? 'default'}', jsonList);
  }

  Future<void> _cacheAppInfo(Map<String, dynamic> data) async {
    const cacheKey = 'cache_appInfo';
    const timestampKey = 'cache_timestamp_appInfo';

    await StorageService.setString(cacheKey, jsonEncode(data));
    await StorageService.setString(timestampKey, DateTime.now().millisecondsSinceEpoch.toString());
  }

  Future<void> _cacheAbsenceNotices(List<Object> data) async {
    await StorageService.cacheData('absenceNotices_${_activeUserEmail ?? 'default'}', data);
  }

  Future<void> _cacheNotifications(List<Object> data) async {
    await StorageService.cacheData('notifications_${_activeUserEmail ?? 'default'}', data);
  }

  // Cache loading helper methods
  Future<List<AbsenceDto>?> _loadCachedAbsences() async {
    return await StorageService.getCachedListData<AbsenceDto>(
      'absences_${_activeUserEmail ?? 'default'}',
      (json) => AbsenceDto.fromJson(json),
    );
  }

  Future<List<GradeDto>?> _loadCachedGrades() async {
    return await StorageService.getCachedListData<GradeDto>(
      'grades_${_activeUserEmail ?? 'default'}',
      (json) => GradeDto.fromJson(json),
    );
  }

  Future<List<AgendaDto>?> _loadCachedAgenda() async {
    return await StorageService.getCachedListData<AgendaDto>(
      'agenda_${_activeUserEmail ?? 'default'}',
      (json) => AgendaDto.fromJson(json),
    );
  }

  Future<List<LatenessDto>?> _loadCachedLateness() async {
    return await StorageService.getCachedListData<LatenessDto>(
      'lateness_${_activeUserEmail ?? 'default'}',
      (json) => LatenessDto.fromJson(json),
    );
  }

  Future<UserInfoDto?> _loadCachedUserInfo() async {
    return await StorageService.getCachedData<UserInfoDto>(
      'userInfo_${_activeUserEmail ?? 'default'}',
      (json) => UserInfoDto.fromJson(json),
    );
  }

  Future<StudentIdCardDto?> _loadCachedStudentIdCard() async {
    return await StorageService.getCachedData<StudentIdCardDto>(
      'studentIdCard_${_activeUserEmail ?? 'default'}',
      (json) => StudentIdCardDto.fromJson(json),
    );
  }

  Future<List<SettingDto>?> _loadCachedSettings() async {
    return await StorageService.getCachedListData<SettingDto>(
      'settings_${_activeUserEmail ?? 'default'}',
      (json) => SettingDto.fromJson(json),
    );
  }

  Future<Map<String, dynamic>?> _loadCachedAppInfo() async {
    const cacheKey = 'cache_appInfo';
    const timestampKey = 'cache_timestamp_appInfo';

    final cachedData = await StorageService.getString(cacheKey);
    final timestampStr = await StorageService.getString(timestampKey);

    if (cachedData == null || timestampStr == null) return null;

    final timestamp = int.tryParse(timestampStr);
    if (timestamp == null) return null;

    final cacheAge = DateTime.now().millisecondsSinceEpoch - timestamp;
    if (cacheAge > const Duration(hours: 1).inMilliseconds) {
      return null;
    }

    try {
      final decoded = jsonDecode(cachedData);
      return decoded as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }


  // Auth method
  Future<bool> loginMobile(String email, String password) async {
    try {
      final result = await _apiService.authenticate(email, password);
      if (result is Map && result['access_token'] != null) {
        bearerToken = result['access_token'] as String;
        return true;
      }
    } catch (e) {
      // Handle error
    }
    return false;
  }

  // Load all data from cache first (for quick startup)
  Future<void> loadAllFromCache() async {
    await Future.wait([
      fetchAbsenceNotices(forceRefresh: false),
      fetchAbsences(forceRefresh: false),
      fetchAgenda(forceRefresh: false),
      fetchGrades(forceRefresh: false),
      fetchLateness(forceRefresh: false),
      fetchUserInfo(forceRefresh: false),
      fetchAppInfo(forceRefresh: false),
    ]);
  }

  // Fetch all data methods (with optional force refresh)
  Future<void> fetchAll({bool forceRefresh = true}) async {
    await Future.wait([
      fetchAbsenceNotices(forceRefresh: forceRefresh),
      fetchAbsences(forceRefresh: forceRefresh),
      fetchAgenda(forceRefresh: forceRefresh),
      fetchGrades(forceRefresh: forceRefresh),
      fetchLateness(forceRefresh: forceRefresh),
      fetchUserInfo(forceRefresh: forceRefresh),
      fetchAppInfo(forceRefresh: forceRefresh),
    ]);
  }

  // Future<void> fetchAbsenceNoticeStatus() async {
  //   try {
  //     absenceNoticeStatus = await _mobileApi.getMobileAbsenceNoticeStatusApiMobileAbsencenoticestatusGet();
  //     lastApiError = null;
  //   } on ApiException catch (e) {
  //     if (e.code == 403 && e.message != null && e.message!.contains('Not authenticated')) {
  //       lastApiError = 'Not authenticated';
  //     } else {
  //       lastApiError = e.toString();
  //     }
  //   }
  //   notifyListeners();
  // }

  // Future<void> fetchAbsenceNotices() async {
  //   try {
  //     absenceNotices = await _mobileApi.getMobileAbsenceNoticesApiMobileAbsencenoticesGet();
  //     lastApiError = null;
  //   } on ApiException catch (e) {
  //     if (e.code == 403 && e.message != null && e.message!.contains('Not authenticated')) {
  //       lastApiError = 'Not authenticated';
  //     } else {
  //       lastApiError = e.toString();
  //     }
  //   }
  //   notifyListeners();
  // }

  Future<void> fetchAbsences({bool forceRefresh = false}) async {
    // Try to load from cache first if not forcing refresh
    if (!forceRefresh) {
      final cachedData = await _loadCachedAbsences();
      if (cachedData != null) {
        absences = cachedData;
        lastApiError = null;
        notifyListeners();
        return;
      }
    }

    try {
      absences = await _apiService.getAbsences();
      if (absences != null) {
        await _cacheAbsences(absences!);
      }
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
      // If API fails and we don't have fresh data, try to load from cache as fallback
      if (absences == null) {
        final cachedData = await _loadCachedAbsences();
        if (cachedData != null) {
          absences = cachedData;
          // Don't clear lastApiError to show the user there was a network issue
        }
      }
    }
    notifyListeners();
  }

  Future<void> fetchLateness({bool forceRefresh = false}) async {
    // Try to load from cache first if not forcing refresh
    if (!forceRefresh) {
      final cachedData = await _loadCachedLateness();
      if (cachedData != null) {
        lateness = cachedData;
        lastApiError = null;
        notifyListeners();
        return;
      }
    }

    try {
      lateness = await _apiService.getLateness();
      if (lateness != null) {
        await _cacheLateness(lateness!);
      }
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
      // If API fails and we don't have fresh data, try to load from cache as fallback
      if (lateness == null) {
        final cachedData = await _loadCachedLateness();
        if (cachedData != null) {
          lateness = cachedData;
        }
      }
    }
    notifyListeners();
  }

  Future<void> fetchAbsenceNotices({bool forceRefresh = false}) async {
    try {
      absenceNotices = await _apiService.getAbsenceNotices();
      if (absenceNotices != null) {
        await _cacheAbsenceNotices(absenceNotices!);
      }
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
    }
    notifyListeners();
  }

  Future<void> fetchAgenda({bool forceRefresh = false}) async {
    // Try to load from cache first if not forcing refresh
    if (!forceRefresh) {
      final cachedData = await _loadCachedAgenda();
      if (cachedData != null) {
        agenda = cachedData;
        lastApiError = null;
        notifyListeners();
        return;
      }
    }

    try {
      agenda = await _apiService.getAgenda();
      if (agenda != null) {
        await _cacheAgenda(agenda!);
        // Schedule push notifications for agenda items if PushAssist is enabled
        await PushNotificationService.scheduleAgendaNotifications(agenda!);
      }
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
      // If API fails and we don't have fresh data, try to load from cache as fallback
      if (agenda == null) {
        final cachedData = await _loadCachedAgenda();
        if (cachedData != null) {
          agenda = cachedData;
        }
      }
    }
    notifyListeners();
  }

  // Future<void> fetchExams() async {
  //   try {
  //     exams = await _mobileApi.getMobileExamsApiMobileExamsGet();
  //     lastApiError = null;
  //   } on ApiException catch (e) {
  //     if (e.code == 403 && e.message != null && e.message!.contains('Not authenticated')) {
  //       lastApiError = 'Not authenticated';
  //     } else {
  //       lastApiError = e.toString();
  //     }
  //   }
  //   notifyListeners();
  // }

  Future<void> fetchGrades({bool forceRefresh = false}) async {
    // Try to load from cache first if not forcing refresh
    if (!forceRefresh) {
      final cachedData = await _loadCachedGrades();
      if (cachedData != null) {
        grades = cachedData;
        lastApiError = null;
        notifyListeners();
        return;
      }
    }

    try {
      grades = await _apiService.getGrades();
      if (grades != null) {
        await _cacheGrades(grades!);
      }
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
      // If API fails and we don't have fresh data, try to load from cache as fallback
      if (grades == null) {
        final cachedData = await _loadCachedGrades();
        if (cachedData != null) {
          grades = cachedData;
        }
      }
    }
    notifyListeners();
  }

  // Future<void> fetchLateness() async {
  //   try {
  //     lateness = await _mobileApi.getMobileLatenessApiMobileLatenessGet();
  //     lastApiError = null;
  //   } on ApiException catch (e) {
  //     if (e.code == 403 && e.message != null && e.message!.contains('Not authenticated')) {
  //       lastApiError = 'Not authenticated';
  //     } else {
  //       lastApiError = e.toString();
  //     }
  //   }
  //   notifyListeners();
  // }

  Future<void> fetchNotifications({bool forceRefresh = false}) async {
    try {
      notifications = await _apiService.getNotifications();
      if (notifications != null) {
        await _cacheNotifications(notifications!);
      }
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
    }
    notifyListeners();
  }

  // Future<void> fetchSettings() async {
  //   try {
  //     settings = await _mobileApi.getMobileSettingsApiMobileSettingsGet();
  //     lastApiError = null;
  //   } on ApiException catch (e) {
  //     if (e.code == 403 && e.message != null && e.message!.contains('Not authenticated')) {
  //       lastApiError = 'Not authenticated';
  //     } else {
  //       lastApiError = e.toString();
  //     }
  //   }
  //   notifyListeners();
  // }

  // Future<void> fetchTopics() async {
  //   try {
  //     topics = await _mobileApi.getMobileTopicsApiMobileTopicsGet();
  //     lastApiError = null;
  //   } on ApiException catch (e) {
  //     if (e.code == 403 && e.message != null && e.message!.contains('Not authenticated')) {
  //       lastApiError = 'Not authenticated';
  //     } else {
  //       lastApiError = e.toString();
  //     }
  //   }
  //   notifyListeners();
  // }

  Future<void> fetchUserInfo({bool forceRefresh = false}) async {
    // Try to load from cache first if not forcing refresh
    if (!forceRefresh) {
      final cachedData = await _loadCachedUserInfo();
      if (cachedData != null) {
        userInfo = cachedData;
        lastApiError = null;
        notifyListeners();
        return;
      }
    }

    try {
      userInfo = await _apiService.getUserInfo();
      if (userInfo != null) {
        await _cacheUserInfo(userInfo!);
      }
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
      // If API fails and we don't have fresh data, try to load from cache as fallback
      if (userInfo == null) {
        final cachedData = await _loadCachedUserInfo();
        if (cachedData != null) {
          userInfo = cachedData;
        }
      }
    }
    notifyListeners();
  }

  Future<void> fetchStudentIdCard({bool forceRefresh = false}) async {
    // Try to load from cache first if not forcing refresh
    if (!forceRefresh) {
      final cachedData = await _loadCachedStudentIdCard();
      if (cachedData != null) {
        studentIdCard = cachedData;
        lastApiError = null;
        notifyListeners();
        return;
      }
    }

    try {
      studentIdCard = await _apiService.getStudentIdCard(50505);
      if (studentIdCard != null) {
        await _cacheStudentIdCard(studentIdCard!);
      }
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
      // If API fails and we don't have fresh data, try to load from cache as fallback
      if (studentIdCard == null) {
        final cachedData = await _loadCachedStudentIdCard();
        if (cachedData != null) {
          studentIdCard = cachedData;
        }
      }
    }
    notifyListeners();
  }

  Future<void> fetchSettings({bool forceRefresh = false}) async {
    // Try to load from cache first if not forcing refresh
    if (!forceRefresh) {
      final cachedData = await _loadCachedSettings();
      if (cachedData != null) {
        settings = cachedData;
        lastApiError = null;
        notifyListeners();
        return;
      }
    }

    try {
      settings = await _apiService.getSettings();
      if (settings != null) {
        await _cacheSettings(settings!);
      }
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
      // If API fails and we don't have fresh data, try to load from cache as fallback
      if (settings == null) {
        final cachedData = await _loadCachedSettings();
        if (cachedData != null) {
          settings = cachedData;
        }
      }
    }
    notifyListeners();
  }

  Future<void> fetchAppInfo({bool forceRefresh = false}) async {
    // Try to load from cache first if not forcing refresh
    if (!forceRefresh) {
      final cachedData = await _loadCachedAppInfo();
      if (cachedData != null) {
        appInfo = cachedData;
        lastApiError = null;
        notifyListeners();
        return;
      }
    }

    try {
      final appApi = AppApi();
      // Get the raw HTTP response instead of trying to deserialize
      final httpResponse = await appApi.appAppInfoWithHttpInfo().timeout(Duration(seconds: 5));

      if (httpResponse.statusCode == 200) {
        // Manually parse the JSON response
        final responseBody = httpResponse.body;
        if (responseBody.isNotEmpty) {
          final jsonData = jsonDecode(responseBody);
          if (jsonData is Map<String, dynamic>) {
            appInfo = jsonData;
            await _cacheAppInfo(appInfo!);
          } else {
            appInfo = {'raw': jsonData.toString()};
            await _cacheAppInfo(appInfo!);
          }
        }
      }
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
      // If API fails and we don't have fresh data, try to load from cache as fallback
      if (appInfo == null) {
        final cachedData = await _loadCachedAppInfo();
        if (cachedData != null) {
          appInfo = cachedData;
        }
      }
    } catch (e) {
      lastApiError = e.toString();
      // If API fails and we don't have fresh data, try to load from cache as fallback
      if (appInfo == null) {
        final cachedData = await _loadCachedAppInfo();
        if (cachedData != null) {
          appInfo = cachedData;
        }
      }
    }
    notifyListeners();
  }

  // Refresh all data (for pull-to-refresh)
  Future<void> refreshAll() async {
    if (_activeUserEmail != null && _users[_activeUserEmail] != null) {
      await fetchAll(forceRefresh: true);
    }
  }

  // Clear all user data and tokens (logout)
  Future<void> clearAll() async {
    _users.clear();
    _activeUserEmail = null;
    bearerToken = null;
    _clearCurrentData();
    await StorageService.clearAll();
    notifyListeners();
  }

  // For multi-user: store tokens per user (simple example)
  final Map<String, String> _userTokens = {};
  void saveUserToken(String email, String token) {
    _userTokens[email] = token;
    notifyListeners();
  }
  String? getUserToken(String email) => _userTokens[email];
  String? lastApiError;
}
