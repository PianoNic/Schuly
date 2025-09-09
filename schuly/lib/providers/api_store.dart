import 'package:flutter/material.dart';
import 'package:schuly/api/lib/api.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import 'dart:convert';

class ApiStore extends ChangeNotifier {
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
  // List<Object>? absenceNotices;
  List<AbsenceDto>? absences;
  StudentIdCardDto? studentIdCard;
  List<AgendaDto>? agenda;
  // List<ExamDto>? exams;
  List<GradeDto>? grades;
  // List<Object>? lateness;
  List<Object>? notifications;
  List<SettingDto>? settings;
  // List<Object>? topics;
  UserInfoDto? userInfo;

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
      await fetchAll();
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
      notifyListeners();
    }
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

  // Fetch all data methods
  Future<void> fetchAll() async {
  await Future.wait([
      // fetchAbsenceNoticeStatus(),
      // fetchAbsenceNotices(),
      fetchAbsences(),
      fetchAgenda(),
      // fetchExams(),
      fetchGrades(),
      // fetchLateness(),
      fetchNotifications(),
      fetchSettings(),
      // fetchTopics(),
      fetchUserInfo(),
      fetchStudentIdCard(),
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

  Future<void> fetchAbsences() async {
    try {
      absences = await _apiService.getAbsences();
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
    }
    notifyListeners();
  }

  Future<void> fetchAgenda() async {
    try {
      agenda = await _apiService.getAgenda();
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
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

  Future<void> fetchGrades() async {
    try {
      grades = await _apiService.getGrades();
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
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

  Future<void> fetchNotifications() async {
    try {
      notifications = await _apiService.getNotifications();
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

  Future<void> fetchUserInfo() async {
    try {
      userInfo = await _apiService.getUserInfo();
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
    }
    notifyListeners();
  }

  Future<void> fetchStudentIdCard() async {
    try {
      studentIdCard = await _apiService.getStudentIdCard(50505);
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
    }
    notifyListeners();
  }

  Future<void> fetchSettings() async {
    try {
      settings = await _apiService.getSettings();
      lastApiError = null;
    } on ApiException catch (e) {
      _handleApiError(e);
    }
    notifyListeners();
  }

  // Clear all user data and tokens (logout)
  Future<void> clearAll() async {
    _users.clear();
    _activeUserEmail = null;
    bearerToken = null;
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
