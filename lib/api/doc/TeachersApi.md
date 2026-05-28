# schuly_api.api.TeachersApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiTeachersGet**](TeachersApi.md#apiteachersget) | **GET** /api/Teachers | 
[**apiTeachersIdDelete**](TeachersApi.md#apiteachersiddelete) | **DELETE** /api/Teachers/{id} | 
[**apiTeachersIdGet**](TeachersApi.md#apiteachersidget) | **GET** /api/Teachers/{id} | 
[**apiTeachersPost**](TeachersApi.md#apiteacherspost) | **POST** /api/Teachers | 
[**apiTeachersPut**](TeachersApi.md#apiteachersput) | **PUT** /api/Teachers | 


# **apiTeachersGet**
> BuiltList<TeacherDto> apiTeachersGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getTeachersApi();

try {
    final response = api.apiTeachersGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling TeachersApi->apiTeachersGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;TeacherDto&gt;**](TeacherDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTeachersIdDelete**
> apiTeachersIdDelete(id)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getTeachersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiTeachersIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling TeachersApi->apiTeachersIdDelete: $e\n');
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

# **apiTeachersIdGet**
> TeacherDto apiTeachersIdGet(id)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getTeachersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiTeachersIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TeachersApi->apiTeachersIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**TeacherDto**](TeacherDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTeachersPost**
> String apiTeachersPost(createTeacherCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getTeachersApi();
final CreateTeacherCommand createTeacherCommand = ; // CreateTeacherCommand | 

try {
    final response = api.apiTeachersPost(createTeacherCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TeachersApi->apiTeachersPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createTeacherCommand** | [**CreateTeacherCommand**](CreateTeacherCommand.md)|  | [optional] 

### Return type

**String**

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTeachersPut**
> apiTeachersPut(updateTeacherCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getTeachersApi();
final UpdateTeacherCommand updateTeacherCommand = ; // UpdateTeacherCommand | 

try {
    api.apiTeachersPut(updateTeacherCommand);
} catch on DioException (e) {
    print('Exception when calling TeachersApi->apiTeachersPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateTeacherCommand** | [**UpdateTeacherCommand**](UpdateTeacherCommand.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

