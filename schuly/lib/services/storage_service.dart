import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class StorageService {
  static const _storage = FlutterSecureStorage();
  
  static const String _usersKey = 'users';
  static const String _activeUserKey = 'active_user';
  static const String _apiUrlKey = 'api_url';
  static const String _pushNotificationsKey = 'push_notifications_enabled';

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
    // Default to true if not set
    return value?.toLowerCase() == 'true' || value == null;
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}