import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schuly/api/lib/api.dart';
import 'dart:async' show TimeoutException;
import '../widgets/theme_settings.dart';
import '../providers/theme_provider.dart';
import '../providers/api_store.dart';
import '../services/storage_service.dart';
import '../main.dart';
import 'notification_config_page.dart';
import '../l10n/app_localizations.dart';
import '../providers/language_provider.dart';
import '../services/push_notification_service.dart';
import '../widgets/privacy_consent_dialog.dart';
import 'maggus_checker_page.dart';

class AppSettingsPage extends StatefulWidget {
  final ThemeProvider themeProvider;

  const AppSettingsPage({super.key, required this.themeProvider});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  bool _pushNotificationsEnabled = false;
  bool _privacyConsentEnabled = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadApiInfo();
  }

  Future<void> _loadApiInfo() async {
    final apiStore = Provider.of<ApiStore>(context, listen: false);
    try {
      await apiStore.fetchAppInfo();
    } catch (e) {
      // Ignore errors when loading API info on settings page
    }
  }

  Future<void> _loadSettings() async {
    final pushNotificationsEnabled = await StorageService.getPushNotificationsEnabled();
    final privacyConsent = await PrivacyConsentDialog.hasUserConsented();

    setState(() {
      _pushNotificationsEnabled = pushNotificationsEnabled;
      _privacyConsentEnabled = privacyConsent;
      _isLoading = false;
    });
  }


  Future<void> _handleNotificationToggle(bool? value) async {
    if (value == null) return;

    // If enabling notifications, request permissions first
    if (value) {
      final granted = await PushNotificationService.requestPermissions();

      if (granted) {
        // Permission granted - enable notifications
        await StorageService.setPushNotificationsEnabled(true);
        await PushNotificationService.setPushAssistEnabled(true);
        setState(() {
          _pushNotificationsEnabled = true;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.notificationsEnabled),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        // Permission denied - keep toggle off
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.notificationPermissionDenied),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      // Disabling notifications
      await StorageService.setPushNotificationsEnabled(false);
      await PushNotificationService.setPushAssistEnabled(false);
      setState(() {
        _pushNotificationsEnabled = false;
      });
    }
  }

  Future<void> _handlePrivacyConsentToggle(bool? value) async {
    if (value == null) return;

    await PrivacyConsentDialog.setUserConsent(value);
    setState(() {
      _privacyConsentEnabled = value;
    });

    if (mounted) {
      final localizations = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            value
              ? '${localizations.errorTrackingEnabled} ${localizations.errorTrackingRestartRequired}'
              : localizations.errorTrackingDisabled,
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.appSettings,
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

            // Additional App Settings Card
            Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.appSettings,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),

                    // Notifications Toggle
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _buildSettingsTile(
                            context,
                            icon: _pushNotificationsEnabled
                                ? Icons.notifications_active_outlined
                                : Icons.notifications_off_outlined,
                            title: localizations.pushNotifications,
                            subtitle: _pushNotificationsEnabled
                                ? localizations.getNotified
                                : localizations.enableNotifications,
                            trailing: Switch(
                              value: _pushNotificationsEnabled,
                              onChanged: _handleNotificationToggle,
                            ),
                            isEnabled: true,
                          ),

                    const Divider(),

                    // PushAssist Configuration
                    _isLoading
                        ? const SizedBox.shrink()
                        : _buildSettingsTile(
                            context,
                            icon: Icons.settings_outlined,
                            title: localizations.configureNotifications,
                            subtitle: localizations.chooseTypesAndTiming,
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

                    // Privacy & Data Collection Toggle (only show if Sentry is configured)
                    if (const String.fromEnvironment('SENTRY_DSN', defaultValue: '').isNotEmpty) ...[
                      const Divider(),
                      _isLoading
                          ? const SizedBox.shrink()
                          : _buildSettingsTile(
                              context,
                              icon: _privacyConsentEnabled
                                  ? Icons.shield
                                  : Icons.shield_outlined,
                              title: localizations.errorTracking,
                              subtitle: _privacyConsentEnabled
                                  ? localizations.errorTrackingEnabledDesc
                                  : localizations.errorTrackingDisabledDesc,
                              trailing: Switch(
                                value: _privacyConsentEnabled,
                                onChanged: _handlePrivacyConsentToggle,
                              ),
                              isEnabled: true,
                            ),
                    ],

                    const Divider(),


                    // Language Setting
                    Consumer<LanguageProvider>(
                      builder: (context, languageProvider, _) {
                        final locale = languageProvider.locale;
                        String languageName;
                        switch (locale.languageCode) {
                          case 'en':
                            languageName = localizations.english;
                            break;
                          case 'de':
                            languageName = localizations.german;
                            break;
                          case 'nl':
                            languageName = 'Nederlands';
                            break;
                          case 'gsw':
                            languageName = localizations.swissGerman;
                            break;
                          case 'arr':
                            languageName = localizations.pirate;
                            break;
                          case 'kaw':
                            languageName = localizations.kawaii;
                            break;
                          case 'arn':
                            languageName = localizations.arnold;
                            break;
                          case 'mag':
                            languageName = 'Maggus Style 💪';
                            break;
                          default:
                            languageName = localizations.german;
                        }
                        return _buildSettingsTile(
                          context,
                          icon: Icons.language_outlined,
                          title: localizations.language,
                          subtitle: languageName,
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _showLanguageSelector(context, languageProvider, localizations),
                        );
                      },
                    ),

                    // Only show Maggus Checker when Maggus language is active
                    Consumer<LanguageProvider>(
                      builder: (context, langProvider, _) {
                        if (langProvider.locale.languageCode == 'mag') {
                          return Column(
                            children: [
                              const Divider(),
                              // Maggus Checker (Easter Egg)
                              _buildSettingsTile(
                                context,
                                icon: Icons.fitness_center,
                                title: 'Maggus Checker',
                                subtitle: 'Des bedarfs! 💪',
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MaggusCheckerPage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                  ],
                ),
              ),
            ),

            // API Endpoint Settings Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.apiEndpoint,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Consumer<ApiStore>(
                      builder: (context, apiStore, child) {
                        // Always show the container with debug info
                        final hasAppInfo = apiStore.appInfo != null;
                        final version = hasAppInfo ? (apiStore.appInfo!['version'] ?? AppLocalizations.of(context)!.unknown) : AppLocalizations.of(context)!.loading;
                        final environment = hasAppInfo ? (apiStore.appInfo!['environment'] ?? AppLocalizations.of(context)!.unknown) : AppLocalizations.of(context)!.loading;
                        final lastError = apiStore.lastApiError ?? AppLocalizations.of(context)!.noError;
                        
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: hasAppInfo 
                                ? Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3)
                                : Colors.orange.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: hasAppInfo 
                                  ? Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)
                                  : Colors.orange.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hasAppInfo ? localizations.currentApiInfo : localizations.apiInfoStatus,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('${localizations.version}: $version'),
                              Text('${localizations.environment}: $environment'),
                              if (!hasAppInfo) ...[
                                const SizedBox(height: 4),
                                Text(
                                  '${localizations.error}: $lastError',
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
    final disabledColor = theme.colorScheme.onSurface.withValues(alpha: 0.38);
    
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

  void _showLanguageSelector(BuildContext context, LanguageProvider languageProvider, AppLocalizations localizations) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localizations.selectLanguage),
          content: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(
              maxHeight: 400,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLanguageOption(context, languageProvider, const Locale('de'), localizations.german, 'Deutsch'),
                  _buildLanguageOption(context, languageProvider, const Locale('en'), localizations.english, 'English'),
                  _buildLanguageOption(context, languageProvider, const Locale('nl'), 'Nederlands', 'Nederlands'),
                  _buildLanguageOption(context, languageProvider, const Locale('gsw'), localizations.swissGerman, 'Schwiizerdüütsch'),
                  _buildLanguageOption(context, languageProvider, const Locale('arr'), localizations.pirate, '🏴‍☠️ Pirate Speak'),
                  _buildLanguageOption(context, languageProvider, const Locale('kaw'), localizations.kawaii, '♡ Kawaii ♪'),
                  _buildLanguageOption(context, languageProvider, const Locale('arn'), localizations.arnold, '💪 Terminator'),
                  _buildLanguageOption(context, languageProvider, const Locale('mag'), 'Maggus Style', '💪 Des bedarfs!'),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(localizations.cancel),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    LanguageProvider languageProvider,
    Locale locale,
    String localizedName,
    String nativeName,
  ) {
    final isSelected = languageProvider.locale.languageCode == locale.languageCode;
    return ListTile(
      title: Text(nativeName),
      subtitle: Text(localizedName),
      leading: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            width: 2,
          ),
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            : null,
      ),
      selected: isSelected,
      onTap: () {
        languageProvider.setLocale(locale);
        Navigator.of(context).pop();
      },
      contentPadding: EdgeInsets.zero,
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
  bool _isTestingEndpoint = false;

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

  Future<void> _testEndpoint(String url) async {
    setState(() {
      _isTestingEndpoint = true;
    });

    try {
      // Try to fetch app info from the endpoint
      final apiClient = ApiClient(basePath: url);
      final appApi = AppApi(apiClient);

      final response = await appApi.appAppInfoWithHttpInfo().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('Connection timeout after 5 seconds');
        },
      );

      if (!mounted) return;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Success - endpoint is reachable
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Text(AppLocalizations.of(context)!.endpointReachable(response.statusCode)),
              ],
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Server returned an error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text(AppLocalizations.of(context)!.serverError(response.statusCode))),
              ],
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      String errorMessage;
      if (e is TimeoutException) {
        errorMessage = 'Timeout: Could not connect within 5 seconds';
      } else if (e.toString().contains('SocketException')) {
        errorMessage = 'Network error: Cannot reach endpoint';
      } else {
        errorMessage = 'Error: ${e.toString()}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(child: Text(errorMessage)),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isTestingEndpoint = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: localizations.apiBaseUrl,
            border: const OutlineInputBorder(),
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
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(localizations.apiUrlChanged(_currentUrl!)), backgroundColor: seedColor),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: seedColor,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(localizations.save),
                );
              },
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: _isTestingEndpoint ? null : () async {
                if (_currentUrl != null && _currentUrl!.isNotEmpty) {
                  await _testEndpoint(_currentUrl!);
                }
              },
              icon: _isTestingEndpoint
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.network_check),
              label: Text(_isTestingEndpoint ? 'Testing...' : 'Test Endpoint'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
