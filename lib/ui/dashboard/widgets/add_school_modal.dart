import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

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
    enabled: false,
  ),
];

/// Shows the school-system picker. Resolves to the chosen [SchoolSystem.id]
/// or `null` if the user dismissed.
Future<String?> showAddSchoolModal(BuildContext context) {
  return showFDialog<String>(
    context: context,
    builder: (dialogCtx, style, animation) => FDialog(
      animation: animation,
      title: const Text('Choose a school system'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final s in _systems)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: _SystemCard(
                system: s,
                onTap: s.enabled
                    ? () => Navigator.of(dialogCtx).pop(s.id)
                    : null,
              ),
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
    final image = Image.asset(system.assetPath, width: 40, height: 40);
    return Opacity(
      opacity: onTap == null ? 0.5 : 1.0,
      child: FCard(
        child: FTile(
          prefix: image,
          title: Text(system.label),
          subtitle: onTap == null
              ? Text('Coming soon', style: TextStyle(color: colors.mutedForeground))
              : null,
          onPress: onTap,
        ),
      ),
    );
  }
}
