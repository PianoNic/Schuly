import 'package:flutter/foundation.dart';
import 'package:schuly_api/schuly_api.dart';
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
      final api = ApiClient.instance.api;
      final res = await api.getSchoolsApi().apiSchoolsMySchoolsGet();
      final data = res.data;

      final pluginBySchoolId = await _detectPluginAccounts();
      _schools = data == null
          ? const []
          : data.map((dto) {
              final info = pluginBySchoolId[dto.id];
              return MySchool.fromDto(dto,
                  provider: info?.provider ?? 'schulnetz',
                  pluginAccountId: info?.accountId);
            }).toList(growable: false);

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

  /// Maps schoolId → (provider, plugin account id) by cross-referencing each
  /// plugin's accounts (which expose `schoolUserId` + `id`) against the user's
  /// SchoolUsers. Best-effort: returns an empty map on any failure so the
  /// account list still loads.
  Future<Map<String, ({String provider, String accountId})>> _detectPluginAccounts() async {
    try {
      final api = ApiClient.instance.api;
      final me = await api.getAuthApi().apiAuthMeGet();
      final appUserId = me.data?.id;
      if (appUserId == null) return const {};

      final usersRes =
          await api.getSchoolUsersApi().apiSchoolUsersGet(applicationUserId: appUserId);
      final schoolIdByUser = <String, String>{
        for (final u in (usersRes.data ?? const <SchoolUserDto>[]))
          if (u.id != null && u.schoolId != null) u.id!: u.schoolId!,
      };

      final out = <String, ({String provider, String accountId})>{};
      void mapAccounts(List<dynamic> accounts, String provider) {
        for (final a in accounts.cast<Map<String, dynamic>>()) {
          final suId = a['schoolUserId'] as String?;
          final accId = a['id'] as String?;
          final schoolId = suId == null ? null : schoolIdByUser[suId];
          if (schoolId != null && accId != null) {
            out[schoolId] = (provider: provider, accountId: accId);
          }
        }
      }

      final oda = await api.getAccountsApi().apiPluginsOdaorgAccountsGet();
      mapAccounts((oda.data as List<dynamic>?) ?? const [], 'odaorg');
      final schul = await api.getAccountsApi().apiPluginsSchulwareAccountsGet();
      mapAccounts((schul.data as List<dynamic>?) ?? const [], 'schulnetz');
      return out;
    } catch (_) {
      return const {};
    }
  }

  Future<void> setActive(String id) async {
    if (_activeId == id) return;
    _activeId = id;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeIdKey, id);
    notifyListeners();
  }

  /// Disconnects a connected school via its plugin's DELETE endpoint, then
  /// reloads the account list (which reselects an active school).
  Future<void> removeSchool(MySchool school) async {
    final accountId = school.pluginAccountId;
    if (accountId == null) return;
    final accounts = ApiClient.instance.api.getAccountsApi();
    if (school.provider == 'odaorg') {
      await accounts.apiPluginsOdaorgAccountsAccountIdDelete(accountId: accountId);
    } else {
      await accounts.apiPluginsSchulwareAccountsAccountIdDelete(accountId: accountId);
    }
    // If we removed the active school, drop the selection so refresh picks a new one.
    if (_activeId == school.id) {
      _activeId = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_activeIdKey);
    }
    await refresh();
  }

  Future<void> clear() async {
    _schools = const [];
    _activeId = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_activeIdKey);
    notifyListeners();
  }
}
