import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';
import '../../services/api_client.dart';
import 'schulnetz_oauth_screen.dart';

class ConnectAccountScreen extends StatefulWidget {
  final VoidCallback? onSignOut;
  const ConnectAccountScreen({super.key, this.onSignOut});

  @override
  State<ConnectAccountScreen> createState() => _ConnectAccountScreenState();
}

class _ConnectAccountScreenState extends State<ConnectAccountScreen> {
  final _urlCtrl = TextEditingController(text: 'https://schulnetz.bbbaden.ch');
  final _nameCtrl = TextEditingController(text: 'BBBaden');
  bool _busy = false;
  String? _error;
  String? _pingResult;

  SchulyApi get _api => ApiClient.instance.api;

  @override
  void dispose() {
    _urlCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _checkBackend() async {
    setState(() {
      _busy = true;
      _error = null;
      _pingResult = null;
    });
    try {
      final response = await _api.getPluginsApi().apiPluginsGet();
      final plugins = response.data ?? BuiltList<PluginDto>();
      setState(() => _pingResult =
          'Backend OK — ${plugins.length} plugin(s): ${plugins.map((p) => p.name).join(', ')}');
    } catch (e) {
      setState(() => _error = 'Backend check failed: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Untyped JSON body extractor. The generated APIs declare `Response<void>`
  /// because the backend's OpenAPI spec omits response schemas, but the raw
  /// body is still on `response.data` as `Object?` from the underlying Dio
  /// call. We narrow to the shape we expect at the call site.
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
      _pingResult = null;
    });
    try {
      final url = _urlCtrl.text.trim();
      final accountsApi = _api.getAccountsApi();
      final oauthApi = _api.getOAuthApi();
      String? accountId;

      // 1. Reuse the existing row for this Schulnetz URL if there is one.
      final list = await accountsApi.apiPluginsSchulwareAccountsGet();
      final accounts = _expectJson<List<dynamic>>(list).cast<Map<String, dynamic>>();
      for (final a in accounts) {
        if (a['schulnetzBaseUrl'] == url) {
          accountId = a['id'] as String;
          break;
        }
      }

      // 2. Otherwise create a fresh one.
      if (accountId == null) {
        final create = await accountsApi.apiPluginsSchulwareAccountsPost(
          connectAccountRequest: ConnectAccountRequest((b) => b
            ..schulnetzBaseUrl = url
            ..displayName = _nameCtrl.text.trim()),
        );
        accountId = _expectJson<Map<String, dynamic>>(create)['id'] as String;
      }

      // 3. Ask backend for Schulnetz authorize URL + PKCE verifier.
      final urlRes = await oauthApi.apiPluginsSchulwareAccountsAccountIdAuthOauthUrlGet(
        accountId: accountId,
      );
      final urlData = _expectJson<Map<String, dynamic>>(urlRes);
      final authorizationUrl = urlData['authorizationUrl'] as String;
      final codeVerifier = urlData['codeVerifier'] as String;

      // 4. Drive Schulnetz OAuth in a WebView, capture the final code.
      if (!mounted) return;
      final result = await Navigator.of(context).push<SchulnetzOAuthResult>(
        MaterialPageRoute(
          builder: (_) => SchulnetzOAuthScreen(authorizationUrl: authorizationUrl),
        ),
      );
      if (result == null) {
        setState(() => _error = 'Login cancelled');
        return;
      }

      // 5. Hand code + context_state + UA back to the backend so the
      //    stateless refresh flow can replay the SSO chain.
      await oauthApi.apiPluginsSchulwareAccountsAccountIdAuthOauthCallbackPost(
        accountId: accountId,
        oAuthCallbackRequest: OAuthCallbackRequest((b) => b
          ..code = result.code
          ..codeVerifier = codeVerifier
          ..state = result.state
          ..contextState = result.contextState
          ..userAgent = result.userAgent),
      );

      if (mounted) setState(() => _pingResult = 'Connected $accountId');
    } on DioException catch (e) {
      // Dio's generic .toString() hides the response body. Surface it so
      // backend ProblemDetails / validation errors are visible.
      final body = e.response?.data;
      final status = e.response?.statusCode;
      setState(() => _error = 'HTTP ${status ?? '?'} ${e.requestOptions.method} '
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
      header: FHeader(
        title: const Text('Connect Schulnetz Account'),
        suffixes: [
          if (widget.onSignOut != null)
            FHeaderAction(
              icon: const Icon(FIcons.logOut),
              onPress: widget.onSignOut,
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
          FButton(
            onPress: _busy ? null : _checkBackend,
            child: const Text('Check backend (generated client)'),
          ),
          if (_pingResult != null)
            SelectableText(_pingResult!, style: TextStyle(color: colors.primary)),
          if (_error != null)
            SelectableText(_error!, style: TextStyle(color: colors.destructive)),
        ],
      ),
    );
  }
}
