# schuly_api.api.AccountsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsOdaorgAccountsAccountIdDelete**](AccountsApi.md#apipluginsodaorgaccountsaccountiddelete) | **DELETE** /api/plugins/odaorg/accounts/{accountId} | 
[**apiPluginsOdaorgAccountsGet**](AccountsApi.md#apipluginsodaorgaccountsget) | **GET** /api/plugins/odaorg/accounts | 
[**apiPluginsOdaorgAccountsPost**](AccountsApi.md#apipluginsodaorgaccountspost) | **POST** /api/plugins/odaorg/accounts | 
[**apiPluginsSchulwareAccountsAccountIdDelete**](AccountsApi.md#apipluginsschulwareaccountsaccountiddelete) | **DELETE** /api/plugins/schulware/accounts/{accountId} | 
[**apiPluginsSchulwareAccountsGet**](AccountsApi.md#apipluginsschulwareaccountsget) | **GET** /api/plugins/schulware/accounts | 
[**apiPluginsSchulwareAccountsPost**](AccountsApi.md#apipluginsschulwareaccountspost) | **POST** /api/plugins/schulware/accounts | 


# **apiPluginsOdaorgAccountsAccountIdDelete**
> apiPluginsOdaorgAccountsAccountIdDelete(accountId)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAccountsApi();
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiPluginsOdaorgAccountsAccountIdDelete(accountId);
} catch on DioException (e) {
    print('Exception when calling AccountsApi->apiPluginsOdaorgAccountsAccountIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiPluginsOdaorgAccountsGet**
> apiPluginsOdaorgAccountsGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAccountsApi();

try {
    api.apiPluginsOdaorgAccountsGet();
} catch on DioException (e) {
    print('Exception when calling AccountsApi->apiPluginsOdaorgAccountsGet: $e\n');
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

# **apiPluginsOdaorgAccountsPost**
> apiPluginsOdaorgAccountsPost(connectOdaOrgRequest)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAccountsApi();
final ConnectOdaOrgRequest connectOdaOrgRequest = ; // ConnectOdaOrgRequest | 

try {
    api.apiPluginsOdaorgAccountsPost(connectOdaOrgRequest);
} catch on DioException (e) {
    print('Exception when calling AccountsApi->apiPluginsOdaorgAccountsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **connectOdaOrgRequest** | [**ConnectOdaOrgRequest**](ConnectOdaOrgRequest.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiPluginsSchulwareAccountsAccountIdDelete**
> apiPluginsSchulwareAccountsAccountIdDelete(accountId)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAccountsApi();
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiPluginsSchulwareAccountsAccountIdDelete(accountId);
} catch on DioException (e) {
    print('Exception when calling AccountsApi->apiPluginsSchulwareAccountsAccountIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiPluginsSchulwareAccountsGet**
> apiPluginsSchulwareAccountsGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAccountsApi();

try {
    api.apiPluginsSchulwareAccountsGet();
} catch on DioException (e) {
    print('Exception when calling AccountsApi->apiPluginsSchulwareAccountsGet: $e\n');
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

# **apiPluginsSchulwareAccountsPost**
> apiPluginsSchulwareAccountsPost(connectAccountRequest)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAccountsApi();
final ConnectAccountRequest connectAccountRequest = ; // ConnectAccountRequest | 

try {
    api.apiPluginsSchulwareAccountsPost(connectAccountRequest);
} catch on DioException (e) {
    print('Exception when calling AccountsApi->apiPluginsSchulwareAccountsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **connectAccountRequest** | [**ConnectAccountRequest**](ConnectAccountRequest.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

