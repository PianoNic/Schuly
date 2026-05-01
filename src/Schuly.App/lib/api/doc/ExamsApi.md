# schuly_api.api.ExamsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiExamsGet**](ExamsApi.md#apiexamsget) | **GET** /api/Exams | 
[**apiExamsGradePost**](ExamsApi.md#apiexamsgradepost) | **POST** /api/Exams/grade | 
[**apiExamsIdDelete**](ExamsApi.md#apiexamsiddelete) | **DELETE** /api/Exams/{id} | 
[**apiExamsPost**](ExamsApi.md#apiexamspost) | **POST** /api/Exams | 
[**apiExamsPut**](ExamsApi.md#apiexamsput) | **PUT** /api/Exams | 
[**apiExamsSearchGet**](ExamsApi.md#apiexamssearchget) | **GET** /api/Exams/search | 


# **apiExamsGet**
> BuiltList<ExamDto> apiExamsGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getExamsApi();

try {
    final response = api.apiExamsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling ExamsApi->apiExamsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;ExamDto&gt;**](ExamDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiExamsGradePost**
> apiExamsGradePost(addGradeToExamCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getExamsApi();
final AddGradeToExamCommand addGradeToExamCommand = ; // AddGradeToExamCommand | 

try {
    api.apiExamsGradePost(addGradeToExamCommand);
} catch on DioException (e) {
    print('Exception when calling ExamsApi->apiExamsGradePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **addGradeToExamCommand** | [**AddGradeToExamCommand**](AddGradeToExamCommand.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiExamsIdDelete**
> apiExamsIdDelete(id)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getExamsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiExamsIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling ExamsApi->apiExamsIdDelete: $e\n');
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

# **apiExamsPost**
> apiExamsPost(createExamCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getExamsApi();
final CreateExamCommand createExamCommand = ; // CreateExamCommand | 

try {
    api.apiExamsPost(createExamCommand);
} catch on DioException (e) {
    print('Exception when calling ExamsApi->apiExamsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createExamCommand** | [**CreateExamCommand**](CreateExamCommand.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiExamsPut**
> apiExamsPut(updateExamCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getExamsApi();
final UpdateExamCommand updateExamCommand = ; // UpdateExamCommand | 

try {
    api.apiExamsPut(updateExamCommand);
} catch on DioException (e) {
    print('Exception when calling ExamsApi->apiExamsPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateExamCommand** | [**UpdateExamCommand**](UpdateExamCommand.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiExamsSearchGet**
> ExamDto apiExamsSearchGet(examId)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getExamsApi();
final String examId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiExamsSearchGet(examId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ExamsApi->apiExamsSearchGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **examId** | **String**|  | [optional] 

### Return type

[**ExamDto**](ExamDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

