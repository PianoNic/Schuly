import 'package:flutter/material.dart';
import '../services/update_service.dart';

class UpdateDialog extends StatefulWidget {
  final UpdateInfo updateInfo;

  const UpdateDialog({super.key, required this.updateInfo});

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  bool _isDownloading = false;
  bool _isInstalling = false;
  double _downloadProgress = 0.0;
  String? _downloadedFilePath;
  String _buttonText = 'Update';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Available'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'A new version is available!',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text('Current: ${widget.updateInfo.currentVersion}'),
          Text(
            'Latest: ${widget.updateInfo.latestVersion}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (widget.updateInfo.releaseNotes.isNotEmpty) ...[
            Text(
              'What\'s new:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Container(
              height: 100,
              width: double.maxFinite,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                child: Text(
                  widget.updateInfo.releaseNotes,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (_isDownloading) ...[
            const Text('Downloading update...'),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: _downloadProgress,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            ),
            const SizedBox(height: 4),
            Text('${(_downloadProgress * 100).toStringAsFixed(1)}%'),
          ],
          if (_isInstalling) ...[
            const Text('Installing update...'),
            const SizedBox(height: 8),
            const LinearProgressIndicator(),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isDownloading || _isInstalling
              ? null
              : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
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
      _buttonText = 'Downloading...';
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
          _buttonText = 'Install';
        });
      } else {
        setState(() {
          _isDownloading = false;
          _buttonText = 'Update';
        });
        _showErrorDialog('Failed to download update');
      }
    } catch (e) {
      setState(() {
        _isDownloading = false;
        _buttonText = 'Update';
      });
      _showErrorDialog('Download error: $e');
    }
  }

  Future<void> _installUpdate() async {
    setState(() {
      _isInstalling = true;
      _buttonText = 'Installing...';
    });

    try {
      // Check install permission first
      final hasPermission = await UpdateService.checkInstallPermission();
      if (!hasPermission) {
        setState(() {
          _isInstalling = false;
          _buttonText = 'Install';
        });
        _showErrorDialog('Install permission denied');
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
              content: Text('Update installation started'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        setState(() {
          _isInstalling = false;
          _buttonText = 'Install';
        });
        _showErrorDialog('Failed to install update');
      }
    } catch (e) {
      setState(() {
        _isInstalling = false;
        _buttonText = 'Install';
      });
      _showErrorDialog('Installation error: $e');
    }
  }

  void _showErrorDialog(String message) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
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