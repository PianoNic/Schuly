import 'package:flutter/material.dart';
import '../services/app_update_service.dart';
import '../widgets/app_update_dialog.dart';

class AppUpdateTestPage extends StatefulWidget {
  const AppUpdateTestPage({super.key});

  @override
  State<AppUpdateTestPage> createState() => _AppUpdateTestPageState();
}

class _AppUpdateTestPageState extends State<AppUpdateTestPage> {
  String _status = 'Ready to test';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Update Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update System Test',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Status: $_status',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _checkForUpdates,
              child: _isLoading
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text('Checking...'),
                      ],
                    )
                  : const Text('Check for Updates'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _isLoading ? null : _showUpdateDialog,
              child: const Text('Force Show Update Dialog'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _isLoading ? null : _clearDismissed,
              child: const Text('Clear Dismissed Updates'),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How it works:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text('1. Checks GitHub releases for newer versions'),
                    const Text('2. Downloads APK from GitHub release assets'),
                    const Text('3. Opens Android installer automatically'),
                    const Text('4. Remembers dismissed updates until app restart'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkForUpdates() async {
    setState(() {
      _isLoading = true;
      _status = 'Checking for updates...';
    });

    try {
      final updateRelease = await AppUpdateService.checkForUpdates();
      
      setState(() {
        _isLoading = false;
        if (updateRelease != null) {
          _status = 'Update available: v${updateRelease.version}';
        } else {
          _status = 'No updates available or update dismissed';
        }
      });

      if (updateRelease != null && mounted) {
        await AppUpdateDialog.showIfAvailable(context);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _status = 'Error checking for updates: $e';
      });
    }
  }

  Future<void> _showUpdateDialog() async {
    setState(() {
      _isLoading = true;
      _status = 'Showing update dialog...';
    });

    try {
      await AppUpdateDialog.showIfAvailable(context);
      setState(() {
        _isLoading = false;
        _status = 'Update dialog shown';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _status = 'Error showing dialog: $e';
      });
    }
  }

  Future<void> _clearDismissed() async {
    setState(() {
      _isLoading = true;
      _status = 'Clearing dismissed updates...';
    });

    try {
      await AppUpdateService.clearDismissedVersion();
      setState(() {
        _isLoading = false;
        _status = 'Dismissed updates cleared';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _status = 'Error clearing dismissed: $e';
      });
    }
  }
}