class OidcConfig {
  static const authority = 'https://auth.gaggao.com';
  static const clientId = 'fe2e0db0-69e3-48e3-845c-561f7a36d280';
  static const scope = 'openid profile email groups picture';

  // Custom scheme deep link. Pocket ID redirects here after login; Android
  // routes it back to the app via the schulytest:// intent filter, so the
  // user lands in the real Chrome (full passkey support) and returns to the
  // app on success. Scheme intentionally does NOT mirror the package id so
  // dev and prod flavors can coexist.
  static const redirectUri = 'schulytest://callback';
  static const callbackScheme = 'schulytest';

  // USB-tethered phone via `adb reverse tcp:5033 tcp:5033`. Use the LAN IP
  // (http://192.168.188.93:5033) or `http://10.0.2.2:5033` (emulator) instead.
  static const backendBaseUrl = 'http://localhost:5033';

  static const tokenEndpoint = '$authority/api/oidc/token';
  static const authorizationEndpoint = '$authority/authorize';

  /// Resolves a backend-supplied URL: absolute (http…) is used as-is, a
  /// root-relative path (/api/avatars/…) is prefixed with [backendBaseUrl],
  /// null/empty returns null. Signed capability URLs need no auth header.
  static String? resolveUrl(String? url) {
    if (url == null || url.isEmpty) return null;
    if (url.startsWith('http')) return url;
    if (url.startsWith('/')) return '$backendBaseUrl$url';
    return url;
  }
}
