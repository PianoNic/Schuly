import 'package:flutter/material.dart';
import '../services/push_notification_service.dart';
import '../services/storage_service.dart';
import '../l10n/app_localizations.dart';

class NotificationConfigPage extends StatefulWidget {
  const NotificationConfigPage({super.key});

  @override
  State<NotificationConfigPage> createState() => _NotificationConfigPageState();
}

class _NotificationConfigPageState extends State<NotificationConfigPage> {
  bool _agendaNotificationsEnabled = true;
  bool _gradeNotificationsEnabled = false;
  bool _absenceNotificationsEnabled = false;
  bool _generalNotificationsEnabled = false;
  
  int _advanceMinutes = 2;
  final List<int> _advanceTimeOptions = [2, 5, 10, 20, 30, 50];
  
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final agendaEnabled = await StorageService.getNotificationEnabled('agenda') ?? true;
    final gradeEnabled = await StorageService.getNotificationEnabled('grades') ?? false;
    final absenceEnabled = await StorageService.getNotificationEnabled('absences') ?? false;
    final generalEnabled = await StorageService.getNotificationEnabled('general') ?? false;
    final advanceMinutes = await StorageService.getNotificationAdvanceMinutes() ?? 2;
    
    setState(() {
      _agendaNotificationsEnabled = agendaEnabled;
      _gradeNotificationsEnabled = gradeEnabled;
      _absenceNotificationsEnabled = absenceEnabled;
      _generalNotificationsEnabled = generalEnabled;
      _advanceMinutes = advanceMinutes;
      _isLoading = false;
    });
  }

  Future<void> _saveNotificationSetting(String type, bool enabled) async {
    await StorageService.setNotificationEnabled(type, enabled);
    
    // If this is agenda notifications and it's being disabled, cancel all notifications
    if (type == 'agenda' && !enabled) {
      await PushNotificationService.cancelAllNotifications();
    }
  }

  Future<void> _saveAdvanceTime(int minutes) async {
    await StorageService.setNotificationAdvanceMinutes(minutes);
    setState(() {
      _advanceMinutes = minutes;
    });
  }

  Future<void> _scheduleTestNotification() async {
    // Schedule a test notification using the dedicated test method
    await PushNotificationService.scheduleTestNotification();
  }



  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.configureNotifications,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Notification Types Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizations.notificationTypes,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            localizations.chooseTypesAndTiming,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Agenda Notifications
                          _buildNotificationTile(
                            icon: Icons.schedule_outlined,
                            title: localizations.timetable,
                            subtitle: localizations.agendaNotificationSubtitle,
                            value: _agendaNotificationsEnabled,
                            onChanged: (value) {
                              setState(() {
                                _agendaNotificationsEnabled = value;
                              });
                              _saveNotificationSetting('agenda', value);
                            },
                          ),

                          const Divider(),

                          // Grade Notifications (Disabled - coming soon)
                          _buildNotificationTile(
                            icon: Icons.grade_outlined,
                            title: localizations.grades,
                            subtitle: localizations.gradeNotificationSubtitle,
                            value: _gradeNotificationsEnabled,
                            onChanged: null, // Disabled
                          ),

                          const Divider(),

                          // Absence Notifications (Disabled - coming soon)
                          _buildNotificationTile(
                            icon: Icons.event_busy_outlined,
                            title: localizations.absences,
                            subtitle: localizations.absenceNotificationSubtitle,
                            value: _absenceNotificationsEnabled,
                            onChanged: null, // Disabled
                          ),

                          const Divider(),

                          // General Notifications (Disabled - coming soon)
                          _buildNotificationTile(
                            icon: Icons.notifications_outlined,
                            title: localizations.generalNotifications,
                            subtitle: localizations.generalNotificationSubtitle,
                            value: _generalNotificationsEnabled,
                            onChanged: null, // Disabled
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Timing Configuration Card
                  if (_agendaNotificationsEnabled)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localizations.notificationTime,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              localizations.notificationAdvanceQuestion,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Advance Time Selection
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: _advanceTimeOptions.map((minutes) {
                                final isSelected = _advanceMinutes == minutes;
                                return FilterChip(
                                  label: Text(localizations.minutesBeforeClass(minutes)),
                                  selected: isSelected,
                                  onSelected: (selected) {
                                    if (selected) {
                                      _saveAdvanceTime(minutes);
                                    }
                                  },
                                  selectedColor: Theme.of(context).colorScheme.primaryContainer,
                                  checkmarkColor: Theme.of(context).colorScheme.onPrimaryContainer,
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 16),

                            // Current Selection Display
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time_outlined,
                                    size: 20,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      localizations.currentAdvanceSetting(_advanceMinutes),
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Test Notification Card
                  if (_agendaNotificationsEnabled || _gradeNotificationsEnabled || 
                      _absenceNotificationsEnabled || _generalNotificationsEnabled)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localizations.test,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            
                            // Instant test notification
                            ListTile(
                              leading: const Icon(Icons.send_outlined),
                              title: Text(localizations.sendTestNotification),
                              subtitle: Text(localizations.checkNotificationsWork),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () async {
                                try {
                                  await PushNotificationService.showTestNotification();
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(localizations.testNotificationSent),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  // Silently handle errors
                                }
                              },
                              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                            ),

                            const Divider(),

                            // Scheduled test notification (5 seconds)
                            ListTile(
                              leading: const Icon(Icons.schedule_outlined),
                              title: Text(localizations.scheduleTestNotification),
                              subtitle: Text(localizations.testScheduledNotificationDesc),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () async {
                                try {
                                  await _scheduleTestNotification();
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(localizations.notificationScheduledIn15Seconds),
                                        backgroundColor: Colors.blue,
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  if (mounted) {
                                    String errorMessage = localizations.errorSchedulingNotification;
                                    if (e.toString().contains('exact_alarms_not_permitted')) {
                                      errorMessage = localizations.exactAlarmPermissionRequired;
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(errorMessage),
                                        backgroundColor: Colors.red,
                                        action: e.toString().contains('exact_alarms_not_permitted')
                                            ? SnackBarAction(
                                                label: localizations.openSettings,
                                                textColor: Colors.white,
                                                onPressed: () async {
                                                  await PushNotificationService.requestExactAlarmPermission();
                                                },
                                              )
                                            : null,
                                      ),
                                    );
                                  }
                                }
                              },
                              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    final isEnabled = onChanged != null;
    return ListTile(
      leading: Icon(
        icon,
        color: isEnabled ? null : Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isEnabled ? null : Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
        ),
      ),
      subtitle: Text(
        isEnabled ? subtitle : '$subtitle (Coming soon)',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: isEnabled ? null : Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }
}