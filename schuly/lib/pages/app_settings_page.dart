import 'package:flutter/material.dart';
import '../widgets/theme_settings.dart';
import '../providers/theme_provider.dart';
import '../services/storage_service.dart';
import '../main.dart';

class AppSettingsPage extends StatefulWidget {
  final ThemeProvider themeProvider;

  const AppSettingsPage({super.key, required this.themeProvider});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  bool _pushNotificationsEnabled = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPushNotificationSetting();
  }

  Future<void> _loadPushNotificationSetting() async {
    final enabled = await StorageService.getPushNotificationsEnabled();
    setState(() {
      _pushNotificationsEnabled = enabled;
      _isLoading = false;
    });
  }

  Future<void> _togglePushNotifications(bool value) async {
    setState(() {
      _pushNotificationsEnabled = value;
    });
    
    await StorageService.setPushNotificationsEnabled(value);
    
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value 
            ? 'Push-Benachrichtigungen aktiviert' 
            : 'Push-Benachrichtigungen deaktiviert'
        ),
        backgroundColor: value ? Colors.green : Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Einstellungen',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Theme Settings Card
            ThemeSettings(themeProvider: widget.themeProvider),

            const SizedBox(height: 16),

            // Additional App Settings Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Einstellungen',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),

                    // Notifications Toggle
                    _isLoading 
                        ? const Center(child: CircularProgressIndicator())
                        : _buildSettingsTile(
                            context,
                            icon: _pushNotificationsEnabled 
                                ? Icons.notifications_outlined
                                : Icons.notifications_off_outlined,
                            title: 'Push-Benachrichtigungen',
                            subtitle: _pushNotificationsEnabled 
                                ? 'Benachrichtigungen sind aktiviert'
                                : 'Benachrichtigungen sind deaktiviert',
                            trailing: Switch(
                              value: _pushNotificationsEnabled,
                              onChanged: _togglePushNotifications,
                            ),
                            isEnabled: true,
                          ),

                    const Divider(),

                    // Language Setting
                    _buildSettingsTile(
                      context,
                      icon: Icons.language_outlined,
                      title: 'Sprache',
                      subtitle: 'Deutsch',
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Spracheinstellungen - Coming Soon!'),
                          ),
                        );
                      },
                    ),

                    const Divider(),

                    // About App
                    _buildSettingsTile(
                      context,
                      icon: Icons.info_outlined,
                      title: 'Über die App',
                      subtitle: 'Version 1.0.0',
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'Schuly',
                          applicationVersion: '1.0.0',
                          applicationLegalese: 'Schuly © 2025 PianoNic',
                          children: [
                            const SizedBox(height: 16),
                            const Text(
                              'Eine professionelle App für Schüler zur Verwaltung von Schulnetz-Daten. '
                              'Verwalten Sie Ihren Stundenplan, Noten und wichtige Termine an einem Ort.',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Entwickelt mit Flutter für eine moderne und benutzerfreundliche Erfahrung.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // API Endpoint Settings Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'API Endpoint',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    _ApiUrlField(),
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

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
    bool isEnabled = true,
  }) {
    final theme = Theme.of(context);
    final disabledColor = theme.colorScheme.onSurface.withOpacity(0.38);
    
    return ListTile(
      leading: Icon(
        icon, 
        color: isEnabled ? null : disabledColor,
      ),
      title: Text(
        title,
        style: isEnabled 
          ? null 
          : TextStyle(color: disabledColor),
      ),
      subtitle: Text(
        subtitle, 
        style: theme.textTheme.bodySmall?.copyWith(
          color: isEnabled 
            ? theme.textTheme.bodySmall?.color 
            : disabledColor,
        ),
      ),
      trailing: trailing,
      onTap: isEnabled ? onTap : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      enabled: isEnabled,
    );
  }
}

class _ApiUrlField extends StatefulWidget {
  @override
  State<_ApiUrlField> createState() => _ApiUrlFieldState();
}

class _ApiUrlFieldState extends State<_ApiUrlField> {
  late TextEditingController _controller;
  String? _currentUrl;

  @override
  void initState() {
    super.initState();
    _currentUrl = apiBaseUrl;
    _controller = TextEditingController(text: _currentUrl);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'API Base URL',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _currentUrl = value.trim();
            });
          },
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Builder(
              builder: (context) {
                final appColors = Theme.of(context).extension<AppColors>();
                final seedColor = appColors?.seedColor ?? Theme.of(context).colorScheme.primary;
                
                return ElevatedButton(
                  onPressed: () async {
                    if (_currentUrl != null && _currentUrl!.isNotEmpty) {
                      await setApiBaseUrl(_currentUrl!);
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('API URL geändert: $_currentUrl'), backgroundColor: seedColor),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: seedColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('API URL speichern'),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
