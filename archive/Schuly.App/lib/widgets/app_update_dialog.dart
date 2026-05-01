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
    final localizations = AppLocalizations.of(context)!;

    return Dialog(
      child: Container(
        width: 400,
        constraints: const BoxConstraints(maxHeight: 600),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.system_update,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  localizations.updateAvailable,
                  style: theme.textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Content section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    // Version comparison card
                    Card(
                      elevation: 0,
                      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Current',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.updateInfo.currentVersion.startsWith('v')
                                      ? widget.updateInfo.currentVersion
                                      : 'v${widget.updateInfo.currentVersion}',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: theme.colorScheme.primary,
                              size: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  'New',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.updateInfo.latestVersion.startsWith('v')
                                      ? widget.updateInfo.latestVersion
                                      : 'v${widget.updateInfo.latestVersion}',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  // Release notes section (scrollable)
                  if (widget.updateInfo.releaseNotes.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: MarkdownBody(
                          data: widget.updateInfo.releaseNotes,
                          selectable: true,
                          styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                            p: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                            ),
                            h1: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            h2: theme.textTheme.titleMedium?.copyWith(
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
                            blockquote: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                              fontStyle: FontStyle.italic,
                            ),
                            code: theme.textTheme.bodySmall?.copyWith(
                              fontFamily: 'monospace',
                              backgroundColor: theme.colorScheme.surfaceContainerHighest,
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Progress indicators at bottom (always visible)
                  if (_isDownloading || _isInstalling) ...[
                    const SizedBox(height: 16),
                    if (_isDownloading) ...[
                      Text(localizations.downloadingUpdate),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: _downloadProgress,
                        backgroundColor: theme.colorScheme.surfaceContainerHighest,
                      ),
                      const SizedBox(height: 4),
                      Text('${(_downloadProgress * 100).toStringAsFixed(1)}%'),
                    ],
                    if (_isInstalling) ...[
                      Text(localizations.installingUpdate),
                      const SizedBox(height: 8),
                      const LinearProgressIndicator(),
                    ],
                  ],
                ],
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
                    child: Text(_downloadedFilePath != null ? localizations.close : localizations.later),
                  ),
                const SizedBox(width: 8),
                _downloadedFilePath != null
                    ? FilledButton.icon(
                        onPressed: _isInstalling ? null : _installUpdate,
                        icon: const Icon(Icons.install_mobile, size: 20),
                        label: Text(_buttonText ?? localizations.install),
                      )
                    : FilledButton(
                        onPressed: _isDownloading ? null : _downloadUpdate,
                        child: Text(_buttonText ?? localizations.download),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadUpdate() async {
    final localizations = AppLocalizations.of(context)!;
    setState(() {
      _isDownloading = true;
      _buttonText = localizations.downloading;
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

      if (!mounted) return;

      if (filePath != null) {
        setState(() {
          _downloadedFilePath = filePath;
          _isDownloading = false;
          _buttonText = localizations.install;
        });
      } else {
        setState(() {
          _isDownloading = false;
          _buttonText = localizations.install;
        });
        _showErrorDialog(localizations.downloadError);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isDownloading = false;
        _buttonText = localizations.install;
      });
      _showErrorDialog(localizations.downloadErrorDetails(e.toString()));
    }
  }

  Future<void> _installUpdate() async {
    final localizations = AppLocalizations.of(context)!;
    setState(() {
      _isInstalling = true;
      _buttonText = localizations.installing;
    });

    try {
      // Check and request install permission if needed
      final hasPermission = await UpdateService.checkInstallPermission();
      if (!mounted) return;

      if (!hasPermission) {
        // Permission denied but keep dialog open for retry
        setState(() {
          _isInstalling = false;
          _buttonText = localizations.install;
        });
        // Don't show error dialog, just reset state so user can try again
        return;
      }

      // Proceed with installation
      final success = await UpdateService.installApk(_downloadedFilePath!);
      if (!mounted) return;

      if (success) {
        // Installation started successfully but keep dialog open
        // in case user cancels the system install dialog
        setState(() {
          _isInstalling = false;
          _buttonText = localizations.install;
        });
      } else {
        setState(() {
          _isInstalling = false;
          _buttonText = localizations.install;
        });
        _showErrorDialog(localizations.installationError);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isInstalling = false;
        _buttonText = localizations.install;
      });
      _showErrorDialog(localizations.installationErrorDetails(e.toString()));
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