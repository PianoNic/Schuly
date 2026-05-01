# schuly_api.api.AgendasApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAgendasGet**](AgendasApi.md#apiagendasget) | **GET** /api/Agendas | 
[**apiAgendasIdDelete**](AgendasApi.md#apiagendasiddelete) | **DELETE** /api/Agendas/{id} | 
[**apiAgendasPost**](AgendasApi.md#apiagendaspost) | **POST** /api/Agendas | 
[**apiAgendasPut**](AgendasApi.md#apiagendasput) | **PUT** /api/Agendas | 
[**apiAgendasSearchGet**](AgendasApi.md#apiagendassearchget) | **GET** /api/Agendas/search | 


# **apiAgendasGet**
> BuiltList<AgendaEntryDto> apiAgendasGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAgendasApi();

try {
    final response = api.apiAgendasGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AgendasApi->apiAgendasGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;AgendaEntryDto&gt;**](AgendaEntryDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAgendasIdDelete**
> apiAgendasIdDelete(id)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAgendasApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiAgendasIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling AgendasApi->apiAgendasIdDelete: $e\n');
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

# **apiAgendasPost**
> apiAgendasPost(createAgendaEntryCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAgendasApi();
final CreateAgendaEntryCommand createAgendaEntryCommand = ; // CreateAgendaEntryCommand | 

try {
    api.apiAgendasPost(createAgendaEntryCommand);
} catch on DioException (e) {
    print('Exception when calling AgendasApi->apiAgendasPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createAgendaEntryCommand** | [**CreateAgendaEntryCommand**](CreateAgendaEntryCommand.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAgendasPut**
> apiAgendasPut(updateAgendaEntryCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAgendasApi();
final UpdateAgendaEntryCommand updateAgendaEntryCommand = ; // UpdateAgendaEntryCommand | 

try {
    api.apiAgendasPut(updateAgendaEntryCommand);
} catch on DioException (e) {
    print('Exception when calling AgendasApi->apiAgendasPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateAgendaEntryCommand** | [**UpdateAgendaEntryCommand**](UpdateAgendaEntryCommand.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAgendasSearchGet**
> AgendaEntryDto apiAgendasSearchGet(agendaEntryId)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAgendasApi();
final String agendaEntryId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiAgendasSearchGet(agendaEntryId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AgendasApi->apiAgendasSearchGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **agendaEntryId** | **String**|  | [optional] 

### Return type

[**AgendaEntryDto**](AgendaEntryDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

