import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/update_service.dart';
import '../widgets/app_update_dialog.dart';

class AppUpdateTestPage extends StatefulWidget {
  const AppUpdateTestPage({super.key});

  @override
  State<AppUpdateTestPage> createState() => _AppUpdateTestPageState();
}

class _AppUpdateTestPageState extends State<AppUpdateTestPage> {
  String _status = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appUpdateTest),
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
                      AppLocalizations.of(context)!.updateSystemTest,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.statusLabel(_status.isNotEmpty ? _status : AppLocalizations.of(context)!.readyToTest),
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
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        const SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.checking),
                      ],
                    )
                  : Text(AppLocalizations.of(context)!.checkForUpdates),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _isLoading ? null : _showUpdateDialog,
              child: Text(AppLocalizations.of(context)!.forceShowUpdateDialog),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.howItWorks,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.updateStep1),
                    Text(AppLocalizations.of(context)!.updateStep2),
                    Text(AppLocalizations.of(context)!.updateStep3),
                    Text(AppLocalizations.of(context)!.updateStep4),
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
      _status = AppLocalizations.of(context)!.checkingForUpdates;
    });

    try {
      final updateRelease = await UpdateService.checkForUpdates();
      
      setState(() {
        _isLoading = false;
        if (updateRelease != null) {
          _status = AppLocalizations.of(context)!.updateAvailableVersion(updateRelease.latestVersion);
        } else {
          _status = AppLocalizations.of(context)!.noUpdatesAvailable;
        }
      });

      if (updateRelease != null && mounted) {
        await AppUpdateDialog.showIfAvailable(context);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _status = AppLocalizations.of(context)!.errorCheckingUpdates(e.toString());
      });
    }
  }

  Future<void> _showUpdateDialog() async {
    setState(() {
      _isLoading = true;
      _status = AppLocalizations.of(context)!.showingUpdateDialog;
    });

    try {
      await AppUpdateDialog.showIfAvailable(context);
      setState(() {
        _isLoading = false;
        _status = AppLocalizations.of(context)!.updateDialogShown;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _status = AppLocalizations.of(context)!.errorShowingDialog(e.toString());
      });
    }
  }

}