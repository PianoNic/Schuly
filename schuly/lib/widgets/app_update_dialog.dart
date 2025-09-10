import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../models/release_note.dart';
import '../services/app_update_service.dart';

class AppUpdateDialog extends StatefulWidget {
  final ReleaseNote updateRelease;

  const AppUpdateDialog({
    super.key,
    required this.updateRelease,
  });

  static Future<void> showIfAvailable(BuildContext context) async {
    final updateRelease = await AppUpdateService.checkForUpdates();
    if (updateRelease != null && context.mounted) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AppUpdateDialog(updateRelease: updateRelease),
      );
    }
  }

  @override
  State<AppUpdateDialog> createState() => _AppUpdateDialogState();
}

class _AppUpdateDialogState extends State<AppUpdateDialog> {
  bool _isDownloading = false;
  double _downloadProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.system_update,
            color: theme.colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Update verfügbar!'),
                Text(
                  'Version ${widget.updateRelease.version}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350, maxHeight: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Release title
            Text(
              widget.updateRelease.title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Markdown content in scrollable area
            Flexible(
              child: SingleChildScrollView(
                child: MarkdownBody(
                  data: widget.updateRelease.description,
                  selectable: true,
                  styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                    p: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.8),
                    ),
                    h1: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    h2: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    h3: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                    listBullet: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
            
            // Download progress indicator
            if (_isDownloading) ...[
              const SizedBox(height: 16),
              Column(
                children: [
                  Text(
                    'Update wird heruntergeladen...',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _downloadProgress > 0 ? _downloadProgress : null,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
      actions: [
        if (!_isDownloading)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    await AppUpdateService.dismissUpdate(widget.updateRelease.version);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Später'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  onPressed: _downloadAndInstall,
                  child: const Text('Installieren'),
                ),
              ),
            ],
          ),
        if (_isDownloading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Bitte warten...'),
            ),
          ),
      ],
    );
  }

  Future<void> _downloadAndInstall() async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    try {
      // Simulate progress updates (you can implement real progress tracking with Dio)
      for (int i = 0; i <= 100; i += 10) {
        if (mounted) {
          setState(() {
            _downloadProgress = i / 100.0;
          });
          await Future.delayed(const Duration(milliseconds: 100));
        }
      }

      final success = await AppUpdateService.downloadAndInstallUpdate(widget.updateRelease);
      
      if (mounted) {
        if (success) {
          // Show success message and close dialog
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Update heruntergeladen! Installation wird gestartet...'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        } else {
          // Show error message
          setState(() {
            _isDownloading = false;
            _downloadProgress = 0.0;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fehler beim Herunterladen des Updates'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isDownloading = false;
          _downloadProgress = 0.0;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}