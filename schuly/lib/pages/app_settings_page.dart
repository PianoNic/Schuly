import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:schuly/api/lib/api.dart';
import 'dart:async';
import '../widgets/theme_settings.dart';
import '../providers/theme_provider.dart';
import '../providers/api_store.dart';
import '../services/storage_service.dart';
import '../main.dart';
import 'notification_config_page.dart';
import 'release_notes_page.dart';
import '../services/app_update_service.dart';
import '../widgets/app_update_dialog.dart';
import '../l10n/app_localizations.dart';
import '../providers/language_provider.dart';
import '../services/push_notification_service.dart';
import '../utils/error_handler.dart';

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
  bool _isTestingError = false;
  DateTime? _lastErrorTest;

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

  bool get _canTestError {
    if (_lastErrorTest == null) return true;
    final now = DateTime.now();
    final difference = now.difference(_lastErrorTest!);
    return difference.inSeconds >= 30;
  }

  int get _remainingSeconds {
    if (_lastErrorTest == null) return 0;
    final now = DateTime.now();
    final difference = now.difference(_lastErrorTest!);
    final remaining = 30 - difference.inSeconds;
    return remaining > 0 ? remaining : 0;
  }

  Future<void> _triggerTestError() async {
    if (!_canTestError || _isTestingError) return;

    setState(() {
      _isTestingError = true;
      _lastErrorTest = DateTime.now();
    });

    try {
      // Create a test error with context
      throw Exception('Test error from Settings - Error tracking verification at ${DateTime.now().toIso8601String()}');
    } catch (e, stackTrace) {
      await ErrorHandler.captureException(
        e,
        stackTrace: stackTrace,
        userMessage: 'Test error triggered from settings',
        context: context,
        extra: {
          'test_type': 'manual_settings_trigger',
          'app_version': _appVersion,
          'build_number': _appBuildNumber,
        },
        showSnackbar: true,
      );
    }

    setState(() {
      _isTestingError = false;
    });

    // Start a timer to update the UI every second for the countdown
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        if (mounted) setState(() {});
      } else {
        if (mounted) setState(() {});
      }
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Test error sent to GlitchTip'),
          backgroundColor: Colors.orange[700],
          duration: const Duration(seconds: 3),
        ),
      );
    }
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
              SnackBar(
                content: Text(AppLocalizations.of(context)!.latestVersionMessage),
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
            content: Text(AppLocalizations.of(context)!.errorCheckingUpdatesDetails(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
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

                    const Divider(),


                    // Language Setting
                    Builder(
                      builder: (context) {
                        final languageProvider = Provider.of<LanguageProvider>(context);
                        final locale = languageProvider.locale;
                        String languageName;
                        switch (locale.languageCode) {
                          case 'en':
                            languageName = localizations.english;
                            break;
                          case 'de':
                            languageName = localizations.german;
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

                    const Divider(),

                    // Release Notes
                    _buildSettingsTile(
                      context,
                      icon: Icons.article_outlined,
                      title: localizations.whatsNew,
                      subtitle: localizations.changelogAndFeatures,
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
                      title: localizations.checkForUpdates,
                      subtitle: localizations.checkForNewVersions,
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
                      title: localizations.aboutApp,
                      subtitle: localizations.versionWithNumber(_appVersion, _appBuildNumber),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Error tracking status badge
                          if (ErrorHandler.isSentryEnabled) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.green.withValues(alpha: 0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shield_outlined,
                                    size: 14,
                                    color: Colors.green[700],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Error Tracking',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: localizations.appTitle,
                          applicationVersion: '$_appVersion+$_appBuildNumber',
                          applicationLegalese: localizations.appLegalese,
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              localizations.appDescription,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 12),
                            // Show error tracking status
                            if (ErrorHandler.isSentryEnabled) ...[
                              const Divider(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green[700],
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Error tracking enabled',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'App errors are automatically reported for improved stability.',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ],
                        );
                      },
                    ),

                    // Test Error Tracking (only show if Sentry is enabled)
                    if (ErrorHandler.isSentryEnabled) ...[
                      const Divider(),
                      _buildSettingsTile(
                        context,
                        icon: Icons.bug_report_outlined,
                        title: 'Test Error Tracking',
                        subtitle: _canTestError
                            ? 'Send a test error to GlitchTip'
                            : 'Wait $_remainingSeconds seconds',
                        trailing: _isTestingError
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _canTestError
                                      ? Colors.orange.withValues(alpha: 0.15)
                                      : Colors.grey.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: _canTestError
                                        ? Colors.orange.withValues(alpha: 0.3)
                                        : Colors.grey.withValues(alpha: 0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.send,
                                      size: 14,
                                      color: _canTestError ? Colors.orange[700] : Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _canTestError ? 'Send Test' : '$_remainingSeconds s',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _canTestError ? Colors.orange[700] : Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        onTap: _canTestError && !_isTestingError ? _triggerTestError : null,
                        isEnabled: _canTestError && !_isTestingError,
                      ),
                    ],
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption(context, languageProvider, const Locale('de'), localizations.german, 'Deutsch'),
              _buildLanguageOption(context, languageProvider, const Locale('en'), localizations.english, 'English'),
              _buildLanguageOption(context, languageProvider, const Locale('gsw'), localizations.swissGerman, 'Schwiizerdüütsch'),
              _buildLanguageOption(context, languageProvider, const Locale('arr'), localizations.pirate, '🏴‍☠️ Pirate Speak'),
              _buildLanguageOption(context, languageProvider, const Locale('kaw'), localizations.kawaii, '♡ Kawaii ♪'),
            ],
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
      leading: Radio<String>(
        value: locale.languageCode,
        groupValue: languageProvider.locale.languageCode,
        onChanged: (value) {
          if (value != null) {
            languageProvider.setLocale(locale);
            Navigator.of(context).pop();
          }
        },
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
                Text('Endpoint reachable (${response.statusCode})'),
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
                Expanded(child: Text('Server error: ${response.statusCode}')),
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
