# openapi.api.AppApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**appAppInfo**](AppApi.md#appappinfo) | **GET** /api/app/app-info | App Info


# **appAppInfo**
> Object appAppInfo()

App Info

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AppApi();

try {
    final result = api_instance.appAppInfo();
    print(result);
} catch (e) {
    print('Exception when calling AppApi->appAppInfo: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

