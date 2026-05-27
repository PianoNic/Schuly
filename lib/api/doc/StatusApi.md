# schuly_api.api.StatusApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsSchulwareStatusGet**](StatusApi.md#apipluginsschulwarestatusget) | **GET** /api/plugins/schulware/status | 


# **apiPluginsSchulwareStatusGet**
> apiPluginsSchulwareStatusGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getStatusApi();

try {
    api.apiPluginsSchulwareStatusGet();
} catch on DioException (e) {
    print('Exception when calling StatusApi->apiPluginsSchulwareStatusGet: $e\n');
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

