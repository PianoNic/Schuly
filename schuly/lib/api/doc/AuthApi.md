# openapi.api.AuthApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authenticateMobile**](AuthApi.md#authenticatemobile) | **POST** /api/authenticate/mobile | Authenticate Mobile Api
[**authenticateOauthMobileCallback**](AuthApi.md#authenticateoauthmobilecallback) | **POST** /api/authenticate/oauth/mobile/callback | Mobile Oauth Callback
[**authenticateOauthMobileUrl**](AuthApi.md#authenticateoauthmobileurl) | **GET** /api/authenticate/oauth/mobile/url | Generate Mobile Oauth Url
[**authenticateOauthWebCallback**](AuthApi.md#authenticateoauthwebcallback) | **POST** /api/authenticate/oauth/web/callback | Web Oauth Callback
[**authenticateOauthWebUrl**](AuthApi.md#authenticateoauthweburl) | **GET** /api/authenticate/oauth/web/url | Generate Web Oauth Url
[**authenticateUnified**](AuthApi.md#authenticateunified) | **POST** /api/authenticate/unified | Authenticate Unified Api
[**authenticateWeb**](AuthApi.md#authenticateweb) | **POST** /api/authenticate/web | Authenticate Web Interface


# **authenticateMobile**
> AuthenticateMobileResponseDto authenticateMobile(authenticateRequestDto)

Authenticate Mobile Api

Authenticate using mobile flow with email and password.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();
final authenticateRequestDto = AuthenticateRequestDto(); // AuthenticateRequestDto | 

try {
    final result = api_instance.authenticateMobile(authenticateRequestDto);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->authenticateMobile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authenticateRequestDto** | [**AuthenticateRequestDto**](AuthenticateRequestDto.md)|  | 

### Return type

[**AuthenticateMobileResponseDto**](AuthenticateMobileResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authenticateOauthMobileCallback**
> MobileCallbackResponseDto authenticateOauthMobileCallback(mobileCallbackRequestDto)

Mobile Oauth Callback

Handle OAuth callback for mobile authentication.  Exchanges the Microsoft authorization code for access and refresh tokens. Requires the code_verifier that the client generated and stored during URL creation.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();
final mobileCallbackRequestDto = MobileCallbackRequestDto(); // MobileCallbackRequestDto | 

try {
    final result = api_instance.authenticateOauthMobileCallback(mobileCallbackRequestDto);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->authenticateOauthMobileCallback: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **mobileCallbackRequestDto** | [**MobileCallbackRequestDto**](MobileCallbackRequestDto.md)|  | 

### Return type

[**MobileCallbackResponseDto**](MobileCallbackResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authenticateOauthMobileUrl**
> MobileOAuthUrlResponseDto authenticateOauthMobileUrl()

Generate Mobile Oauth Url

Generate OAuth authorization URL for mobile authentication.  Returns both the authorization URL and the PKCE code_verifier. The client must store the code_verifier and use it during the callback. The URL already includes the corresponding code_challenge.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();

try {
    final result = api_instance.authenticateOauthMobileUrl();
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->authenticateOauthMobileUrl: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MobileOAuthUrlResponseDto**](MobileOAuthUrlResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authenticateOauthWebCallback**
> WebCallbackResponseDto authenticateOauthWebCallback(webCallbackRequestDto)

Web Oauth Callback

Handle OAuth callback for web authentication.  Processes the Microsoft authorization code for web session establishment. Session cookies are typically handled by the browser in web flows.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();
final webCallbackRequestDto = WebCallbackRequestDto(); // WebCallbackRequestDto | 

try {
    final result = api_instance.authenticateOauthWebCallback(webCallbackRequestDto);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->authenticateOauthWebCallback: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **webCallbackRequestDto** | [**WebCallbackRequestDto**](WebCallbackRequestDto.md)|  | 

### Return type

[**WebCallbackResponseDto**](WebCallbackResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authenticateOauthWebUrl**
> String authenticateOauthWebUrl()

Generate Web Oauth Url

Generate OAuth authorization URL for web authentication.  Returns ONLY the authorization URL that clients should redirect users to for Microsoft login. Simpler flow without PKCE, suitable for web applications.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();

try {
    final result = api_instance.authenticateOauthWebUrl();
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->authenticateOauthWebUrl: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authenticateUnified**
> AuthenticateMobileResponseDto authenticateUnified(authenticateRequestDto)

Authenticate Unified Api

Authenticate using unified flow with email and password.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();
final authenticateRequestDto = AuthenticateRequestDto(); // AuthenticateRequestDto | 

try {
    final result = api_instance.authenticateUnified(authenticateRequestDto);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->authenticateUnified: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authenticateRequestDto** | [**AuthenticateRequestDto**](AuthenticateRequestDto.md)|  | 

### Return type

[**AuthenticateMobileResponseDto**](AuthenticateMobileResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authenticateWeb**
> Object authenticateWeb(authenticateRequestDto)

Authenticate Web Interface

Authenticate using web flow with email and password.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();
final authenticateRequestDto = AuthenticateRequestDto(); // AuthenticateRequestDto | 

try {
    final result = api_instance.authenticateWeb(authenticateRequestDto);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->authenticateWeb: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authenticateRequestDto** | [**AuthenticateRequestDto**](AuthenticateRequestDto.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

