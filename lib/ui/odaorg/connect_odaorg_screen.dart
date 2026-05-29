import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../services/api_client.dart';

/// Connects an OdaOrg account. Unlike Schulnetz (OAuth/WebView), OdaOrg uses
/// plain username/password credentials posted to the backend, which then runs
/// the initial sync. Pops with the new account id (String) on success.
class ConnectOdaOrgScreen extends StatefulWidget {
  const ConnectOdaOrgScreen({super.key});

  @override
  State<ConnectOdaOrgScreen> createState() => _ConnectOdaOrgScreenState();
}

class _ConnectOdaOrgScreenState extends State<ConnectOdaOrgScreen> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _urlCtrl = TextEditingController(text: 'https://www.oda.org');
  final _nameCtrl = TextEditingController(text: 'OdAOrg');
  bool _busy = false;
  String? _error;

  SchulyApi get _api => ApiClient.instance.api;

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
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

  Future<void> _connect() async {
    final user = _userCtrl.text.trim();
    final pass = _passCtrl.text;
    if (user.isEmpty || pass.isEmpty) {
      setState(() => _error = 'Username and password are required');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final accountsApi = _api.getAccountsApi();
      final create = await accountsApi.apiPluginsOdaorgAccountsPost(
        connectOdaOrgRequest: ConnectOdaOrgRequest((b) => b
          ..username = user
          ..password = pass
          ..baseUrl = _urlCtrl.text.trim()
          ..displayName = _nameCtrl.text.trim()),
      );
      final accountId = _expectJson<Map<String, dynamic>>(create)['id'] as String;

      // Kick off the initial sync so data lands before we return.
      await _api.getSyncApi().apiPluginsOdaorgAccountsAccountIdSyncPost(accountId: accountId);

      if (mounted) Navigator.of(context).pop(accountId);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final body = e.response?.data;
      setState(() => _error = 'HTTP ${status ?? '?'}: $body');
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
        title: const Text('Add OdAOrg Account'),
        prefixes: [FHeaderAction.back(onPress: () => Navigator.of(context).pop())],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          FTextField(
            control: FTextFieldControl.managed(controller: _userCtrl),
            label: const Text('Username'),
            hint: 'e.g. LRN26487',
            autocorrect: false,
          ),
          FTextField(
            control: FTextFieldControl.managed(controller: _passCtrl),
            label: const Text('Password'),
            obscureText: true,
            autocorrect: false,
          ),
          FTextField(
            control: FTextFieldControl.managed(controller: _urlCtrl),
            label: const Text('Base URL'),
            keyboardType: TextInputType.url,
          ),
          FTextField(
            control: FTextFieldControl.managed(controller: _nameCtrl),
            label: const Text('Display Name'),
          ),
          FButton(
            onPress: _busy ? null : _connect,
            child: Text(_busy ? 'Connecting…' : 'Connect'),
          ),
          if (_error != null)
            SelectableText(_error!, style: TextStyle(color: colors.destructive)),
        ],
      ),
    );
  }
}
