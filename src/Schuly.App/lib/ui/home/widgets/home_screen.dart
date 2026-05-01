import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return PlatformScaffold(
      appBar: PlatformAppBar(title: Text(t.appTitle)),
      body: Center(child: Text(t.helloWorld)),
    );
  }
}
