import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';
import '../../services/api_client.dart';
import 'schulnetz_oauth_screen.dart';

/// Connects a Schulnetz school account on the backend.
///
/// Pushed as its own route. Pops with the new account id (`String`) on success
/// or `null` if the user cancels / a failure occurred.
class ConnectAccountScreen extends StatefulWidget {
  const ConnectAccountScreen({super.key});

  @override
  State<ConnectAccountScreen> createState() => _ConnectAccountScreenState();
}

class _ConnectAccountScreenState extends State<ConnectAccountScreen> {
  final _urlCtrl = TextEditingController(text: 'https://schulnetz.bbbaden.ch');
  final _nameCtrl = TextEditingController(text: 'BBBaden');
  bool _busy = false;
  String? _error;

  SchulyApi get _api => ApiClient.instance.api;

  @override
  void dispose() {
    _urlCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  T _expectJson<T>(Response<void> response) {
    final data = response.data as Object?;
    if (data is! T) {
      throw StateError('Expected ${T.toString()}, got ${data.runtimeType}: $data');
    }
    return data;
  }

  Future<void> _create() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final url = _urlCtrl.text.trim();
      final accountsApi = _api.getAccountsApi();
      final oauthApi = _api.getOAuthApi();
      String? accountId;

      // 1. Reuse an existing row if the user is reconnecting the same school.
      final list = await accountsApi.apiPluginsSchulwareAccountsGet();
      final accounts =
          _expectJson<List<dynamic>>(list).cast<Map<String, dynamic>>();
      for (final a in accounts) {
        if (a['schulnetzBaseUrl'] == url) {
          accountId = a['id'] as String;
          break;
        }
      }

      // 2. Otherwise create a fresh row.
      if (accountId == null) {
        final create = await accountsApi.apiPluginsSchulwareAccountsPost(
          connectAccountRequest: ConnectAccountRequest((b) => b
            ..schulnetzBaseUrl = url
            ..displayName = _nameCtrl.text.trim()),
        );
        accountId = _expectJson<Map<String, dynamic>>(create)['id'] as String;
      }

      // 3. Backend hands back the Schulnetz authorize URL + PKCE verifier.
      final urlRes =
          await oauthApi.apiPluginsSchulwareAccountsAccountIdAuthOauthUrlGet(
        accountId: accountId,
      );
      final urlData = _expectJson<Map<String, dynamic>>(urlRes);
      final authorizationUrl = urlData['authorizationUrl'] as String;
      final codeVerifier = urlData['codeVerifier'] as String;

      // 4. Drive Schulnetz's OAuth in a WebView and capture the SSO chain.
      if (!mounted) return;
      final result = await Navigator.of(context).push<SchulnetzOAuthResult>(
        MaterialPageRoute(
          builder: (_) =>
              SchulnetzOAuthScreen(authorizationUrl: authorizationUrl),
        ),
      );
      if (result == null) {
        setState(() => _error = 'Login cancelled');
        return;
      }

      // 5. Hand the captured code + storage_state back so the backend can
      //    finish token exchange and replay the SSO chain on refresh.
      await oauthApi
          .apiPluginsSchulwareAccountsAccountIdAuthOauthCallbackPost(
        accountId: accountId,
        oAuthCallbackRequest: OAuthCallbackRequest((b) => b
          ..code = result.code
          ..codeVerifier = codeVerifier
          ..state = result.state
          ..contextState = result.contextState
          ..userAgent = result.userAgent),
      );

      if (mounted) Navigator.of(context).pop(accountId);
    } on DioException catch (e) {
      final body = e.response?.data;
      final status = e.response?.statusCode;
      setState(() => _error =
          'HTTP ${status ?? '?'} ${e.requestOptions.method} '
          '${e.requestOptions.path}\n$body');
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Add Schulnetz Account'),
        prefixes: [
          FHeaderAction.back(
            onPress: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          FTextField(
            control: FTextFieldControl.managed(controller: _urlCtrl),
            label: const Text('Schulnetz Base URL'),
            hint: 'https://schulnetz.example.ch',
            keyboardType: TextInputType.url,
          ),
          FTextField(
            control: FTextFieldControl.managed(controller: _nameCtrl),
            label: const Text('Display Name'),
          ),
          FButton(
            onPress: _busy ? null : _create,
            child: Text(_busy ? 'Working...' : 'Connect'),
          ),
          if (_error != null)
            SelectableText(_error!,
                style: TextStyle(color: colors.destructive)),
        ],
      ),
    );
  }
}
