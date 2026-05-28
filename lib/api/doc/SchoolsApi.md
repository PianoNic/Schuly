# schuly_api.api.SchoolsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiSchoolsGet**](SchoolsApi.md#apischoolsget) | **GET** /api/Schools | 
[**apiSchoolsIdDelete**](SchoolsApi.md#apischoolsiddelete) | **DELETE** /api/Schools/{id} | 
[**apiSchoolsIdGet**](SchoolsApi.md#apischoolsidget) | **GET** /api/Schools/{id} | 
[**apiSchoolsMySchoolsGet**](SchoolsApi.md#apischoolsmyschoolsget) | **GET** /api/Schools/my-schools | 
[**apiSchoolsPost**](SchoolsApi.md#apischoolspost) | **POST** /api/Schools | 
[**apiSchoolsPut**](SchoolsApi.md#apischoolsput) | **PUT** /api/Schools | 


# **apiSchoolsGet**
> BuiltList<SchoolDto> apiSchoolsGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolsApi();

try {
    final response = api.apiSchoolsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling SchoolsApi->apiSchoolsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;SchoolDto&gt;**](SchoolDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSchoolsIdDelete**
> apiSchoolsIdDelete(id)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiSchoolsIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling SchoolsApi->apiSchoolsIdDelete: $e\n');
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

# **apiSchoolsIdGet**
> SchoolDto apiSchoolsIdGet(id)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiSchoolsIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SchoolsApi->apiSchoolsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**SchoolDto**](SchoolDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSchoolsMySchoolsGet**
> BuiltList<MySchoolDto> apiSchoolsMySchoolsGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolsApi();

try {
    final response = api.apiSchoolsMySchoolsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling SchoolsApi->apiSchoolsMySchoolsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;MySchoolDto&gt;**](MySchoolDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSchoolsPost**
> String apiSchoolsPost(createSchoolCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolsApi();
final CreateSchoolCommand createSchoolCommand = ; // CreateSchoolCommand | 

try {
    final response = api.apiSchoolsPost(createSchoolCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SchoolsApi->apiSchoolsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createSchoolCommand** | [**CreateSchoolCommand**](CreateSchoolCommand.md)|  | [optional] 

### Return type

**String**

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSchoolsPut**
> apiSchoolsPut(updateSchoolCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolsApi();
final UpdateSchoolCommand updateSchoolCommand = ; // UpdateSchoolCommand | 

try {
    api.apiSchoolsPut(updateSchoolCommand);
} catch on DioException (e) {
    print('Exception when calling SchoolsApi->apiSchoolsPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateSchoolCommand** | [**UpdateSchoolCommand**](UpdateSchoolCommand.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

