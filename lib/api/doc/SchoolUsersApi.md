# schuly_api.api.SchoolUsersApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiSchoolUsersGet**](SchoolUsersApi.md#apischoolusersget) | **GET** /api/SchoolUsers | 
[**apiSchoolUsersIdDelete**](SchoolUsersApi.md#apischoolusersiddelete) | **DELETE** /api/SchoolUsers/{id} | 
[**apiSchoolUsersIdGet**](SchoolUsersApi.md#apischoolusersidget) | **GET** /api/SchoolUsers/{id} | 
[**apiSchoolUsersPost**](SchoolUsersApi.md#apischooluserspost) | **POST** /api/SchoolUsers | 
[**apiSchoolUsersPut**](SchoolUsersApi.md#apischoolusersput) | **PUT** /api/SchoolUsers | 


# **apiSchoolUsersGet**
> BuiltList<SchoolUserDto> apiSchoolUsersGet(applicationUserId)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolUsersApi();
final String applicationUserId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiSchoolUsersGet(applicationUserId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SchoolUsersApi->apiSchoolUsersGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **applicationUserId** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;SchoolUserDto&gt;**](SchoolUserDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSchoolUsersIdDelete**
> apiSchoolUsersIdDelete(id)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolUsersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiSchoolUsersIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling SchoolUsersApi->apiSchoolUsersIdDelete: $e\n');
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

# **apiSchoolUsersIdGet**
> SchoolUserDto apiSchoolUsersIdGet(id)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolUsersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiSchoolUsersIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SchoolUsersApi->apiSchoolUsersIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**SchoolUserDto**](SchoolUserDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSchoolUsersPost**
> String apiSchoolUsersPost(createSchoolUserCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolUsersApi();
final CreateSchoolUserCommand createSchoolUserCommand = ; // CreateSchoolUserCommand | 

try {
    final response = api.apiSchoolUsersPost(createSchoolUserCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SchoolUsersApi->apiSchoolUsersPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createSchoolUserCommand** | [**CreateSchoolUserCommand**](CreateSchoolUserCommand.md)|  | [optional] 

### Return type

**String**

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSchoolUsersPut**
> apiSchoolUsersPut(updateSchoolUserCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolUsersApi();
final UpdateSchoolUserCommand updateSchoolUserCommand = ; // UpdateSchoolUserCommand | 

try {
    api.apiSchoolUsersPut(updateSchoolUserCommand);
} catch on DioException (e) {
    print('Exception when calling SchoolUsersApi->apiSchoolUsersPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateSchoolUserCommand** | [**UpdateSchoolUserCommand**](UpdateSchoolUserCommand.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

