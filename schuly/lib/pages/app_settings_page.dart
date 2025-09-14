import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../widgets/theme_settings.dart';
import '../providers/theme_provider.dart';
import '../providers/api_store.dart';
import '../services/storage_service.dart';
import '../services/push_notification_service.dart';
import '../main.dart';
import 'notification_config_page.dart';
import 'release_notes_page.dart';
import '../services/app_update_service.dart';
import '../widgets/app_update_dialog.dart';

class AppSettingsPage extends StatefulWidget {
  final ThemeProvider themeProvider;

  const AppSettingsPage({super.key, required this.themeProvider});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  bool _pushNotificationsEnabled = false;
  bool _isLoading = true;
  bool _isCheckingUpdates = false;
  String _appVersion = 'DEV';
  String _appBuildNumber = '0';

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadApiInfo();
    _loadAppVersion();
  }

  Future<void> _loadApiInfo() async {
    final apiStore = Provider.of<ApiStore>(context, listen: false);
    try {
      await apiStore.fetchAppInfo();
    } catch (e) {
      // Ignore errors when loading API info on settings page
    }
  }

  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _appVersion = packageInfo.version;
        _appBuildNumber = packageInfo.buildNumber;
      });
    } catch (e) {
      // Keep default values if package info fails to load
    }
  }

  Future<void> _loadSettings() async {
    final pushNotificationsEnabled = await StorageService.getPushNotificationsEnabled();
    
    setState(() {
      _pushNotificationsEnabled = pushNotificationsEnabled;
      _isLoading = false;
    });
  }

  Future<void> _togglePushNotifications(bool value) async {
    setState(() {
      _pushNotificationsEnabled = value;
    });
    
    await StorageService.setPushNotificationsEnabled(value);
    
    // If disabling push notifications, cancel all notifications
    if (!value) {
      await PushNotificationService.cancelAllNotifications();
    }
  }

  Future<void> _checkForUpdates() async {
    setState(() {
      _isCheckingUpdates = true;
    });

    try {
      final updateRelease = await AppUpdateService.checkForUpdates();
      
      if (mounted) {
        setState(() {
          _isCheckingUpdates = false;
        });

        if (updateRelease != null) {
          // Show update dialog
          await AppUpdateDialog.showIfAvailable(context);
        } else {
          // Show "no updates" message
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sie verwenden bereits die neueste Version'),
                backgroundColor: Colors.green,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isCheckingUpdates = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Suchen nach Updates: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
                            icon: Icons.notifications_off_outlined,
                            title: 'Push-Benachrichtigungen',
                            subtitle: 'Feature wird noch entwickelt',
                            trailing: Switch(
                              value: false,
                              onChanged: null,
                            ),
                            isEnabled: false,
                          ),

                    const Divider(),

                    // PushAssist Configuration
                    _isLoading 
                        ? const SizedBox.shrink()
                        : _buildSettingsTile(
                            context,
                            icon: Icons.settings_outlined,
                            title: 'Benachrichtigungen konfigurieren',
                            subtitle: 'Wählen Sie Typen und Timing für Benachrichtigungen',
                            trailing: const Icon(Icons.chevron_right),
                            onTap: _pushNotificationsEnabled ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NotificationConfigPage(),
                                ),
                              ).then((_) {
                                // Reload settings when returning from config page
                                _loadSettings();
                              });
                            } : null,
                            isEnabled: _pushNotificationsEnabled,
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

                    // Release Notes
                    _buildSettingsTile(
                      context,
                      icon: Icons.article_outlined,
                      title: 'Was ist neu',
                      subtitle: 'Changelog und neue Features',
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReleaseNotesPage(),
                          ),
                        );
                      },
                    ),

                    // Check for Updates
                    _buildSettingsTile(
                      context,
                      icon: Icons.system_update,
                      title: 'Nach Updates suchen',
                      subtitle: 'Auf neue Versionen prüfen',
                      trailing: _isCheckingUpdates 
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.chevron_right),
                      onTap: _isCheckingUpdates ? null : _checkForUpdates,
                    ),

                    const Divider(),

                    // About App
                    _buildSettingsTile(
                      context,
                      icon: Icons.info_outlined,
                      title: 'Über die App',
                      subtitle: 'Version $_appVersion+$_appBuildNumber',
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'Schuly',
                          applicationVersion: '$_appVersion+$_appBuildNumber',
                          applicationLegalese: 'Schuly © 2025 PianoNic',
                          children: [
                            const SizedBox(height: 16),
                            const Text(
                              'Eine custom App für Schüler zur Verwaltung von Schulnetz-Daten. '
                              'Verwalten Sie Ihren Stundenplan, Noten und wichtige Termine an einem Ort.',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 12),
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
                    Consumer<ApiStore>(
                      builder: (context, apiStore, child) {
                        // Always show the container with debug info
                        final hasAppInfo = apiStore.appInfo != null;
                        final version = hasAppInfo ? (apiStore.appInfo!['version'] ?? 'unbekannt') : 'Lädt...';
                        final environment = hasAppInfo ? (apiStore.appInfo!['environment'] ?? 'unbekannt') : 'Lädt...';
                        final lastError = apiStore.lastApiError ?? 'Kein Fehler';
                        
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: hasAppInfo 
                                ? Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: hasAppInfo 
                                  ? Theme.of(context).colorScheme.outline.withOpacity(0.2)
                                  : Colors.orange.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hasAppInfo ? 'Aktuelle API Info' : 'API Info Status',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('Version: $version'),
                              Text('Umgebung: $environment'),
                              if (!hasAppInfo) ...[
                                const SizedBox(height: 4),
                                Text(
                                  'Fehler: $lastError',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.orange[700],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
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
                  child: const Text('Speichern'),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
