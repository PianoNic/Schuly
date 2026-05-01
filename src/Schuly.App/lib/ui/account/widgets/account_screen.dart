import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../l10n/app_localizations.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return PlatformScaffold(
      appBar: PlatformAppBar(title: Text(t.tabAccount)),
      body: Center(child: Text(t.tabAccount)),
    );
  }
}
