import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../l10n/app_localizations.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return PlatformScaffold(
      appBar: PlatformAppBar(title: Text(t.tabGrades)),
      body: Center(child: Text(t.tabGrades)),
    );
  }
}
