# schuly_api.api.ApplicationUsersApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiApplicationUsersGet**](ApplicationUsersApi.md#apiapplicationusersget) | **GET** /api/ApplicationUsers | 
[**apiApplicationUsersIdDelete**](ApplicationUsersApi.md#apiapplicationusersiddelete) | **DELETE** /api/ApplicationUsers/{id} | 
[**apiApplicationUsersIdGet**](ApplicationUsersApi.md#apiapplicationusersidget) | **GET** /api/ApplicationUsers/{id} | 
[**apiApplicationUsersPost**](ApplicationUsersApi.md#apiapplicationuserspost) | **POST** /api/ApplicationUsers | 
[**apiApplicationUsersPut**](ApplicationUsersApi.md#apiapplicationusersput) | **PUT** /api/ApplicationUsers | 


# **apiApplicationUsersGet**
> BuiltList<ApplicationUserDto> apiApplicationUsersGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getApplicationUsersApi();

try {
    final response = api.apiApplicationUsersGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling ApplicationUsersApi->apiApplicationUsersGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;ApplicationUserDto&gt;**](ApplicationUserDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiApplicationUsersIdDelete**
> apiApplicationUsersIdDelete(id)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getApplicationUsersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiApplicationUsersIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling ApplicationUsersApi->apiApplicationUsersIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiApplicationUsersIdGet**
> ApplicationUserDto apiApplicationUsersIdGet(id)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getApplicationUsersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiApplicationUsersIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ApplicationUsersApi->apiApplicationUsersIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ApplicationUserDto**](ApplicationUserDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiApplicationUsersPost**
> String apiApplicationUsersPost(createApplicationUserCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getApplicationUsersApi();
final CreateApplicationUserCommand createApplicationUserCommand = ; // CreateApplicationUserCommand | 

try {
    final response = api.apiApplicationUsersPost(createApplicationUserCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ApplicationUsersApi->apiApplicationUsersPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createApplicationUserCommand** | [**CreateApplicationUserCommand**](CreateApplicationUserCommand.md)|  | [optional] 

### Return type

**String**

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiApplicationUsersPut**
> apiApplicationUsersPut(updateApplicationUserCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getApplicationUsersApi();
final UpdateApplicationUserCommand updateApplicationUserCommand = ; // UpdateApplicationUserCommand | 

try {
    api.apiApplicationUsersPut(updateApplicationUserCommand);
} catch on DioException (e) {
    print('Exception when calling ApplicationUsersApi->apiApplicationUsersPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateApplicationUserCommand** | [**UpdateApplicationUserCommand**](UpdateApplicationUserCommand.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

