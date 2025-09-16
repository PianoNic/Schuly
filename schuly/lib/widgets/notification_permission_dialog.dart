import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../l10n/app_localizations.dart';

class NotificationPermissionDialog extends StatefulWidget {
  final bool isStartupCheck;

  const NotificationPermissionDialog({
    super.key,
    this.isStartupCheck = false,
  });

  @override
  State<NotificationPermissionDialog> createState() => _NotificationPermissionDialogState();
}

class _NotificationPermissionDialogState extends State<NotificationPermissionDialog> {
  bool _notificationGranted = false;
  bool _exactAlarmGranted = false;
  bool _batteryOptimizationDisabled = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      final notificationStatus = await Permission.notification.status;
      final exactAlarmStatus = await Permission.scheduleExactAlarm.status;
      final batteryStatus = await Permission.ignoreBatteryOptimizations.status;

      setState(() {
        _notificationGranted = notificationStatus.isGranted;
        _exactAlarmGranted = exactAlarmStatus.isGranted;
        _batteryOptimizationDisabled = batteryStatus.isGranted;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _requestPermission(Permission permission) async {
    final status = await permission.request();
    _checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final allGranted = _notificationGranted && _exactAlarmGranted && _batteryOptimizationDisabled;

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Row(
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      localizations.notificationPermissions,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                localizations.notificationPermissionsDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Permissions list
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Notification permission
                        ListTile(
                          leading: Icon(
                            _notificationGranted ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: _notificationGranted ? Colors.green : Colors.orange,
                          ),
                          title: Text(localizations.notificationPermission),
                          subtitle: Text(localizations.notificationPermissionDesc),
                          trailing: _notificationGranted
                              ? null
                              : TextButton(
                                  onPressed: () => _requestPermission(Permission.notification),
                                  child: Text(localizations.grant),
                                ),
                        ),
                        const Divider(),

                        // Exact alarm permission
                        ListTile(
                          leading: Icon(
                            _exactAlarmGranted ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: _exactAlarmGranted ? Colors.green : Colors.orange,
                          ),
                          title: Text(localizations.exactAlarmPermission),
                          subtitle: Text(localizations.exactAlarmPermissionDesc),
                          trailing: _exactAlarmGranted
                              ? null
                              : TextButton(
                                  onPressed: () => _requestPermission(Permission.scheduleExactAlarm),
                                  child: Text(localizations.grant),
                                ),
                        ),
                        const Divider(),

                        // Battery optimization
                        ListTile(
                          leading: Icon(
                            _batteryOptimizationDisabled ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: _batteryOptimizationDisabled ? Colors.green : Colors.orange,
                          ),
                          title: Text(localizations.batteryOptimization),
                          subtitle: Text(localizations.batteryOptimizationDesc),
                          trailing: _batteryOptimizationDisabled
                              ? null
                              : TextButton(
                                  onPressed: () => _requestPermission(Permission.ignoreBatteryOptimizations),
                                  child: Text(localizations.grant),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!allGranted && widget.isStartupCheck)
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(localizations.remindLater),
                    ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(allGranted ? localizations.done : localizations.continueAnyway),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showNotificationPermissionDialog(BuildContext context, {bool isStartupCheck = false}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => NotificationPermissionDialog(isStartupCheck: isStartupCheck),
  );
}