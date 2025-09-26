import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';

class PrivacyConsentDialog extends StatelessWidget {
  const PrivacyConsentDialog({super.key});

  static Future<bool> hasUserConsented() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('privacy_consent') ?? false;
  }

  static Future<void> setUserConsent(bool consented) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('privacy_consent', consented);
    await prefs.setBool('privacy_consent_shown', true);
  }

  static Future<bool> hasConsentDialogBeenShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('privacy_consent_shown') ?? false;
  }

  static Future<bool?> show(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PrivacyConsentDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.privacy_tip_outlined,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(localizations.privacyAndDataCollection),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.welcomeToSchuly,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              localizations.privacyConsentIntro,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.whatWeCollect,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildDataPoint(
              context,
              Icons.bug_report_outlined,
              localizations.errorReports,
              localizations.errorReportsDesc,
            ),
            _buildDataPoint(
              context,
              Icons.phone_android,
              localizations.deviceInformation,
              localizations.deviceInformationDesc,
            ),
            _buildDataPoint(
              context,
              Icons.analytics_outlined,
              localizations.performanceData,
              localizations.performanceDataDesc,
            ),
            _buildDataPoint(
              context,
              Icons.touch_app,
              localizations.usagePatterns,
              localizations.usagePatternsDesc,
            ),
            _buildDataPoint(
              context,
              Icons.person_outline,
              localizations.userContext,
              localizations.userContextDesc,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.whatWeDontCollect,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            _buildDataPoint(
              context,
              Icons.lock_outline,
              localizations.personalData,
              localizations.personalDataDesc,
              isPositive: true,
            ),
            _buildDataPoint(
              context,
              Icons.password,
              localizations.credentials,
              localizations.credentialsDesc,
              isPositive: true,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      localizations.privacyConsentChangeAnytime,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                children: [
                  TextSpan(
                    text: '${localizations.privacyConsentHelpMessage} ',
                  ),
                  TextSpan(
                    text: 'Learn more',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Could open privacy policy URL here
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await setUserConsent(false);
            if (context.mounted) {
              Navigator.of(context).pop(false);
            }
          },
          child: Text(
            localizations.privacyConsentDecline,
            style: TextStyle(
              color: theme.colorScheme.error,
            ),
          ),
        ),
        FilledButton(
          onPressed: () async {
            await setUserConsent(true);
            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          },
          child: Text(localizations.privacyConsentAccept),
        ),
      ],
    );
  }

  Widget _buildDataPoint(
    BuildContext context,
    IconData icon,
    String title,
    String description, {
    bool isPositive = false,
  }) {
    final theme = Theme.of(context);
    final color = isPositive ? Colors.green : theme.colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: color.withValues(alpha: 0.7),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: color.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}