import 'package:dio/dio.dart';
import 'package:schuly_api/schuly_api.dart';

import '../config/oidc_config.dart';
import 'auth_service.dart';

/// Singleton-ish wrapper around the generated [SchulyApi]. Pre-wires the
/// backend base URL and an interceptor that attaches the Pocket ID bearer on
/// every request and transparently refreshes it on a 401.
class ApiClient {
  ApiClient._() {
    // The Schulware OAuth-callback endpoint runs the initial sync inline,
    // which takes well over the generated client's 3s default on cold runs.
    _dio = Dio(BaseOptions(
      baseUrl: OidcConfig.backendBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 30),
    ));
    api = SchulyApi(
      dio: _dio,
      interceptors: [
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final token = await AuthService.getAccessToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            handler.next(options);
          },
          onError: (e, handler) async {
            final options = e.requestOptions;
            // On a 401, try to refresh the access token once and replay the
            // request. `_retried` guards against an infinite loop if the
            // refreshed token is also rejected.
            if (e.response?.statusCode == 401 && options.extra['_retried'] != true) {
              final newToken = await _refresh();
              if (newToken != null) {
                options.extra['_retried'] = true;
                options.headers['Authorization'] = 'Bearer $newToken';
                try {
                  return handler.resolve(await _dio.fetch(options));
                } on DioException catch (retryError) {
                  return handler.next(retryError);
                }
              }
              // Refresh failed → the refresh token is dead too. Clear the
              // session so the auth gate bounces the user to sign-in.
              await AuthService.signOut();
            }
            handler.next(e);
          },
        ),
      ],
    );
  }

  static final ApiClient instance = ApiClient._();
  late final Dio _dio;
  late final SchulyApi api;

  /// In-flight refresh, shared so concurrent 401s trigger a single token
  /// exchange instead of a stampede.
  Future<String?>? _refreshing;

  Future<String?> _refresh() {
    return _refreshing ??=
        AuthService.refreshAccessToken().whenComplete(() => _refreshing = null);
  }
}
