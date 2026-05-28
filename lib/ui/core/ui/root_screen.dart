import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../l10n/app_localizations.dart';
import '../../../services/active_account_service.dart';
import '../../../services/auth_service.dart';
import '../../dashboard/dashboard_screen.dart';

/// Tier-1 gate: until the user has signed in with Pocket ID, nothing else is
/// reachable. Once signed in, [DashboardScreen] owns the avatar, sidebar, and
/// add-account flow.
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  bool? _signedIn;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // React to session changes — including a failed silent refresh, which
    // signs the user out from inside the API interceptor.
    AuthService.sessionEpoch.addListener(_refresh);
    _refresh();
  }

  @override
  void dispose() {
    AuthService.sessionEpoch.removeListener(_refresh);
    super.dispose();
  }

  Future<void> _refresh() async {
    final token = await AuthService.getAccessToken();
    if (token == null) {
      await ActiveAccountService.instance.clear();
    }
    if (mounted) setState(() => _signedIn = token != null);
  }

  Future<void> _signIn() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await AuthService.signIn();
      await _refresh();
    } catch (e) {
      setState(() => _error = '$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _signOut() async {
    await AuthService.signOut();
    await ActiveAccountService.instance.clear();
    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final signedIn = _signedIn;

    if (signedIn == null) {
      return const FScaffold(child: Center(child: CircularProgressIndicator()));
    }

    if (signedIn) {
      return DashboardScreen(onSignOut: _signOut);
    }

    final colors = context.theme.colors;
    return FScaffold(
      header: const FHeader(title: Text('Schuly')),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            const Text(
              'Sign in to Pocket ID to use Schuly.',
              textAlign: TextAlign.center,
            ),
            FButton(
              onPress: _busy ? null : _signIn,
              child: Text(_busy ? 'Waiting for browser…' : t.signIn),
            ),
            if (_error != null)
              SelectableText(_error!,
                  style: TextStyle(color: colors.destructive)),
          ],
        ),
      ),
    );
  }
}
