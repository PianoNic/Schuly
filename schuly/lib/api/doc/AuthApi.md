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
[**authenticateUnified**](AuthApi.md#authenticateunified) | **POST** /api/authenticate/unified | Authenticate Unified Api
[**authenticateWeb**](AuthApi.md#authenticateweb) | **POST** /api/authenticate/web | Authenticate Web Interface


# **authenticateMobile**
> AuthenticateMobileResponseDto authenticateMobile(email, password)

Authenticate Mobile Api

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();
final email = email_example; // String | 
final password = password_example; // String | 

try {
    final result = api_instance.authenticateMobile(email, password);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->authenticateMobile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**|  | 
 **password** | **String**|  | 

### Return type

[**AuthenticateMobileResponseDto**](AuthenticateMobileResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authenticateOauthMobileCallback**
> MobileCallbackResponseDto authenticateOauthMobileCallback(mobileCallbackRequestDto)

Mobile Oauth Callback

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

# **authenticateUnified**
> AuthenticateMobileResponseDto authenticateUnified(authenticateRequestDto)

Authenticate Unified Api

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

