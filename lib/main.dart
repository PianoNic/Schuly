import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'l10n/app_localizations.dart';
import 'ui/core/ui/root_screen.dart';

void main() => runApp(const SchulyApp());

class SchulyApp extends StatelessWidget {
  const SchulyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = const {
      TargetPlatform.android,
      TargetPlatform.iOS,
      TargetPlatform.fuchsia,
    }.contains(defaultTargetPlatform)
        ? FThemes.zinc.dark
        : FThemes.zinc.dark;

    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        ...FLocalizations.localizationsDelegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: theme.toApproximateMaterialTheme(),
      builder: (_, child) => FAnimatedTheme(data: theme, child: child!),
      home: const RootScreen(),
    );
  }
}
