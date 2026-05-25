import 'dart:convert';
import 'package:flutter/material.dart';
import '../../services/plugin_api.dart';
import 'schulnetz_oauth_screen.dart';

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

  Future<void> _create() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final url = _urlCtrl.text.trim();
      String? accountId;

      // 1. Reuse the existing row for this Schulnetz URL if there is one
      //    (it may be left over from a half-finished previous attempt). The
      //    plugin returns 400 on duplicate POST, so we look up first.
      final list = await PluginApi.listAccounts();
      if (list.statusCode == 200) {
        final accounts = jsonDecode(list.body) as List<dynamic>;
        for (final a in accounts.cast<Map<String, dynamic>>()) {
          if (a['schulnetzBaseUrl'] == url) {
            accountId = a['id'] as String;
            break;
          }
        }
      }
      if (accountId == null) {
        final create = await PluginApi.createAccount(
          schulnetzBaseUrl: url,
          displayName: _nameCtrl.text.trim(),
        );
        if (create.statusCode != 200) {
          throw Exception('createAccount ${create.statusCode}: ${create.body}');
        }
        accountId = (jsonDecode(create.body) as Map<String, dynamic>)['id'] as String;
      }

      // 2. Ask plugin (via SchulwareAPI) for the Schulnetz authorize URL + verifier.
      final urlRes = await PluginApi.getOAuthUrl(accountId);
      if (urlRes.statusCode != 200) {
        throw Exception('getOAuthUrl ${urlRes.statusCode}: ${urlRes.body}');
      }
      final urlData = jsonDecode(urlRes.body) as Map<String, dynamic>;
      final authorizationUrl = urlData['authorizationUrl'] as String;
      final codeVerifier = urlData['codeVerifier'] as String;

      // 3. Drive the Schulnetz OAuth in a WebView, capture the final code.
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

      // 4. Hand code + context_state + UA back to the plugin. context_state
      //    is required by the stateless refresh flow (see
      //    SchulwareAPI test-app MainActivity.kt for the same scheme).
      final callbackRes = await PluginApi.completeOAuth(
        accountId: accountId,
        code: result.code,
        codeVerifier: codeVerifier,
        state: result.state,
        contextState: result.contextState,
        userAgent: result.userAgent,
      );
      if (callbackRes.statusCode != 200) {
        throw Exception('callback ${callbackRes.statusCode}: ${callbackRes.body}');
      }

      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connect Schulnetz Account')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _urlCtrl,
              decoration: const InputDecoration(
                labelText: 'Schulnetz Base URL',
                hintText: 'https://schulnetz.example.ch',
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Display Name'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _busy ? null : _create,
              child: Text(_busy ? 'Working...' : 'Connect'),
            ),
            if (_error != null) ...[
              const SizedBox(height: 16),
              SelectableText(_error!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}
