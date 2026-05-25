import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/oidc_config.dart';
import 'auth_service.dart';

/// Thin wrapper over the Schulware plugin's HTTP endpoints. Every call attaches
/// the Pocket ID bearer token from [AuthService].
class PluginApi {
  static const _base = OidcConfig.backendBaseUrl;

  static Future<Map<String, String>> _headers({bool json = false}) async {
    final token = await AuthService.getAccessToken();
    return {
      if (token != null) 'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      if (json) 'Content-Type': 'application/json',
    };
  }

  static Future<http.Response> getStatus() =>
      http.get(Uri.parse('$_base/api/plugins/schulware/status'));

  static Future<http.Response> listAccounts() async =>
      http.get(Uri.parse('$_base/api/plugins/schulware/accounts'),
          headers: await _headers());

  static Future<http.Response> createAccount({
    required String schulnetzBaseUrl,
    required String displayName,
  }) async =>
      http.post(
        Uri.parse('$_base/api/plugins/schulware/accounts'),
        headers: await _headers(json: true),
        body: jsonEncode({
          'schulnetzBaseUrl': schulnetzBaseUrl,
          'displayName': displayName,
        }),
      );

  static Future<http.Response> getOAuthUrl(String accountId) async => http.get(
        Uri.parse('$_base/api/plugins/schulware/accounts/$accountId/auth/oauth/url'),
        headers: await _headers(),
      );

  /// Trigger an immediate sync (refreshes token if expired, then pulls grades + absences).
  static Future<http.Response> triggerSync(String accountId) async => http.post(
        Uri.parse('$_base/api/plugins/schulware/accounts/$accountId/sync'),
        headers: await _headers(),
      );

  static Future<http.Response> getSyncStatus(String accountId) async => http.get(
        Uri.parse('$_base/api/plugins/schulware/accounts/$accountId/sync'),
        headers: await _headers(),
      );

  static Future<http.Response> completeOAuth({
    required String accountId,
    required String code,
    required String codeVerifier,
    String? state,
    String? contextState,
    String? userAgent,
  }) async =>
      http.post(
        Uri.parse('$_base/api/plugins/schulware/accounts/$accountId/auth/oauth/callback'),
        headers: await _headers(json: true),
        body: jsonEncode({
          'code': code,
          'codeVerifier': codeVerifier,
          'state': state,
          'contextState': contextState,
          'userAgent': userAgent,
        }),
      );
}
