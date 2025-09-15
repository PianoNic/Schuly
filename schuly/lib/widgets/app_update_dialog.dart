import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../l10n/app_localizations.dart';
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
  String? _buttonText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Container(
        width: 400,
        constraints: const BoxConstraints(maxHeight: 600),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title section
            Row(
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
                      Text(
                        AppLocalizations.of(context)!.updateAvailable,
                        style: theme.textTheme.headlineSmall,
                      ),
                      Text(
                        'Version ${widget.updateInfo.latestVersion}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Content section
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(AppLocalizations.of(context)!.currentVersion(widget.updateInfo.currentVersion)),
                  Text(
                    AppLocalizations.of(context)!.latestVersion(widget.updateInfo.latestVersion),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  if (widget.updateInfo.releaseNotes.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Container(
                      height: 200,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.3)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SingleChildScrollView(
                        child: MarkdownBody(
                          data: widget.updateInfo.releaseNotes,
                          selectable: true,
                          shrinkWrap: true,
                          styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                            p: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                            h1: theme.textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                            h2: theme.textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                            h3: theme.textTheme.bodySmall?.copyWith(fontSize: 11, fontWeight: FontWeight.bold),
                            listBullet: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                            code: theme.textTheme.bodySmall?.copyWith(fontSize: 11, fontFamily: 'monospace'),
                            blockquote: theme.textTheme.bodySmall?.copyWith(fontSize: 11, fontStyle: FontStyle.italic),
                            em: theme.textTheme.bodySmall?.copyWith(fontSize: 11, fontStyle: FontStyle.italic),
                            strong: theme.textTheme.bodySmall?.copyWith(fontSize: 11, fontWeight: FontWeight.bold),
                            a: theme.textTheme.bodySmall?.copyWith(fontSize: 11, color: theme.colorScheme.primary),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (_isDownloading) ...[
                    Text(AppLocalizations.of(context)!.downloadingUpdate),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: _downloadProgress,
                      backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    ),
                    const SizedBox(height: 4),
                    Text('${(_downloadProgress * 100).toStringAsFixed(1)}%'),
                  ],
                  if (_isInstalling) ...[
                    Text(AppLocalizations.of(context)!.installingUpdate),
                    const SizedBox(height: 8),
                    const LinearProgressIndicator(),
                  ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Actions section
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
        if (!_isDownloading && !_isInstalling)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.later),
          ),
        OutlinedButton(
          onPressed: _isDownloading || _isInstalling
              ? null
              : _downloadedFilePath != null
                  ? _installUpdate
                  : _downloadUpdate,
          child: Text(_buttonText ?? AppLocalizations.of(context)!.install),
        ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadUpdate() async {
    setState(() {
      _isDownloading = true;
      _buttonText = AppLocalizations.of(context)!.downloading;
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
          _buttonText = AppLocalizations.of(context)!.install;
        });
      } else {
        setState(() {
          _isDownloading = false;
          _buttonText = AppLocalizations.of(context)!.install;
        });
        _showErrorDialog(AppLocalizations.of(context)!.downloadError);
      }
    } catch (e) {
      setState(() {
        _isDownloading = false;
        _buttonText = AppLocalizations.of(context)!.install;
      });
      _showErrorDialog(AppLocalizations.of(context)!.downloadErrorDetails(e.toString()));
    }
  }

  Future<void> _installUpdate() async {
    setState(() {
      _isInstalling = true;
      _buttonText = AppLocalizations.of(context)!.installing;
    });

    try {
      // Check install permission first
      final hasPermission = await UpdateService.checkInstallPermission();
      if (!hasPermission) {
        setState(() {
          _isInstalling = false;
          _buttonText = AppLocalizations.of(context)!.install;
        });
        _showErrorDialog(AppLocalizations.of(context)!.installationNotAllowed);
        return;
      }

      // Install the APK
      final success = await UpdateService.installApk(_downloadedFilePath!);

      if (success) {
        // Installation started successfully
        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.updateInstallationStarted),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        setState(() {
          _isInstalling = false;
          _buttonText = AppLocalizations.of(context)!.install;
        });
        _showErrorDialog(AppLocalizations.of(context)!.installationError);
      }
    } catch (e) {
      setState(() {
        _isInstalling = false;
        _buttonText = AppLocalizations.of(context)!.install;
      });
      _showErrorDialog(AppLocalizations.of(context)!.installationErrorDetails(e.toString()));
    }
  }

  void _showErrorDialog(String message) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.error),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.ok),
            ),
          ],
        ),
      );
    }
  }
}