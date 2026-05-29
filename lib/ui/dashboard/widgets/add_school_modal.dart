import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../odaorg/connect_odaorg_screen.dart';
import '../../schulnetz/connect_account_screen.dart';

/// A school system the user can connect. Today only Schulnetz; the modal is
/// shaped as a list so additional providers slot in without UX churn.
class SchoolSystem {
  final String id;
  final String label;
  final String assetPath;
  /// When false the card is rendered greyed out with a "coming soon" hint
  /// and tapping is a no-op. Lets us advertise upcoming integrations without
  /// wiring them.
  final bool enabled;
  const SchoolSystem({
    required this.id,
    required this.label,
    required this.assetPath,
    this.enabled = true,
  });
}

const _systems = <SchoolSystem>[
  SchoolSystem(
    id: 'schulnetz',
    label: 'Schulnetz',
    assetPath: 'assets/schoolsystems/schulnetz.webp',
  ),
  SchoolSystem(
    id: 'odaorg',
    label: 'OdAOrg',
    assetPath: 'assets/schoolsystems/odaorg.webp',
  ),
];

/// Full add-school flow: show the school-system picker, then run the chosen
/// system's connect screen. Returns the new account id, or null if the user
/// cancelled at any step. [navigator] is the navigator the connect screen is
/// pushed onto — pass the dashboard's, not a sheet/dialog navigator that may
/// be torn down mid-flow.
Future<String?> runAddSchoolFlow(
  BuildContext context,
  NavigatorState navigator,
) async {
  final system = await showAddSchoolModal(context);
  if (system == null) return null;
  // Each provider has its own connect screen — Schulnetz uses OAuth (WebView),
  // OdAOrg uses username/password.
  final Widget screen = switch (system) {
    'odaorg' => const ConnectOdaOrgScreen(),
    _ => const ConnectAccountScreen(),
  };
  return navigator.push<String>(MaterialPageRoute(builder: (_) => screen));
}

/// Shows the school-system picker. Resolves to the chosen [SchoolSystem.id]
/// or `null` if the user dismissed.
Future<String?> showAddSchoolModal(BuildContext context) {
  return showFDialog<String>(
    context: context,
    builder: (dialogCtx, style, animation) => FDialog(
      animation: animation,
      title: const Text('Choose a school system'),
      body: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: [
          for (final s in _systems)
            _SystemCard(
              system: s,
              onTap: s.enabled ? () => Navigator.of(dialogCtx).pop(s.id) : null,
            ),
        ],
      ),
      actions: [
        FButton(
          onPress: () => Navigator.of(dialogCtx).pop(),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}

class _SystemCard extends StatelessWidget {
  final SchoolSystem system;
  final VoidCallback? onTap;
  const _SystemCard({required this.system, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final disabled = onTap == null;
    return Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: SizedBox(
        width: 120,
        height: 120,
        child: FTappable(
          onPress: onTap,
          child: FCard(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(system.assetPath, width: 48, height: 48),
                  const SizedBox(height: 10),
                  Text(
                    system.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (disabled)
                    Text(
                      'Coming soon',
                      style: TextStyle(
                        fontSize: 11,
                        color: colors.mutedForeground,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
