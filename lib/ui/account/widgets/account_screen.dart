import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../l10n/app_localizations.dart';
import '../../plugin_test/plugin_test_screen.dart';
import '../../../services/auth_service.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _signedIn = false;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final token = await AuthService.getAccessToken();
    if (mounted) setState(() => _signedIn = token != null);
  }

  Future<void> _signIn() async {
    setState(() => _busy = true);
    try {
      await AuthService.signIn();
      await _refresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _openPluginTest() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PluginTestScreen()),
    );
  }

  Future<void> _signOut() async {
    await AuthService.signOut();
    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return PlatformScaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!_signedIn)
                PlatformElevatedButton(
                  onPressed: _busy ? null : _signIn,
                  child: Text(_busy ? 'Waiting for browser...' : t.signIn),
                )
              else ...[
                const Text('Signed in'),
                const SizedBox(height: 12),
                PlatformElevatedButton(
                  onPressed: _openPluginTest,
                  child: const Text('Open Plugin Test'),
                ),
                const SizedBox(height: 8),
                PlatformElevatedButton(
                  onPressed: _signOut,
                  child: const Text('Sign out'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
