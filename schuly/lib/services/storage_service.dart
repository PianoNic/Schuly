import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class StorageService {
  static const _storage = FlutterSecureStorage();
  
  static const String _usersKey = 'users';
  static const String _activeUserKey = 'active_user';
  static const String _apiUrlKey = 'api_url';
  static const String _pushNotificationsKey = 'push_notifications_enabled';
  static const String _notificationAdvanceMinutesKey = 'notification_advance_minutes';
  static const String _notificationTypePrefix = 'notification_enabled_';
  static const String _languageKey = 'selected_language';
  static const String _userCookiesPrefix = 'user_cookies_';

  // Cache keys for API data
  static const String _cachePrefix = 'cache_';
  static const String _cacheTimestampPrefix = 'cache_timestamp_';
  static const Duration _cacheValidDuration = Duration(hours: 1);

  static Future<void> saveUser(String email, Map<String, dynamic> userData) async {
    final users = await getUsers();
    users[email] = userData;
    await _storage.write(key: _usersKey, value: jsonEncode(users));
  }

  static Future<Map<String, Map<String, dynamic>>> getUsers() async {
    final usersJson = await _storage.read(key: _usersKey);
    if (usersJson == null) return {};
    
    final decoded = jsonDecode(usersJson) as Map<String, dynamic>;
    return decoded.map((key, value) => 
      MapEntry(key, Map<String, dynamic>.from(value)));
  }

  static Future<void> removeUser(String email) async {
    final users = await getUsers();
    users.remove(email);
    await _storage.write(key: _usersKey, value: jsonEncode(users));
  }

  static Future<String?> getActiveUser() async {
    return await _storage.read(key: _activeUserKey);
  }

  static Future<void> setActiveUser(String? email) async {
    if (email != null) {
      await _storage.write(key: _activeUserKey, value: email);
    } else {
      await _storage.delete(key: _activeUserKey);
    }
  }

  static Future<String?> getApiUrl() async {
    return await _storage.read(key: _apiUrlKey);
  }

  static Future<void> setApiUrl(String url) async {
    await _storage.write(key: _apiUrlKey, value: url);
  }

  // Push notification settings
  static Future<void> setPushNotificationsEnabled(bool enabled) async {
    await _storage.write(key: _pushNotificationsKey, value: enabled.toString());
  }
  
  static Future<bool> getPushNotificationsEnabled() async {
    final value = await _storage.read(key: _pushNotificationsKey);
    // Default to false if not set (changed from true)
    return value?.toLowerCase() == 'true';
  }

  // Notification type settings
  static Future<void> setNotificationEnabled(String type, bool enabled) async {
    await _storage.write(key: '$_notificationTypePrefix$type', value: enabled.toString());
  }
  
  static Future<bool?> getNotificationEnabled(String type) async {
    final value = await _storage.read(key: '$_notificationTypePrefix$type');
    if (value == null) return null;
    return value.toLowerCase() == 'true';
  }

  // Notification advance time settings
  static Future<void> setNotificationAdvanceMinutes(int minutes) async {
    await _storage.write(key: _notificationAdvanceMinutesKey, value: minutes.toString());
  }
  
  static Future<int?> getNotificationAdvanceMinutes() async {
    final value = await _storage.read(key: _notificationAdvanceMinutesKey);
    if (value == null) return null;
    return int.tryParse(value);
  }

  // Generic string methods for release notes
  static Future<void> setString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }

  // Language settings
  static Future<void> setLanguage(String languageCode) async {
    await _storage.write(key: _languageKey, value: languageCode);
  }

  static Future<String?> getLanguage() async {
    return await _storage.read(key: _languageKey);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Cache management methods
  static Future<void> cacheData(String key, dynamic data) async {
    final cacheKey = '$_cachePrefix$key';
    final timestampKey = '$_cacheTimestampPrefix$key';

    await _storage.write(key: cacheKey, value: jsonEncode(data));
    await _storage.write(key: timestampKey, value: DateTime.now().millisecondsSinceEpoch.toString());
  }

  static Future<T?> getCachedData<T>(String key, T? Function(Map<String, dynamic>) fromJson) async {
    final cacheKey = '$_cachePrefix$key';
    final timestampKey = '$_cacheTimestampPrefix$key';

    final cachedData = await _storage.read(key: cacheKey);
    final timestampStr = await _storage.read(key: timestampKey);

    if (cachedData == null || timestampStr == null) return null;

    final timestamp = int.tryParse(timestampStr);
    if (timestamp == null) return null;

    final cacheAge = DateTime.now().millisecondsSinceEpoch - timestamp;
    if (cacheAge > _cacheValidDuration.inMilliseconds) {
      // Cache expired, remove it
      await _storage.delete(key: cacheKey);
      await _storage.delete(key: timestampKey);
      return null;
    }

    try {
      final decoded = jsonDecode(cachedData);
      if (decoded is Map<String, dynamic>) {
        return fromJson(decoded);
      }
      return decoded as T?;
    } catch (e) {
      // Invalid cache data, remove it
      await _storage.delete(key: cacheKey);
      await _storage.delete(key: timestampKey);
      return null;
    }
  }

  static Future<List<T>?> getCachedListData<T>(String key, T? Function(Map<String, dynamic>) fromJson) async {
    final cacheKey = '$_cachePrefix$key';
    final timestampKey = '$_cacheTimestampPrefix$key';

    final cachedData = await _storage.read(key: cacheKey);
    final timestampStr = await _storage.read(key: timestampKey);

    if (cachedData == null || timestampStr == null) return null;

    final timestamp = int.tryParse(timestampStr);
    if (timestamp == null) return null;

    final cacheAge = DateTime.now().millisecondsSinceEpoch - timestamp;
    if (cacheAge > _cacheValidDuration.inMilliseconds) {
      // Cache expired, remove it
      await _storage.delete(key: cacheKey);
      await _storage.delete(key: timestampKey);
      return null;
    }

    try {
      final decoded = jsonDecode(cachedData);
      if (decoded is List) {
        final result = <T>[];
        for (final item in decoded) {
          final parsed = fromJson(item as Map<String, dynamic>);
          if (parsed != null) {
            result.add(parsed);
          }
        }
        return result.isEmpty ? null : result;
      }
      return null;
    } catch (e) {
      // Invalid cache data, remove it
      await _storage.delete(key: cacheKey);
      await _storage.delete(key: timestampKey);
      return null;
    }
  }

  static Future<bool> isCacheValid(String key) async {
    final timestampKey = '$_cacheTimestampPrefix$key';
    final timestampStr = await _storage.read(key: timestampKey);

    if (timestampStr == null) return false;

    final timestamp = int.tryParse(timestampStr);
    if (timestamp == null) return false;

    final cacheAge = DateTime.now().millisecondsSinceEpoch - timestamp;
    return cacheAge <= _cacheValidDuration.inMilliseconds;
  }

  static Future<void> clearCache() async {
    final allKeys = await _storage.readAll();
    final cacheKeys = allKeys.keys.where((key) =>
      key.startsWith(_cachePrefix) || key.startsWith(_cacheTimestampPrefix));

    for (final key in cacheKeys) {
      await _storage.delete(key: key);
    }
  }

  // Permission dialog tracking
  static const String _hasShownPermissionDialogKey = 'has_shown_permission_dialog';

  static Future<bool> getHasShownPermissionDialog() async {
    final value = await _storage.read(key: _hasShownPermissionDialogKey);
    return value == 'true';
  }

  static Future<void> setHasShownPermissionDialog(bool shown) async {
    await _storage.write(key: _hasShownPermissionDialogKey, value: shown.toString());
  }

  // Cookie management for Microsoft OAuth sessions
  static Future<void> saveUserCookies(String email, List<Map<String, dynamic>> cookies) async {
    final key = '$_userCookiesPrefix$email';
    await _storage.write(key: key, value: jsonEncode(cookies));
  }

  static Future<List<Map<String, dynamic>>?> getUserCookies(String email) async {
    final key = '$_userCookiesPrefix$email';
    final cookiesJson = await _storage.read(key: key);
    if (cookiesJson != null) {
      final decoded = jsonDecode(cookiesJson);
      if (decoded is List) {
        return decoded.cast<Map<String, dynamic>>();
      }
    }
    return null;
  }

  static Future<void> clearUserCookies(String email) async {
    final key = '$_userCookiesPrefix$email';
    await _storage.delete(key: key);
  }
}