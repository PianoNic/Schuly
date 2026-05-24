import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/oidc_config.dart';
import '../../../l10n/app_localizations.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  Future<void> _openAuthPage() async {
    final url = Uri.parse(OidcConfig.authority).replace(
      path: '/authorize',
      queryParameters: {
        'client_id': OidcConfig.clientId,
        'response_type': 'code',
        'scope': OidcConfig.scope,
        'redirect_uri': OidcConfig.redirectUri,
        'state': 'test',
      },
    );
    await launchUrl(url, mode: LaunchMode.inAppBrowserView);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return PlatformScaffold(
      body: SafeArea(
        child: Center(
          child: PlatformElevatedButton(
            onPressed: _openAuthPage,
            child: Text(t.signIn),
          ),
        ),
      ),
    );
  }
}
