# openapi.api.WebAPIApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**webAgenda**](WebAPIApi.md#webagenda) | **GET** /api/web/agenda | Get Agenda
[**webAusweis**](WebAPIApi.md#webausweis) | **GET** /api/web/ausweis | Get Ausweis
[**webListen**](WebAPIApi.md#weblisten) | **GET** /api/web/listen | Get Listen
[**webNoten**](WebAPIApi.md#webnoten) | **GET** /api/web/noten | Get Noten
[**webUnterricht**](WebAPIApi.md#webunterricht) | **GET** /api/web/unterricht | Get Unterricht


# **webAgenda**
> Object webAgenda(url)

Get Agenda

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = WebAPIApi();
final url = url_example; // String | 

try {
    final result = api_instance.webAgenda(url);
    print(result);
} catch (e) {
    print('Exception when calling WebAPIApi->webAgenda: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **url** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **webAusweis**
> Object webAusweis(url)

Get Ausweis

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = WebAPIApi();
final url = url_example; // String | 

try {
    final result = api_instance.webAusweis(url);
    print(result);
} catch (e) {
    print('Exception when calling WebAPIApi->webAusweis: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **url** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **webListen**
> Object webListen(url)

Get Listen

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = WebAPIApi();
final url = url_example; // String | 

try {
    final result = api_instance.webListen(url);
    print(result);
} catch (e) {
    print('Exception when calling WebAPIApi->webListen: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **url** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **webNoten**
> Object webNoten(url)

Get Noten

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = WebAPIApi();
final url = url_example; // String | 

try {
    final result = api_instance.webNoten(url);
    print(result);
} catch (e) {
    print('Exception when calling WebAPIApi->webNoten: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **url** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **webUnterricht**
> Object webUnterricht(url)

Get Unterricht

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = WebAPIApi();
final url = url_example; // String | 

try {
    final result = api_instance.webUnterricht(url);
    print(result);
} catch (e) {
    print('Exception when calling WebAPIApi->webUnterricht: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **url** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

