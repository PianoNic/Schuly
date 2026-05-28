# schuly_api.api.StudentDocumentsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiDocumentsDocumentIdGet**](StudentDocumentsApi.md#apidocumentsdocumentidget) | **GET** /api/documents/{documentId} | 
[**apiDocumentsGet**](StudentDocumentsApi.md#apidocumentsget) | **GET** /api/documents | 
[**apiStudentsSchoolUserIdDocumentsPost**](StudentDocumentsApi.md#apistudentsschooluseriddocumentspost) | **POST** /api/students/{schoolUserId}/documents | 


# **apiDocumentsDocumentIdGet**
> apiDocumentsDocumentIdGet(documentId)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getStudentDocumentsApi();
final String documentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiDocumentsDocumentIdGet(documentId);
} catch on DioException (e) {
    print('Exception when calling StudentDocumentsApi->apiDocumentsDocumentIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **documentId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiDocumentsGet**
> BuiltList<StudentDocumentDto> apiDocumentsGet(schoolUserId)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getStudentDocumentsApi();
final String schoolUserId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiDocumentsGet(schoolUserId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling StudentDocumentsApi->apiDocumentsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **schoolUserId** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;StudentDocumentDto&gt;**](StudentDocumentDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiStudentsSchoolUserIdDocumentsPost**
> apiStudentsSchoolUserIdDocumentsPost(schoolUserId, file, title, comment, category, enteredBy, followUpAction, followUpDate)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getStudentDocumentsApi();
final String schoolUserId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 
final String title = title_example; // String | 
final String comment = comment_example; // String | 
final String category = category_example; // String | 
final String enteredBy = enteredBy_example; // String | 
final String followUpAction = followUpAction_example; // String | 
final Date followUpDate = 2013-10-20; // Date | 

try {
    api.apiStudentsSchoolUserIdDocumentsPost(schoolUserId, file, title, comment, category, enteredBy, followUpAction, followUpDate);
} catch on DioException (e) {
    print('Exception when calling StudentDocumentsApi->apiStudentsSchoolUserIdDocumentsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **schoolUserId** | **String**|  | 
 **file** | **MultipartFile**|  | [optional] 
 **title** | **String**|  | [optional] 
 **comment** | **String**|  | [optional] 
 **category** | **String**|  | [optional] 
 **enteredBy** | **String**|  | [optional] 
 **followUpAction** | **String**|  | [optional] 
 **followUpDate** | **Date**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

