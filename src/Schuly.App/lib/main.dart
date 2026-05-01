import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'l10n/app_localizations.dart';
import 'ui/core/ui/root_screen.dart';

void main() => runApp(const SchulyApp());

class SchulyApp extends StatelessWidget {
  const SchulyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder: (context) => PlatformApp(
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const RootScreen(),
      ),
    );
  }
}
