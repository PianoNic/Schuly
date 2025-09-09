# openapi.api.AuthApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authenticateMobile**](AuthApi.md#authenticatemobile) | **POST** /api/authenticate/mobile | Authenticate Mobile Api
[**authenticateUnified**](AuthApi.md#authenticateunified) | **POST** /api/authenticate/unified | Authenticate Unified Api
[**authenticateWeb**](AuthApi.md#authenticateweb) | **POST** /api/authenticate/web | Authenticate Web Interface


# **authenticateMobile**
> Object authenticateMobile(email, password)

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

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authenticateUnified**
> Object authenticateUnified(email, password)

Authenticate Unified Api

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();
final email = email_example; // String | 
final password = password_example; // String | 

try {
    final result = api_instance.authenticateUnified(email, password);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->authenticateUnified: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**|  | 
 **password** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authenticateWeb**
> Object authenticateWeb(email, password)

Authenticate Web Interface

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();
final email = email_example; // String | 
final password = password_example; // String | 

try {
    final result = api_instance.authenticateWeb(email, password);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->authenticateWeb: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**|  | 
 **password** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

