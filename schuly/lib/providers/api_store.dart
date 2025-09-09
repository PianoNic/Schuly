import 'package:flutter/material.dart';
import 'package:schuly/api/lib/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  // API instances
  final AuthorizationApi _authApi = AuthorizationApi();
  final MobileAPIApi _mobileApi = MobileAPIApi();

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
  // List<SettingDto>? settings;
  // List<Object>? topics;
  UserInfoDto? userInfo;

  // Secure storage
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // User model for storage
  static const _usersKey = 'users'; // JSON-encoded list of user emails
  static const _activeUserKey = 'active_user';
  static const _apiUrlKey = 'api_url';

  // In-memory user map: email -> {email, password, access_token, refresh_token, expires_at}
  Map<String, Map<String, dynamic>> _users = {};
  String? _activeUserEmail;

  String? get activeUserEmail => _activeUserEmail;
  List<String> get userEmails => _users.keys.toList();
  Map<String, dynamic>? get activeUser => _activeUserEmail != null ? _users[_activeUserEmail] : null;

  // On startup, load users from secure storage
  Future<void> loadUsers() async {
    final usersJson = await _secureStorage.read(key: _usersKey);
    final active = await _secureStorage.read(key: _activeUserKey);
    if (usersJson != null) {
      _users = Map<String, Map<String, dynamic>>.from(
        (Map<String, dynamic>.from(await _decodeJson(usersJson)))
      );
    }
    _activeUserEmail = active;
    if (_activeUserEmail != null && _users[_activeUserEmail] != null) {
      await _setAuthFromUser(_users[_activeUserEmail]!);
      // Fetch all data once after user is loaded
      await fetchAll();
    }
    notifyListeners();
  }

  // Add a user (login and store)
  Future<String?> addUser(String email, String password) async {
    print('[addUser] Attempting login for: ' + email);
    try {
      final response = await _authApi.authenticateMobileApiApiAuthenticateMobilePostWithHttpInfo(email, password);
      print('[addUser] API response: statusCode=${response.statusCode}, body=${response.body}');
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        try {
          final result = jsonDecode(response.body);
          print('[addUser] Decoded result: ' + result.toString());
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
              await _persistUsers();
              await _setAuthFromUser(_users[email]!);
              print('[addUser] User persisted and auth set.');
            } catch (storageError, stack) {
              print('[addUser] Error persisting user: ' + storageError.toString());
              print(stack);
              return 'Login succeeded but failed to persist user: ' + storageError.toString();
            }
            notifyListeners();
            return null; // Success
          } else {
            print('[addUser] No access_token in response.');
            return 'Login failed: No access_token in response. Body: \\${response.body}';
          }
        } catch (jsonError, stack) {
          print('[addUser] JSON decode error: ' + jsonError.toString());
          print(stack);
          return 'Login failed: JSON decode error: ' + jsonError.toString();
        }
      } else {
        print('[addUser] Login failed: statusCode=\\${response.statusCode}, body=\\${response.body}');
        return 'Login failed: statusCode=\\${response.statusCode}, body=\\${response.body}';
      }
    } catch (e, stack) {
      print('[addUser] Exception: ' + e.toString());
      print(stack);
      return 'Login error: ' + e.toString() + '\\n' + stack.toString();
    }
  }

  // Switch active user
  Future<void> switchUser(String email) async {
    if (_users.containsKey(email)) {
      _activeUserEmail = email;
      await _secureStorage.write(key: _activeUserKey, value: email);
      await _setAuthFromUser(_users[email]!);
      notifyListeners();
    }
  }

  // Remove a user
  Future<void> removeUser(String email) async {
    _users.remove(email);
    if (_activeUserEmail == email) {
      _activeUserEmail = _users.keys.isNotEmpty ? _users.keys.first : null;
      if (_activeUserEmail != null) {
        await _setAuthFromUser(_users[_activeUserEmail]!);
      } else {
        bearerToken = null;
      }
    }
    await _persistUsers();
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

  // Internal: persist users to secure storage
  Future<void> _persistUsers() async {
    await _secureStorage.write(key: _usersKey, value: await _encodeJson(_users));
    if (_activeUserEmail != null) {
      await _secureStorage.write(key: _activeUserKey, value: _activeUserEmail);
    }
  }

  // Helpers for JSON encoding/decoding
  Future<String> _encodeJson(Map<String, dynamic> data) async => Future.value(jsonEncode(data));
  Future<Map<String, dynamic>> _decodeJson(String data) async => Future.value(Map<String, dynamic>.from(jsonDecode(data)));

  // Auth method
  Future<bool> loginMobile(String email, String password) async {
    try {
      final result = await _authApi.authenticateMobileApiApiAuthenticateMobilePost(email, password);
      // Expecting a map with a bearer token
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
      // fetchSettings(),
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
      absences = await _mobileApi.getMobileAbsencesApiMobileAbsencesGet();
      lastApiError = null;
    } on ApiException catch (e) {
      if (e.code == 403 && e.message != null && e.message!.contains('Not authenticated')) {
        lastApiError = 'Not authenticated';
      } else {
        lastApiError = e.toString();
      }
    }
    notifyListeners();
  }

  Future<void> fetchAgenda() async {
    try {
      agenda = await _mobileApi.getMobileEventsApiMobileAgendaGet();
      lastApiError = null;
    } on ApiException catch (e) {
      if (e.code == 403 && e.message != null && e.message!.contains('Not authenticated')) {
        lastApiError = 'Not authenticated';
      } else {
        lastApiError = e.toString();
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

  Future<void> fetchGrades() async {
    try {
      grades = await _mobileApi.getMobileGradesApiMobileGradesGet();
      lastApiError = null;
    } on ApiException catch (e) {
      if (e.code == 403 && e.message != null && e.message!.contains('Not authenticated')) {
        lastApiError = 'Not authenticated';
      } else {
        lastApiError = e.toString();
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

  Future<void> fetchNotifications() async {
    try {
      notifications = await _mobileApi.getMobileNotificationsApiMobileNotificationsGet();
      lastApiError = null;
    } on ApiException catch (e) {
      if (e.code == 403 && e.message != null && e.message!.contains('Not authenticated')) {
        lastApiError = 'Not authenticated';
      } else {
        lastApiError = e.toString();
      }
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
      userInfo = await _mobileApi.getMobileUserInfoApiMobileUserInfoGet();
      lastApiError = null;
    } on ApiException catch (e) {
      if (e.code == 403 && e.message != null && e.message!.contains('Not authenticated')) {
        lastApiError = 'Not authenticated';
      } else {
        lastApiError = e.toString();
      }
    }
    notifyListeners();
  }

  Future<void> fetchStudentIdCard() async {
    try {
      studentIdCard = await _mobileApi.getMobileCockpitReportApiMobileStudentidcardReportIdGet(50505);
      lastApiError = null;
    } on ApiException catch (e) {
      if (e.code == 403 && e.message != null && e.message!.contains('Not authenticated')) {
        lastApiError = 'Not authenticated';
      } else {
        lastApiError = e.toString();
      }
    }
    notifyListeners();
  }

  // Clear all user data and tokens (logout)
  Future<void> clearAll() async {
    _users.clear();
    _activeUserEmail = null;
    bearerToken = null;
    await _secureStorage.deleteAll();
    // Optionally clear API URL as well
    await _secureStorage.delete(key: _apiUrlKey);
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
