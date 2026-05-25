import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/plugin_api.dart';
import '../../services/auth_service.dart';
import '../schulnetz/connect_account_screen.dart';

class PluginTestScreen extends StatefulWidget {
  const PluginTestScreen({super.key});

  @override
  State<PluginTestScreen> createState() => _PluginTestScreenState();
}

class _PluginTestScreenState extends State<PluginTestScreen> {
  String _output = 'Tap a button to call an endpoint.';
  bool _busy = false;

  Future<void> _run(String label, Future<dynamic> Function() fn) async {
    setState(() {
      _busy = true;
      _output = '$label …';
    });
    try {
      final r = await fn();
      if (r is bool) {
        setState(() => _output = '[$label] -> $r');
      } else {
        // http.Response
        setState(() => _output = '[$label] HTTP ${r.statusCode}\n\n${r.body}');
      }
    } catch (e) {
      setState(() => _output = '[$label] ERROR: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Pulls the first account and runs an immediate sync on it.
  Future<void> _syncFirstAccount() async {
    await _run('sync', () async {
      final list = await PluginApi.listAccounts();
      if (list.statusCode != 200) return list;
      final accounts = jsonDecode(list.body) as List<dynamic>;
      if (accounts.isEmpty) {
        return http.Response('No accounts. Connect one first.', 400);
      }
      final accountId = (accounts.first as Map<String, dynamic>)['id'] as String;
      return PluginApi.triggerSync(accountId);
    });
  }

  Future<void> _connectAccount() async {
    final added = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const ConnectAccountScreen()),
    );
    if (added == true) {
      await _run('accounts', PluginApi.listAccounts);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin Test')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(spacing: 8, runSpacing: 8, children: [
              ElevatedButton(
                onPressed: _busy ? null : () => _run('status', PluginApi.getStatus),
                child: const Text('GET /status'),
              ),
              ElevatedButton(
                onPressed: _busy ? null : () => _run('accounts', PluginApi.listAccounts),
                child: const Text('GET /accounts'),
              ),
              ElevatedButton(
                onPressed: _busy ? null : _connectAccount,
                child: const Text('Connect Schulnetz Account'),
              ),
              ElevatedButton(
                onPressed: _busy ? null : _syncFirstAccount,
                child: const Text('Sync now (refresh + fetch)'),
              ),
              ElevatedButton(
                onPressed: _busy
                    ? null
                    : () async {
                        await AuthService.signOut();
                        if (mounted) setState(() => _output = 'Signed out.');
                      },
                child: const Text('Sign out'),
              ),
            ]),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    _output,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
