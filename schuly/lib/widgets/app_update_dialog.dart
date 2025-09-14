import 'package:flutter/material.dart';
import '../services/update_service.dart';

class AppUpdateDialog extends StatefulWidget {
  final UpdateInfo updateInfo;

  const AppUpdateDialog({
    super.key,
    required this.updateInfo,
  });

  static Future<void> showIfAvailable(BuildContext context) async {
    final updateInfo = await UpdateService.checkForUpdates();
    if (updateInfo != null && context.mounted) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AppUpdateDialog(updateInfo: updateInfo),
      );
    }
  }

  @override
  State<AppUpdateDialog> createState() => _AppUpdateDialogState();
}

class _AppUpdateDialogState extends State<AppUpdateDialog> {
  bool _isDownloading = false;
  bool _isInstalling = false;
  double _downloadProgress = 0.0;
  String? _downloadedFilePath;
  String _buttonText = 'Installieren';

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
                const Text('Update verfügbar!'),
                Text(
                  'Version ${widget.updateInfo.latestVersion}',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current: ${widget.updateInfo.currentVersion}'),
            Text(
              'Latest: ${widget.updateInfo.latestVersion}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (widget.updateInfo.releaseNotes.isNotEmpty) ...[
              Text(
                'What\'s new:',
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Container(
                height: 100,
                width: double.maxFinite,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    widget.updateInfo.releaseNotes,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (_isDownloading) ...[
              const Text('Update wird heruntergeladen...'),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: _downloadProgress,
                backgroundColor: theme.colorScheme.surfaceVariant,
              ),
              const SizedBox(height: 4),
              Text('${(_downloadProgress * 100).toStringAsFixed(1)}%'),
            ],
            if (_isInstalling) ...[
              const Text('Update wird installiert...'),
              const SizedBox(height: 8),
              const LinearProgressIndicator(),
            ],
          ],
        ),
      ),
      actions: [
        if (!_isDownloading && !_isInstalling)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Später'),
          ),
        ElevatedButton(
          onPressed: _isDownloading || _isInstalling
              ? null
              : _downloadedFilePath != null
                  ? _installUpdate
                  : _downloadUpdate,
          child: Text(_buttonText),
        ),
      ],
    );
  }

  Future<void> _downloadUpdate() async {
    setState(() {
      _isDownloading = true;
      _buttonText = 'Wird heruntergeladen...';
    });

    try {
      final filePath = await UpdateService.downloadApk(
        widget.updateInfo.downloadUrl,
        widget.updateInfo.latestVersion,
        (progress) {
          setState(() {
            _downloadProgress = progress;
          });
        },
      );

      if (filePath != null) {
        setState(() {
          _downloadedFilePath = filePath;
          _isDownloading = false;
          _buttonText = 'Installieren';
        });
      } else {
        setState(() {
          _isDownloading = false;
          _buttonText = 'Installieren';
        });
        _showErrorDialog('Fehler beim Herunterladen des Updates');
      }
    } catch (e) {
      setState(() {
        _isDownloading = false;
        _buttonText = 'Installieren';
      });
      _showErrorDialog('Download Fehler: $e');
    }
  }

  Future<void> _installUpdate() async {
    setState(() {
      _isInstalling = true;
      _buttonText = 'Wird installiert...';
    });

    try {
      // Check install permission first
      final hasPermission = await UpdateService.checkInstallPermission();
      if (!hasPermission) {
        setState(() {
          _isInstalling = false;
          _buttonText = 'Installieren';
        });
        _showErrorDialog('Installation nicht erlaubt');
        return;
      }

      // Install the APK
      final success = await UpdateService.installApk(_downloadedFilePath!);

      if (success) {
        // Installation started successfully
        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Update Installation gestartet'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        setState(() {
          _isInstalling = false;
          _buttonText = 'Installieren';
        });
        _showErrorDialog('Fehler bei der Installation');
      }
    } catch (e) {
      setState(() {
        _isInstalling = false;
        _buttonText = 'Installieren';
      });
      _showErrorDialog('Installation Fehler: $e');
    }
  }

  void _showErrorDialog(String message) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Fehler'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}