import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../services/active_account_service.dart';
import '../../schulnetz/connect_account_screen.dart';
import 'add_school_modal.dart';

/// Left-edge sheet listing all connected school accounts plus an "Add school
/// account" entry. Lives behind the dashboard avatar.
///
/// The sheet owns the add-account flow: it shows the system picker, pushes
/// the connect screen on the *parent* navigator (so it survives sheet
/// dismissal), and on success refreshes the accounts list and selects the
/// new account.
class AccountsSidebar extends StatelessWidget {
  /// Parent navigator — needed for pushing the connect screen, since this
  /// widget is mounted inside a modal sheet route.
  final NavigatorState parentNavigator;
  final VoidCallback? onSignOut;

  const AccountsSidebar({
    super.key,
    required this.parentNavigator,
    this.onSignOut,
  });

  Future<void> _add(BuildContext context) async {
    final picked = await showAddSchoolModal(context);
    if (picked == null) return;
    // Today there's only Schulnetz. Future systems would branch here.
    final newId = await parentNavigator.push<String>(
      MaterialPageRoute(builder: (_) => const ConnectAccountScreen()),
    );
    if (newId == null) return;
    await ActiveAccountService.instance.refresh();
    await ActiveAccountService.instance.setActive(newId);
    // Close the sheet itself after a successful add.
    if (context.mounted) Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ActiveAccountService.instance,
      builder: (context, _) {
        final svc = ActiveAccountService.instance;
        final active = svc.active;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text(
                    'Your schools',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      for (final a in svc.accounts)
                        FTile(
                          selected: a.id == active?.id,
                          prefix: const Icon(FIcons.graduationCap),
                          title: Text(a.displayName),
                          subtitle: Text(a.schulnetzBaseUrl),
                          onPress: () async {
                            await svc.setActive(a.id);
                            if (context.mounted) {
                              Navigator.of(context).maybePop();
                            }
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                FTile(
                  prefix: const Icon(FIcons.plus),
                  title: const Text('Add school account'),
                  onPress: () => _add(context),
                ),
                if (onSignOut != null) ...[
                  const SizedBox(height: 8),
                  FTile(
                    prefix: const Icon(FIcons.logOut),
                    title: const Text('Sign out'),
                    onPress: () {
                      Navigator.of(context).maybePop();
                      onSignOut!();
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Convenience wrapper that opens the sidebar as a left-side modal sheet.
Future<void> openAccountsSidebar(
  BuildContext context, {
  VoidCallback? onSignOut,
}) {
  final parentNavigator = Navigator.of(context);
  return showFSheet<void>(
    context: context,
    side: FLayout.ltr,
    mainAxisMaxRatio: 0.85,
    builder: (sheetCtx) => AccountsSidebar(
      parentNavigator: parentNavigator,
      onSignOut: onSignOut,
    ),
  );
}
