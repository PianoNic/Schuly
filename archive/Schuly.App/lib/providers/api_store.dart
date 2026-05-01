import 'package:flutter/material.dart';
import 'package:schuly/api/lib/api.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../services/push_notification_service.dart';
import '../utils/logger.dart';
import '../utils/error_handler.dart';
import '../utils/grade_utils.dart';
import 'dart:convert';
import 'dart:async';

class ApiStore extends ChangeNotifier {
  // Initialization state
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  bool _isOfflineMode = false;
  bool get isOfflineMode => _isOfflineMode;

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
  List<ExamDto>? exams;
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

  // Agenda view preference
  bool _isAgendaListView = false;
  bool get isAgendaListView => _isAgendaListView;

  void setAgendaView(bool isListView) async {
    _isAgendaListView = isListView;
    await StorageService.setAgendaViewPreference(isListView);
    notifyListeners();
  }

  // Grade display mode
  GradeDisplayMode _gradeDisplayMode = GradeDisplayMode.exact;
  GradeDisplayMode get gradeDisplayMode => _gradeDisplayMode;

  void setGradeDisplayMode(GradeDisplayMode mode) {
    _gradeDisplayMode = mode;
    notifyListeners();
  }

  // Grade color settings
  bool _useGradeColors = true;
  double _gradeRedThreshold = 4.0;
  double _gradeYellowThreshold = 5.0;

  bool get useGradeColors => _useGradeColors;
  double get gradeRedThreshold => _gradeRedThreshold;
  double get gradeYellowThreshold => _gradeYellowThreshold;

  void setUseGradeColors(bool enabled) {
    _useGradeColors = enabled;
    notifyListeners();
  }

  void setGradeColorThresholds(double redThreshold, double yellowThreshold) {
    _gradeRedThreshold = redThreshold;
    _gradeYellowThreshold = yellowThreshold;
    notifyListeners();
  }

  // Flashy animations for perfect grades
  bool _enableFlashyAnimations = true;
  bool get enableFlashyAnimations => _enableFlashyAnimations;

  void setEnableFlashyAnimations(bool enabled) {
    _enableFlashyAnimations = enabled;
    notifyListeners();
  }

  // Microsoft re-authentication needed flag
  bool _needsMicrosoftReAuth = false;
  bool get needsMicrosoftReAuth => _needsMicrosoftReAuth;

  void clearMicrosoftReAuthFlag() {
    _needsMicrosoftReAuth = false;
    notifyListeners();
  }

  // Update Microsoft user after re-authentication
  Future<void> updateMicrosoftUserTokens(String accessToken, String refreshToken) async {
    if (_activeUserEmail == null) return;

    final user = _users[_activeUserEmail];
    if (user == null || user['is_microsoft_auth'] != true) return;

    // Update tokens and expiry
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    user['access_token'] = accessToken;
    user['refresh_token'] = refreshToken;
    user['expires_at'] = now + 3600; // 1 hour expiry

    // Save and update auth
    await StorageService.saveUser(_activeUserEmail!, user);
    await _setAuthFromUser(user);

    // Clear the re-auth flag
    _needsMicrosoftReAuth = false;

    logInfo('Microsoft user tokens updated successfully', source: 'ApiStore');
    notifyListeners();
  }

  // Check if API endpoint is reachable
  Future<bool> _checkApiConnectivity() async {
    try {
      // Try to fetch app info with a short timeout
      logDebug('Checking API connectivity by fetching app info', source: 'ApiStore');

      final appApi = AppApi(defaultApiClient);

      // Try to get app info with a 5 second timeout
      final response = await appApi.appAppInfoWithHttpInfo().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          logWarning('API connectivity check timed out after 5 seconds', source: 'ApiStore');
          throw TimeoutException('API connectivity check timed out');
        },
      );

      // Consider API reachable if we get a successful response
      final isReachable = response.statusCode >= 200 && response.statusCode < 300;
      logDebug('API connectivity check result: $isReachable (status: ${response.statusCode})', source: 'ApiStore');

      // If reachable and successful, also cache the app info
      if (isReachable && response.body.isNotEmpty && response.statusCode != 204) {
        try {
          final appInfoDto = await defaultApiClient.deserializeAsync(
            response.body,
            'AppInfoDto',
          ) as AppInfoDto?;

          if (appInfoDto != null) {
            // Store the app info
            appInfo = {
              'version': appInfoDto.version,
              'environment': appInfoDto.environment,
            };

            // Cache it
            await _cacheAppInfo(appInfo!);
            notifyListeners();
          }
        } catch (e) {
          logDebug('Failed to parse app info during connectivity check', source: 'ApiStore');
        }
      }

      return isReachable;
    } catch (e) {
      logWarning('API connectivity check failed: $e', source: 'ApiStore');
      return false;
    }
  }

  // In-memory user map: email -> {email, password, access_token, refresh_token, expires_at}
  Map<String, Map<String, dynamic>> _users = {};
  String? _activeUserEmail;

  String? get activeUserEmail => _activeUserEmail;
  List<String> get userEmails => _users.keys.toList();
  Map<String, dynamic>? get activeUser => _activeUserEmail != null ? _users[_activeUserEmail] : null;
  Map<String, Map<String, dynamic>> get users => _users;

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
      // Load users first
      await loadUsers();

      // Load agenda view preference
      _isAgendaListView = await StorageService.getAgendaViewPreference();

      // Load grade display mode preference
      final gradeMode = await StorageService.getGradeDisplayMode();
      switch (gradeMode) {
        case 'rounded':
          _gradeDisplayMode = GradeDisplayMode.rounded;
          break;
        case 'both':
          _gradeDisplayMode = GradeDisplayMode.both;
          break;
        default:
          _gradeDisplayMode = GradeDisplayMode.exact;
      }

      // Load grade color settings
      _useGradeColors = await StorageService.getUseGradeColors();
      _gradeRedThreshold = await StorageService.getGradeRedThreshold();
      _gradeYellowThreshold = await StorageService.getGradeYellowThreshold();

      // Load flashy animations preference
      _enableFlashyAnimations = await StorageService.getEnableFlashyAnimations();

      // Check if API is reachable (with 5 second timeout)
      final isApiReachable = await _checkApiConnectivity();

      if (isApiReachable) {
        // API is reachable - online mode
        _isOfflineMode = false;

        // Load cached data first for instant UI
        if (_activeUserEmail != null && _users[_activeUserEmail] != null) {
          await _loadCachedDataOnly();
        }

        // Then authenticate and fetch fresh data in background
        await autoLoginIfNeeded();
        if (_activeUserEmail != null && _users[_activeUserEmail] != null) {
          fetchAll(forceRefresh: true).catchError((e) {
            logDebug('[initialize] Background fetch error: $e', source: 'ApiStore');
          });
        }
      } else {
        // API is not reachable - offline mode
        _isOfflineMode = true;
        logInfo('API not reachable, using offline mode with cached data', source: 'ApiStore');

        // Load only cached data
        if (_activeUserEmail != null && _users[_activeUserEmail] != null) {
          await _loadCachedDataOnly();
        }
      }

      _isInitialized = true;
    } catch (e) {
      logError('[initialize] Error during initialization: $e', source: 'ApiStore');
      _isOfflineMode = true; // Assume offline if there's an error
      _isInitialized = true; // Still mark as initialized to show the app
    }
    notifyListeners();
  }

  // Add a Microsoft OAuth user
  Future<String?> addMicrosoftUser(String accessToken, String refreshToken, [String? knownEmail]) async {
    logDebug('Storing Microsoft OAuth tokens', source: 'ApiStore.addMicrosoftUser');

    final transaction = Sentry.startTransaction(
      'authenticate.microsoft.store',
      'app.auth',
    );
    transaction.setData('description', 'Store Microsoft user tokens');

    try {
      // Set the bearer token first
      bearerToken = accessToken;

      String email;
      if (knownEmail != null && knownEmail.isNotEmpty) {
        email = knownEmail;
      } else {
        // Try to fetch user info to get email
        await fetchUserInfo();

        if (userInfo == null || (userInfo!.email ?? '').isEmpty) {
          return 'Failed to get user information from Microsoft token';
        }
        email = userInfo!.email ?? '';
      }
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      // Store user with Microsoft auth flag
      _users[email] = {
        'email': email,
        'password': '', // No password for OAuth users
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'token_type': 'Bearer',
        'expires_at': now + 3600, // Default 1 hour expiry
        'is_microsoft_auth': true, // Flag to indicate Microsoft auth
      };

      _activeUserEmail = email;

      try {
        await StorageService.saveUser(email, _users[email]!);
        await StorageService.setActiveUser(email);
        await _setAuthFromUser(_users[email]!);
        logDebug('Microsoft user persisted and auth set', source: 'ApiStore.addMicrosoftUser');

        transaction.status = const SpanStatus.ok();
      } catch (storageError, stack) {
        logError('Error persisting user', source: 'ApiStore.addMicrosoftUser', error: storageError, stackTrace: stack);
        transaction.status = const SpanStatus.internalError();
        transaction.throwable = storageError;
        await transaction.finish();
        return 'Login succeeded but failed to persist user: $storageError';
      }

      await transaction.finish();
      notifyListeners();
      return null; // Success
    } catch (e, stack) {
      logError('Exception in addMicrosoftUser', source: 'ApiStore', error: e, stackTrace: stack);
      transaction.status = const SpanStatus.internalError();
      transaction.throwable = e;
      await transaction.finish();
      return 'Microsoft login error: $e';
    }
  }

  // Add a user (login and store)
  Future<String?> addUser(String email, String password) async {
    logDebug('Attempting login for: $email', source: 'ApiStore.addUser');
    try {
      final response = await _apiService.authenticateWithResponse(email, password);
      logDebug('API response: statusCode=${response.statusCode}, body=${response.body}', source: 'ApiStore.addUser');
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        try {
          final result = jsonDecode(response.body);
          logDebug('Decoded result: $result', source: 'ApiStore.addUser');
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
              logDebug('User persisted and auth set', source: 'ApiStore.addUser');
            } catch (storageError, stack) {
              logError('Error persisting user', source: 'ApiStore.addUser', error: storageError, stackTrace: stack);
              return 'Login succeeded but failed to persist user: $storageError';
            }
            notifyListeners();
            return null; // Success
          } else {
            logWarning('No access_token in response', source: 'ApiStore.addUser');
            return 'Login failed: No access_token in response. Body: \\${response.body}';
          }
        } catch (jsonError, stack) {
          logError('JSON decode error', source: 'ApiStore.addUser', error: jsonError, stackTrace: stack);
          return 'Login failed: JSON decode error: $jsonError';
        }
      } else {
        logWarning('Login failed: statusCode=${response.statusCode}, body=${response.body}', source: 'ApiStore.addUser');
        return 'Login failed: statusCode=\\${response.statusCode}, body=\\${response.body}';
      }
    } catch (e, stack) {
      logError('Exception in addUser', source: 'ApiStore', error: e, stackTrace: stack);
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
    // Check if this is a Microsoft user before removing
    final user = _users[email];
    final isMicrosoftUser = user?['is_microsoft_auth'] == true;

    _users.remove(email);
    await StorageService.removeUser(email);

    if (_activeUserEmail == email) {
      // If removing a Microsoft user and no other users, clear WebView cookies
      if (isMicrosoftUser && _users.isEmpty) {
        logInfo('Clearing WebView cookies after removing last Microsoft user', source: 'ApiStore');
        await WebViewCookieManager().clearCookies();
      }

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
      // Token expired
      if (user['is_microsoft_auth'] == true) {
        // Microsoft user - set flag for re-authentication
        logInfo('Microsoft user token expired, needs re-authentication', source: 'ApiStore');
        _needsMicrosoftReAuth = true;
        notifyListeners();
        // Still set the expired token so the user can be identified
        await _setAuthFromUser(user);
      } else {
        // Regular user - re-login with password
        await addUser(user['email'], user['password']);
      }
    } else {
      await _setAuthFromUser(user);
    }
  }

  // Internal: set bearer token from user
  Future<void> _setAuthFromUser(Map<String, dynamic> user) async {
    bearerToken = user['access_token'];

    // Set user context for error tracking
    ErrorHandler.setUserContext(
      email: user['email'],
      extras: {
        'is_microsoft_auth': user['is_microsoft_auth'] ?? false,
      },
    );
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

  Future<void> _cacheExams(List<ExamDto> data) async {
    final jsonList = data.map((item) => item.toJson()).toList();
    await StorageService.cacheData('exams_${_activeUserEmail ?? 'default'}', jsonList);
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

  Future<List<ExamDto>?> _loadCachedExams() async {
    return await StorageService.getCachedListData<ExamDto>(
      'exams_${_activeUserEmail ?? 'default'}',
      (json) => ExamDto.fromJson(json),
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
      if (result != null && result.accessToken != null) {
        bearerToken = result.accessToken;
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

  // Load only cached data without any API calls
  Future<void> _loadCachedDataOnly() async {
    // Load cached data directly without going through fetch methods
    // This avoids any potential API calls
    final futures = <Future>[];

    futures.add(_loadCachedAbsences().then((data) {
      if (data != null) absences = data;
    }));

    futures.add(_loadCachedGrades().then((data) {
      if (data != null) grades = data;
    }));

    futures.add(_loadCachedAgenda().then((data) {
      if (data != null) agenda = data;
    }));

    futures.add(_loadCachedExams().then((data) {
      if (data != null) exams = data;
    }));

    futures.add(_loadCachedLateness().then((data) {
      if (data != null) lateness = data;
    }));

    futures.add(_loadCachedUserInfo().then((data) {
      if (data != null) userInfo = data;
    }));

    futures.add(_loadCachedStudentIdCard().then((data) {
      if (data != null) studentIdCard = data;
    }));

    futures.add(_loadCachedSettings().then((data) {
      if (data != null) settings = data;
    }));

    futures.add(_loadCachedAppInfo().then((data) {
      if (data != null) appInfo = data;
    }));

    await Future.wait(futures);
    notifyListeners();
  }

  // Fetch all data methods (with optional force refresh)
  Future<void> fetchAll({bool forceRefresh = true}) async {
    await ErrorHandler.handleAsync(
      () async {
        await Future.wait([
          fetchAbsenceNotices(forceRefresh: forceRefresh),
          fetchAbsences(forceRefresh: forceRefresh),
          fetchAgenda(forceRefresh: forceRefresh),
          fetchGrades(forceRefresh: forceRefresh),
          fetchExams(forceRefresh: forceRefresh),
          fetchLateness(forceRefresh: forceRefresh),
          fetchUserInfo(forceRefresh: forceRefresh),
          fetchAppInfo(forceRefresh: forceRefresh),
        ]);
      },
      operationName: 'fetchAll',
      showSnackbar: false, // Don't show snackbar for background fetches
    );
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
    } on ApiException catch (e, stackTrace) {
      _handleApiError(e);
      // Send to Sentry/GlitchTip
      await ErrorHandler.handleApiError(
        e,
        stackTrace: stackTrace,
        endpoint: 'getAbsences',
        statusCode: e.code,
      );
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

  Future<void> fetchExams({bool forceRefresh = false}) async {
    // Try to load from cache first if not forcing refresh
    if (!forceRefresh) {
      final cachedData = await _loadCachedExams();
      if (cachedData != null) {
        exams = cachedData;
        lastApiError = null;
        notifyListeners();
        return;
      }
    }

    try {
      exams = await _apiService.getExams();
      if (exams != null) {
        await _cacheExams(exams!);
      }
      lastApiError = null;
    } on ApiException catch (e, stackTrace) {
      _handleApiError(e);
      // Send to Sentry/GlitchTip
      await ErrorHandler.handleApiError(
        e,
        stackTrace: stackTrace,
        endpoint: 'getExams',
        statusCode: e.code,
      );
      // If API fails and we don't have fresh data, try to load from cache as fallback
      if (exams == null) {
        final cachedData = await _loadCachedExams();
        if (cachedData != null) {
          exams = cachedData;
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
      // If no cached data and not forcing refresh, don't try to fetch from API
      // This prevents blocking when loading cache during offline mode
      if (_isOfflineMode) {
        notifyListeners();
        return;
      }
    }

    try {
      final appApi = AppApi();
      // Get the raw HTTP response instead of trying to deserialize
      final httpResponse = await appApi.appAppInfoWithHttpInfo().timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          throw TimeoutException('App info fetch timed out');
        },
      );

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
    // Check if any Microsoft users exist before clearing
    final hasMicrosoftUsers = _users.values.any((user) => user['is_microsoft_auth'] == true);

    _users.clear();
    _activeUserEmail = null;
    bearerToken = null;
    _clearCurrentData();
    await StorageService.clearAll();

    // Clear user context from error tracking
    ErrorHandler.clearUserContext();

    // Clear WebView cookies if there were any Microsoft users
    if (hasMicrosoftUsers) {
      logInfo('Clearing WebView cookies on logout', source: 'ApiStore');
      await WebViewCookieManager().clearCookies();
    }

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
