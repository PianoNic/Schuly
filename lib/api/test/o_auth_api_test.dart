import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for OAuthApi
void main() {
  final instance = SchulyApi().getOAuthApi();

  group(OAuthApi, () {
    //Future apiPluginsSchulwareAccountsAccountIdAuthOauthCallbackPost(String accountId, { OAuthCallbackRequest oAuthCallbackRequest }) async
    test('test apiPluginsSchulwareAccountsAccountIdAuthOauthCallbackPost', () async {
      // TODO
    });

    //Future apiPluginsSchulwareAccountsAccountIdAuthOauthUrlGet(String accountId) async
    test('test apiPluginsSchulwareAccountsAccountIdAuthOauthUrlGet', () async {
      // TODO
    });

  });
}
