import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:app_links/app_links.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/oidc_config.dart';

class AuthTokens {
  final String accessToken;
  final String? idToken;
  final String? refreshToken;
  final int? expiresIn;

  AuthTokens({
    required this.accessToken,
    this.idToken,
    this.refreshToken,
    this.expiresIn,
  });
}

class AuthService {
  static const _kAccessTokenKey = 'auth.access_token';
  static const _kIdTokenKey = 'auth.id_token';
  static const _kRefreshTokenKey = 'auth.refresh_token';

  static final AppLinks _appLinks = AppLinks();

  /// Full OIDC PKCE flow via the external browser:
  /// 1. Build authorize URL + PKCE pair.
  /// 2. Subscribe to deep links *before* launching the browser so we cannot
  ///    miss the callback if the user returns instantly.
  /// 3. Open the URL in Chrome (external, supports passkeys).
  /// 4. Await the first incoming [OidcConfig.redirectUri] deep link.
  /// 5. Exchange the auth code for tokens.
  static Future<AuthTokens> signIn() async {
    final (verifier, challenge) = _generatePkce();
    final state = DateTime.now().microsecondsSinceEpoch.toString();
    final authorizeUrl = Uri.parse(OidcConfig.authorizationEndpoint).replace(
      queryParameters: {
        'response_type': 'code',
        'client_id': OidcConfig.clientId,
        'redirect_uri': OidcConfig.redirectUri,
        'scope': OidcConfig.scope,
        'state': state,
        'code_challenge': challenge,
        'code_challenge_method': 'S256',
      },
    );

    final completer = Completer<Uri>();
    late final StreamSubscription<Uri> sub;
    sub = _appLinks.uriLinkStream.listen((uri) {
      if (uri.scheme == OidcConfig.callbackScheme && !completer.isCompleted) {
        completer.complete(uri);
      }
    });

    try {
      final launched = await launchUrl(authorizeUrl, mode: LaunchMode.externalApplication);
      if (!launched) throw Exception('Could not launch browser');

      final callback = await completer.future.timeout(
        const Duration(minutes: 5),
        onTimeout: () => throw Exception('Login timed out'),
      );

      final error = callback.queryParameters['error'];
      if (error != null) throw Exception('OIDC error: $error');
      final code = callback.queryParameters['code'];
      final returnedState = callback.queryParameters['state'];
      if (code == null) throw Exception('Callback missing code');
      if (returnedState != state) throw Exception('State mismatch');

      return await _exchangeCode(code: code, codeVerifier: verifier);
    } finally {
      await sub.cancel();
    }
  }

  static (String, String) _generatePkce() {
    final rand = Random.secure();
    final bytes = List<int>.generate(32, (_) => rand.nextInt(256));
    final verifier = base64UrlEncode(bytes).replaceAll('=', '');
    final challenge = base64UrlEncode(sha256.convert(utf8.encode(verifier)).bytes)
        .replaceAll('=', '');
    return (verifier, challenge);
  }

  static Future<AuthTokens> _exchangeCode({
    required String code,
    required String codeVerifier,
  }) async {
    final response = await http.post(
      Uri.parse(OidcConfig.tokenEndpoint),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'client_id': OidcConfig.clientId,
        'redirect_uri': OidcConfig.redirectUri,
        'code_verifier': codeVerifier,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Token exchange failed (${response.statusCode}): ${response.body}');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final tokens = AuthTokens(
      accessToken: data['access_token'] as String,
      idToken: data['id_token'] as String?,
      refreshToken: data['refresh_token'] as String?,
      expiresIn: data['expires_in'] as int?,
    );
    await _persist(tokens);
    return tokens;
  }

  static Future<void> _persist(AuthTokens tokens) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kAccessTokenKey, tokens.accessToken);
    if (tokens.idToken != null) await prefs.setString(_kIdTokenKey, tokens.idToken!);
    if (tokens.refreshToken != null) {
      await prefs.setString(_kRefreshTokenKey, tokens.refreshToken!);
    }
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kAccessTokenKey);
  }

  static Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kAccessTokenKey);
    await prefs.remove(_kIdTokenKey);
    await prefs.remove(_kRefreshTokenKey);
  }
}
