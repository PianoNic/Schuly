import 'package:flutter/material.dart';
import '../services/push_notification_service.dart';
import '../services/storage_service.dart';

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Benachrichtigungen konfigurieren',
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
                            'Benachrichtigungstypen',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Wählen Sie aus, für welche Bereiche Sie Benachrichtigungen erhalten möchten.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Agenda Notifications
                          _buildNotificationTile(
                            icon: Icons.schedule_outlined,
                            title: 'Stundenplan',
                            subtitle: 'Benachrichtigungen vor Unterrichtsstunden',
                            value: _agendaNotificationsEnabled,
                            onChanged: (value) {
                              setState(() {
                                _agendaNotificationsEnabled = value;
                              });
                              _saveNotificationSetting('agenda', value);
                            },
                          ),

                          const Divider(),

                          // Grade Notifications
                          _buildNotificationTile(
                            icon: Icons.grade_outlined,
                            title: 'Noten',
                            subtitle: 'Benachrichtigungen bei neuen Noten',
                            value: _gradeNotificationsEnabled,
                            onChanged: (value) {
                              setState(() {
                                _gradeNotificationsEnabled = value;
                              });
                              _saveNotificationSetting('grades', value);
                            },
                          ),

                          const Divider(),

                          // Absence Notifications
                          _buildNotificationTile(
                            icon: Icons.event_busy_outlined,
                            title: 'Abwesenheiten',
                            subtitle: 'Benachrichtigungen bei Abwesenheitsänderungen',
                            value: _absenceNotificationsEnabled,
                            onChanged: (value) {
                              setState(() {
                                _absenceNotificationsEnabled = value;
                              });
                              _saveNotificationSetting('absences', value);
                            },
                          ),

                          const Divider(),

                          // General Notifications
                          _buildNotificationTile(
                            icon: Icons.notifications_outlined,
                            title: 'Allgemeine Mitteilungen',
                            subtitle: 'Wichtige Schulinformationen und Updates',
                            value: _generalNotificationsEnabled,
                            onChanged: (value) {
                              setState(() {
                                _generalNotificationsEnabled = value;
                              });
                              _saveNotificationSetting('general', value);
                            },
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
                              'Benachrichtigungszeit',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Wie viele Minuten vor Unterrichtsbeginn möchten Sie benachrichtigt werden?',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
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
                                  label: Text('$minutes Min'),
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
                                color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
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
                                      'Aktuelle Einstellung: $_advanceMinutes Minuten vor Unterrichtsbeginn',
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
                              'Test',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            
                            ListTile(
                              leading: const Icon(Icons.send_outlined),
                              title: const Text('Test-Benachrichtigung senden'),
                              subtitle: const Text('Prüfen Sie, ob Benachrichtigungen funktionieren'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () async {
                                try {
                                  await PushNotificationService.showTestNotification();
                                } catch (e) {
                                  // Silently handle errors
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
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }
}