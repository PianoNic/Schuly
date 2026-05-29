# schuly_api.api.AvatarsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAvatarsSchoolUserIdGet**](AvatarsApi.md#apiavatarsschooluseridget) | **GET** /api/avatars/{schoolUserId} | 


# **apiAvatarsSchoolUserIdGet**
> apiAvatarsSchoolUserIdGet(schoolUserId, exp, sig)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAvatarsApi();
final String schoolUserId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final int exp = 789; // int | 
final String sig = sig_example; // String | 

try {
    api.apiAvatarsSchoolUserIdGet(schoolUserId, exp, sig);
} catch on DioException (e) {
    print('Exception when calling AvatarsApi->apiAvatarsSchoolUserIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **schoolUserId** | **String**|  | 
 **exp** | **int**|  | [optional] 
 **sig** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

