# schuly_api.api.AbsencesApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAbsencesGet**](AbsencesApi.md#apiabsencesget) | **GET** /api/Absences | 
[**apiAbsencesIdDelete**](AbsencesApi.md#apiabsencesiddelete) | **DELETE** /api/Absences/{id} | 
[**apiAbsencesPost**](AbsencesApi.md#apiabsencespost) | **POST** /api/Absences | 
[**apiAbsencesPut**](AbsencesApi.md#apiabsencesput) | **PUT** /api/Absences | 
[**apiAbsencesSearchGet**](AbsencesApi.md#apiabsencessearchget) | **GET** /api/Absences/search | 


# **apiAbsencesGet**
> BuiltList<AbsenceDto> apiAbsencesGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAbsencesApi();

try {
    final response = api.apiAbsencesGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AbsencesApi->apiAbsencesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;AbsenceDto&gt;**](AbsenceDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAbsencesIdDelete**
> apiAbsencesIdDelete(id)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAbsencesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiAbsencesIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling AbsencesApi->apiAbsencesIdDelete: $e\n');
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

# **apiAbsencesPost**
> apiAbsencesPost(createAbsenceCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAbsencesApi();
final CreateAbsenceCommand createAbsenceCommand = ; // CreateAbsenceCommand | 

try {
    api.apiAbsencesPost(createAbsenceCommand);
} catch on DioException (e) {
    print('Exception when calling AbsencesApi->apiAbsencesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createAbsenceCommand** | [**CreateAbsenceCommand**](CreateAbsenceCommand.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAbsencesPut**
> apiAbsencesPut(updateAbsenceCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAbsencesApi();
final UpdateAbsenceCommand updateAbsenceCommand = ; // UpdateAbsenceCommand | 

try {
    api.apiAbsencesPut(updateAbsenceCommand);
} catch on DioException (e) {
    print('Exception when calling AbsencesApi->apiAbsencesPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateAbsenceCommand** | [**UpdateAbsenceCommand**](UpdateAbsenceCommand.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAbsencesSearchGet**
> AbsenceDto apiAbsencesSearchGet(absenceId)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAbsencesApi();
final String absenceId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiAbsencesSearchGet(absenceId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AbsencesApi->apiAbsencesSearchGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **absenceId** | **String**|  | [optional] 

### Return type

[**AbsenceDto**](AbsenceDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

