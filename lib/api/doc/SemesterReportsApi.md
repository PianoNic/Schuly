# schuly_api.api.SemesterReportsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiSemesterReportsGet**](SemesterReportsApi.md#apisemesterreportsget) | **GET** /api/SemesterReports | 


# **apiSemesterReportsGet**
> BuiltList<SemesterReportDto> apiSemesterReportsGet(schoolUserId)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSemesterReportsApi();
final String schoolUserId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiSemesterReportsGet(schoolUserId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SemesterReportsApi->apiSemesterReportsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **schoolUserId** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;SemesterReportDto&gt;**](SemesterReportDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

