# schuly_api.api.OAuthApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsSchulwareAccountsAccountIdAuthOauthCallbackPost**](OAuthApi.md#apipluginsschulwareaccountsaccountidauthoauthcallbackpost) | **POST** /api/plugins/schulware/accounts/{accountId}/auth/oauth/callback | 
[**apiPluginsSchulwareAccountsAccountIdAuthOauthUrlGet**](OAuthApi.md#apipluginsschulwareaccountsaccountidauthoauthurlget) | **GET** /api/plugins/schulware/accounts/{accountId}/auth/oauth/url | 


# **apiPluginsSchulwareAccountsAccountIdAuthOauthCallbackPost**
> apiPluginsSchulwareAccountsAccountIdAuthOauthCallbackPost(accountId, oAuthCallbackRequest)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getOAuthApi();
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final OAuthCallbackRequest oAuthCallbackRequest = ; // OAuthCallbackRequest | 

try {
    api.apiPluginsSchulwareAccountsAccountIdAuthOauthCallbackPost(accountId, oAuthCallbackRequest);
} catch on DioException (e) {
    print('Exception when calling OAuthApi->apiPluginsSchulwareAccountsAccountIdAuthOauthCallbackPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **oAuthCallbackRequest** | [**OAuthCallbackRequest**](OAuthCallbackRequest.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiPluginsSchulwareAccountsAccountIdAuthOauthUrlGet**
> apiPluginsSchulwareAccountsAccountIdAuthOauthUrlGet(accountId)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getOAuthApi();
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiPluginsSchulwareAccountsAccountIdAuthOauthUrlGet(accountId);
} catch on DioException (e) {
    print('Exception when calling OAuthApi->apiPluginsSchulwareAccountsAccountIdAuthOauthUrlGet: $e\n');
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

