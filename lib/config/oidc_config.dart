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

  // Local Schuly backend. On a phone, pair with `adb reverse tcp:5033 tcp:5033`.
  static const backendBaseUrl = 'http://localhost:5033';

  static const tokenEndpoint = '$authority/api/oidc/token';
  static const authorizationEndpoint = '$authority/authorize';
}
