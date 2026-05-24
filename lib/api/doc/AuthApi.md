# schuly_api.api.AuthApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAuthMeGet**](AuthApi.md#apiauthmeget) | **GET** /api/Auth/me | 
[**apiAuthSyncGet**](AuthApi.md#apiauthsyncget) | **GET** /api/Auth/sync | 


# **apiAuthMeGet**
> ApplicationUserDto apiAuthMeGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAuthApi();

try {
    final response = api.apiAuthMeGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->apiAuthMeGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApplicationUserDto**](ApplicationUserDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAuthSyncGet**
> apiAuthSyncGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAuthApi();

try {
    api.apiAuthSyncGet();
} catch on DioException (e) {
    print('Exception when calling AuthApi->apiAuthSyncGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

