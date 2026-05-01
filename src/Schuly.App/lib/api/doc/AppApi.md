# schuly_api.api.AppApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAppGet**](AppApi.md#apiappget) | **GET** /api/App | 
[**testEndpointWithAuth**](AppApi.md#testendpointwithauth) | **GET** /api/App/test | 


# **apiAppGet**
> AppDto apiAppGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAppApi();

try {
    final response = api.apiAppGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AppApi->apiAppGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AppDto**](AppDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **testEndpointWithAuth**
> testEndpointWithAuth()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAppApi();

try {
    api.testEndpointWithAuth();
} catch on DioException (e) {
    print('Exception when calling AppApi->testEndpointWithAuth: $e\n');
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
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

