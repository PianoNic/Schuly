import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/url_launcher_helper.dart';

class HelpSupportModal extends StatelessWidget {
  const HelpSupportModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'Hilfe & Support',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            
            Text(
              'Brauchst du Hilfe oder hast Feedback? Wähle eine der folgenden Optionen:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),

            // Email Support Card
            Card(
              child: InkWell(
                onTap: () => _launchEmail(context),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 32,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'E-Mail Support',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
            Text(
                              'Kontaktiere mich direkt per E-Mail',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'contact@pianonic.ch',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // GitHub Issues Card
            Card(
              child: InkWell(
                onTap: () => _launchGitHub(context),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bug_report_outlined,
                        size: 32,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bug Report / Feature Request',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Melde Bugs oder schlage neue Features vor',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'GitHub Issues',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Close Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Schließen'),
              ),
            ),
            const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchEmail(BuildContext context) async {
    const email = 'contact@pianonic.ch';
    const subject = 'Schuly App - Support Anfrage';
    
    try {
      // Use simple platform channel approach
      final bool launched = await UrlLauncherHelper.launchEmail(
        email,
        subject: subject,
      );

      if (launched && context.mounted) {
        Navigator.of(context).pop();
      } else if (context.mounted) {
        _showErrorDialog(
          context, 
          'E-Mail-App konnte nicht geöffnet werden. Bitte kontaktieren Sie uns manuell unter: $email',
          copyText: email,
        );
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(
          context, 
          'Fehler beim Öffnen der E-Mail-App. Bitte kontaktieren Sie uns manuell unter: $email',
          copyText: email,
        );
      }
    }
  }

  Future<void> _launchGitHub(BuildContext context) async {
    const url = 'https://github.com/PianoNic/schuly/issues';
    
    try {
      final bool launched = await UrlLauncherHelper.launchUrl(url);

      if (launched && context.mounted) {
        Navigator.of(context).pop();
      } else if (context.mounted) {
        _showErrorDialog(
          context, 
          'Browser konnte nicht geöffnet werden. Bitte besuchen Sie manuell: $url',
          copyText: url,
        );
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(
          context, 
          'Fehler beim Öffnen des Browsers. Bitte besuchen Sie manuell: $url',
          copyText: url,
        );
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message, {String? copyText}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fehler'),
          content: Text(message),
          actions: [
            if (copyText != null)
              TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: copyText));
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('In Zwischenablage kopiert'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('Kopieren'),
              ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}