import 'package:dio/dio.dart';
import 'package:schuly_api/schuly_api.dart';

import '../config/oidc_config.dart';
import 'auth_service.dart';

/// Singleton-ish wrapper around the generated [SchulyApi]. Pre-wires the
/// dev backend base URL and an interceptor that lazily attaches the Pocket ID
/// bearer token from [AuthService] on every request.
class ApiClient {
  ApiClient._() {
    api = SchulyApi(
      basePathOverride: OidcConfig.backendBaseUrl,
      interceptors: [
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final token = await AuthService.getAccessToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            handler.next(options);
          },
        ),
      ],
    );
  }

  static final ApiClient instance = ApiClient._();
  late final SchulyApi api;
}
