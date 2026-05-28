import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/schulware_account.dart';
import 'api_client.dart';

/// App-wide source of truth for "which connected school account is the user
/// currently looking at". Listens-friendly via [ChangeNotifier] so the avatar,
/// the side sheet, and the dashboard can all rebuild from one place.
class ActiveAccountService extends ChangeNotifier {
  ActiveAccountService._();
  static final ActiveAccountService instance = ActiveAccountService._();

  static const _activeIdKey = 'accounts.active_id';

  List<SchulwareAccount> _accounts = const [];
  String? _activeId;
  bool _loading = false;
  Object? _error;

  List<SchulwareAccount> get accounts => _accounts;
  bool get loading => _loading;
  Object? get error => _error;

  SchulwareAccount? get active {
    if (_accounts.isEmpty) return null;
    if (_activeId != null) {
      for (final a in _accounts) {
        if (a.id == _activeId) return a;
      }
    }
    return _accounts.first;
  }

  Future<void> refresh() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final res = await ApiClient.instance.api
          .getAccountsApi()
          .apiPluginsSchulwareAccountsGet();
      final raw = res.data as List<dynamic>? ?? const [];
      _accounts = raw
          .cast<Map<String, dynamic>>()
          .map(SchulwareAccount.fromJson)
          .toList(growable: false);

      // Make sure the persisted active id still points at a real row.
      final prefs = await SharedPreferences.getInstance();
      final persisted = prefs.getString(_activeIdKey);
      if (persisted != null && _accounts.any((a) => a.id == persisted)) {
        _activeId = persisted;
      } else {
        _activeId = _accounts.isEmpty ? null : _accounts.first.id;
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

  Future<void> setActive(String accountId) async {
    if (_activeId == accountId) return;
    _activeId = accountId;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeIdKey, accountId);
    notifyListeners();
  }

  Future<void> clear() async {
    _accounts = const [];
    _activeId = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_activeIdKey);
    notifyListeners();
  }
}
