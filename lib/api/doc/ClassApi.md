# schuly_api.api.ClassApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiClassEnrolStudentPost**](ClassApi.md#apiclassenrolstudentpost) | **POST** /api/Class/enrol-student | 
[**apiClassGet**](ClassApi.md#apiclassget) | **GET** /api/Class | 
[**apiClassIdDelete**](ClassApi.md#apiclassiddelete) | **DELETE** /api/Class/{id} | 
[**apiClassPost**](ClassApi.md#apiclasspost) | **POST** /api/Class | 
[**apiClassPut**](ClassApi.md#apiclassput) | **PUT** /api/Class | 
[**apiClassSearchGet**](ClassApi.md#apiclasssearchget) | **GET** /api/Class/search | 


# **apiClassEnrolStudentPost**
> apiClassEnrolStudentPost(enrolStudentCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getClassApi();
final EnrolStudentCommand enrolStudentCommand = ; // EnrolStudentCommand | 

try {
    api.apiClassEnrolStudentPost(enrolStudentCommand);
} catch on DioException (e) {
    print('Exception when calling ClassApi->apiClassEnrolStudentPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **enrolStudentCommand** | [**EnrolStudentCommand**](EnrolStudentCommand.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiClassGet**
> BuiltList<ClassDto> apiClassGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getClassApi();

try {
    final response = api.apiClassGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling ClassApi->apiClassGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;ClassDto&gt;**](ClassDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiClassIdDelete**
> apiClassIdDelete(id)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getClassApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiClassIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling ClassApi->apiClassIdDelete: $e\n');
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

# **apiClassPost**
> apiClassPost(createClassCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getClassApi();
final CreateClassCommand createClassCommand = ; // CreateClassCommand | 

try {
    api.apiClassPost(createClassCommand);
} catch on DioException (e) {
    print('Exception when calling ClassApi->apiClassPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createClassCommand** | [**CreateClassCommand**](CreateClassCommand.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiClassPut**
> apiClassPut(updateClassCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getClassApi();
final UpdateClassCommand updateClassCommand = ; // UpdateClassCommand | 

try {
    api.apiClassPut(updateClassCommand);
} catch on DioException (e) {
    print('Exception when calling ClassApi->apiClassPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateClassCommand** | [**UpdateClassCommand**](UpdateClassCommand.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiClassSearchGet**
> ClassDto apiClassSearchGet(classId)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getClassApi();
final String classId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiClassSearchGet(classId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ClassApi->apiClassSearchGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **String**|  | [optional] 

### Return type

[**ClassDto**](ClassDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

