//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AuthApi {
  AuthApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Authenticate Mobile Api
  ///
  /// Authenticate using mobile flow with email and password.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AuthenticateRequestDto] authenticateRequestDto (required):
  Future<Response> authenticateMobileWithHttpInfo(AuthenticateRequestDto authenticateRequestDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/authenticate/mobile';

    // ignore: prefer_final_locals
    Object? postBody = authenticateRequestDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Authenticate Mobile Api
  ///
  /// Authenticate using mobile flow with email and password.
  ///
  /// Parameters:
  ///
  /// * [AuthenticateRequestDto] authenticateRequestDto (required):
  Future<AuthenticateMobileResponseDto?> authenticateMobile(AuthenticateRequestDto authenticateRequestDto,) async {
    final response = await authenticateMobileWithHttpInfo(authenticateRequestDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AuthenticateMobileResponseDto',) as AuthenticateMobileResponseDto;
    
    }
    return null;
  }

  /// Mobile Oauth Callback
  ///
  /// Handle OAuth callback for mobile authentication.  Exchanges the Microsoft authorization code for access and refresh tokens. Requires the code_verifier that the client generated and stored during URL creation.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MobileCallbackRequestDto] mobileCallbackRequestDto (required):
  Future<Response> authenticateOauthMobileCallbackWithHttpInfo(MobileCallbackRequestDto mobileCallbackRequestDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/authenticate/oauth/mobile/callback';

    // ignore: prefer_final_locals
    Object? postBody = mobileCallbackRequestDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Mobile Oauth Callback
  ///
  /// Handle OAuth callback for mobile authentication.  Exchanges the Microsoft authorization code for access and refresh tokens. Requires the code_verifier that the client generated and stored during URL creation.
  ///
  /// Parameters:
  ///
  /// * [MobileCallbackRequestDto] mobileCallbackRequestDto (required):
  Future<MobileCallbackResponseDto?> authenticateOauthMobileCallback(MobileCallbackRequestDto mobileCallbackRequestDto,) async {
    final response = await authenticateOauthMobileCallbackWithHttpInfo(mobileCallbackRequestDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MobileCallbackResponseDto',) as MobileCallbackResponseDto;
    
    }
    return null;
  }

  /// Generate Mobile Oauth Url
  ///
  /// Generate OAuth authorization URL for mobile authentication.  Returns both the authorization URL and the PKCE code_verifier. The client must store the code_verifier and use it during the callback. The URL already includes the corresponding code_challenge.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> authenticateOauthMobileUrlWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/authenticate/oauth/mobile/url';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Generate Mobile Oauth Url
  ///
  /// Generate OAuth authorization URL for mobile authentication.  Returns both the authorization URL and the PKCE code_verifier. The client must store the code_verifier and use it during the callback. The URL already includes the corresponding code_challenge.
  Future<MobileOAuthUrlResponseDto?> authenticateOauthMobileUrl() async {
    final response = await authenticateOauthMobileUrlWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MobileOAuthUrlResponseDto',) as MobileOAuthUrlResponseDto;
    
    }
    return null;
  }

  /// Web Oauth Callback
  ///
  /// Handle OAuth callback for web authentication.  Processes the Microsoft authorization code for web session establishment. Session cookies are typically handled by the browser in web flows.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [WebCallbackRequestDto] webCallbackRequestDto (required):
  Future<Response> authenticateOauthWebCallbackWithHttpInfo(WebCallbackRequestDto webCallbackRequestDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/authenticate/oauth/web/callback';

    // ignore: prefer_final_locals
    Object? postBody = webCallbackRequestDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Web Oauth Callback
  ///
  /// Handle OAuth callback for web authentication.  Processes the Microsoft authorization code for web session establishment. Session cookies are typically handled by the browser in web flows.
  ///
  /// Parameters:
  ///
  /// * [WebCallbackRequestDto] webCallbackRequestDto (required):
  Future<WebCallbackResponseDto?> authenticateOauthWebCallback(WebCallbackRequestDto webCallbackRequestDto,) async {
    final response = await authenticateOauthWebCallbackWithHttpInfo(webCallbackRequestDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'WebCallbackResponseDto',) as WebCallbackResponseDto;
    
    }
    return null;
  }

  /// Generate Web Oauth Url
  ///
  /// Generate OAuth authorization URL for web authentication.  Returns ONLY the authorization URL that clients should redirect users to for Microsoft login. Simpler flow without PKCE, suitable for web applications.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> authenticateOauthWebUrlWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/authenticate/oauth/web/url';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Generate Web Oauth Url
  ///
  /// Generate OAuth authorization URL for web authentication.  Returns ONLY the authorization URL that clients should redirect users to for Microsoft login. Simpler flow without PKCE, suitable for web applications.
  Future<String?> authenticateOauthWebUrl() async {
    final response = await authenticateOauthWebUrlWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'String',) as String;
    
    }
    return null;
  }

  /// Authenticate Unified Api
  ///
  /// Authenticate using unified flow with email and password.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AuthenticateRequestDto] authenticateRequestDto (required):
  Future<Response> authenticateUnifiedWithHttpInfo(AuthenticateRequestDto authenticateRequestDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/authenticate/unified';

    // ignore: prefer_final_locals
    Object? postBody = authenticateRequestDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Authenticate Unified Api
  ///
  /// Authenticate using unified flow with email and password.
  ///
  /// Parameters:
  ///
  /// * [AuthenticateRequestDto] authenticateRequestDto (required):
  Future<AuthenticateMobileResponseDto?> authenticateUnified(AuthenticateRequestDto authenticateRequestDto,) async {
    final response = await authenticateUnifiedWithHttpInfo(authenticateRequestDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AuthenticateMobileResponseDto',) as AuthenticateMobileResponseDto;
    
    }
    return null;
  }

  /// Authenticate Web Interface
  ///
  /// Authenticate using web flow with email and password.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AuthenticateRequestDto] authenticateRequestDto (required):
  Future<Response> authenticateWebWithHttpInfo(AuthenticateRequestDto authenticateRequestDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/authenticate/web';

    // ignore: prefer_final_locals
    Object? postBody = authenticateRequestDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Authenticate Web Interface
  ///
  /// Authenticate using web flow with email and password.
  ///
  /// Parameters:
  ///
  /// * [AuthenticateRequestDto] authenticateRequestDto (required):
  Future<Object?> authenticateWeb(AuthenticateRequestDto authenticateRequestDto,) async {
    final response = await authenticateWebWithHttpInfo(authenticateRequestDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Object',) as Object;
    
    }
    return null;
  }
}
