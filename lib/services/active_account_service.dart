import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/schulware_account.dart';
import 'api_client.dart';

/// App-wide source of truth for "which connected school is the user currently
/// looking at". Backed by `GET /api/schools/my-schools`. Listens-friendly via
/// [ChangeNotifier] so the avatar, the side sheet, and the dashboard rebuild
/// from one place.
class ActiveAccountService extends ChangeNotifier {
  ActiveAccountService._();
  static final ActiveAccountService instance = ActiveAccountService._();

  static const _activeIdKey = 'accounts.active_id';

  List<MySchool> _schools = const [];
  String? _activeId;
  bool _loading = false;
  Object? _error;

  List<MySchool> get schools => _schools;
  bool get loading => _loading;
  Object? get error => _error;

  MySchool? get active {
    if (_schools.isEmpty) return null;
    if (_activeId != null) {
      for (final s in _schools) {
        if (s.id == _activeId) return s;
      }
    }
    return _schools.first;
  }

  Future<void> refresh() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final res = await ApiClient.instance.api
          .getSchoolsApi()
          .apiSchoolsMySchoolsGet();
      final data = res.data;
      _schools = data == null
          ? const []
          : data.map(MySchool.fromDto).toList(growable: false);

      // Keep the persisted active id only if it still resolves to a school.
      final prefs = await SharedPreferences.getInstance();
      final persisted = prefs.getString(_activeIdKey);
      if (persisted != null && _schools.any((s) => s.id == persisted)) {
        _activeId = persisted;
      } else {
        _activeId = _schools.isEmpty ? null : _schools.first.id;
        if (_activeId != null) {
          await prefs.setString(_activeIdKey, _activeId!);
        } else {
          await prefs.remove(_activeIdKey);
        }
      }
    } catch (e) {
      _error = e;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> setActive(String id) async {
    if (_activeId == id) return;
    _activeId = id;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeIdKey, id);
    notifyListeners();
  }

  Future<void> clear() async {
    _schools = const [];
    _activeId = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_activeIdKey);
    notifyListeners();
  }
}
