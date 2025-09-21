import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'dart:async';
import 'l10n/app_localizations.dart';
import 'pages/start_page.dart';
import 'pages/agenda_page.dart';
import 'pages/notes_page.dart';
import 'pages/absenzen_page.dart';
import 'pages/account_page.dart';
import 'pages/login_page.dart';
import 'pages/student_card_page.dart';
import 'pages/microsoft_auth_page.dart';
import 'providers/theme_provider.dart';
import 'providers/api_store.dart';
import 'providers/homepage_config_provider.dart';
import 'providers/language_provider.dart';
import 'providers/logging_service.dart';
import 'services/storage_service.dart';
import 'services/push_notification_service.dart';
import 'services/update_service.dart';
import 'widgets/homepage_config_modal.dart';
import 'widgets/release_notes_dialog.dart';
import 'widgets/app_update_dialog.dart';
import 'widgets/notification_permission_dialog.dart';
import 'package:schuly/api/lib/api.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'l10n/pirate_material_localizations.dart';
import 'l10n/pirate_cupertino_localizations.dart';
import 'l10n/kawaii_material_localizations.dart';
import 'l10n/kawaii_cupertino_localizations.dart';
import 'utils/logger.dart';
 
String apiBaseUrl = 'https://schlwr.pianonic.ch';

Future<void> loadApiBaseUrl() async {
  final storedUrl = await StorageService.getApiUrl();
  if (storedUrl != null && storedUrl.isNotEmpty) {
    apiBaseUrl = storedUrl;
    defaultApiClient = ApiClient(basePath: apiBaseUrl);
  }
}

Future<void> setApiBaseUrl(String url) async {
  apiBaseUrl = url;
  defaultApiClient = ApiClient(basePath: url);
  await StorageService.setApiUrl(url);
}

void main() async {
  // Check if Sentry DSN is provided (needs to be outside runZonedGuarded)
  const sentryDsn = String.fromEnvironment('SENTRY_DSN', defaultValue: '');

  // Run app in a guarded zone to catch all errors
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Initialize push notifications
      await PushNotificationService.initialize();

      await loadApiBaseUrl();
      final apiStore = ApiStore();
      final languageProvider = LanguageProvider();
      final loggingService = LoggingService();
      defaultApiClient = ApiClient(basePath: apiBaseUrl);

      // Log app startup
      logInfo('Schuly app started', source: 'main');
      logInfo('API base URL: $apiBaseUrl', source: 'main');

      if (sentryDsn.isNotEmpty) {
        // Initialize Sentry only if DSN is provided
        await SentryFlutter.init(
          (options) {
            options.dsn = sentryDsn;

            // Set release version
            options.release = const String.fromEnvironment(
              'SENTRY_RELEASE',
              defaultValue: '1.0.0',
            );

            // Set environment
            options.environment = const String.fromEnvironment(
              'SENTRY_ENVIRONMENT',
              defaultValue: 'production',
            );

            // Performance monitoring sample rate (10% of events)
            options.tracesSampleRate = 0.10;

            // Disable auto session tracking as recommended by GlitchTip
            options.enableAutoSessionTracking = false;

            // Enable automatic error capture
            options.attachStacktrace = true;
            options.attachThreads = true;

            // Set diagnostic level for debugging (set to none in production)
            options.diagnosticLevel = SentryLevel.error;

            // Before send callback to filter sensitive data
            options.beforeSend = (SentryEvent event, Hint hint) async {
              // Filter out sensitive information
              if (event.message?.formatted.contains('password') == true ||
                  event.message?.formatted.contains('token') == true) {
                return null; // Don't send events with sensitive data
              }
              return event;
            };
          },
          appRunner: () => runApp(
            MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => apiStore),
                ChangeNotifierProvider(create: (_) => ThemeProvider()),
                ChangeNotifierProvider(create: (_) => HomepageConfigProvider()),
                ChangeNotifierProvider.value(value: languageProvider),
                ChangeNotifierProvider.value(value: loggingService),
              ],
              child: const SchulyApp(),
            ),
          ),
        );
      } else {
        // Run without Sentry if no DSN provided
        logInfo('Running without Sentry/GlitchTip integration (no DSN provided)', source: 'main');
        runApp(
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => apiStore),
              ChangeNotifierProvider(create: (_) => ThemeProvider()),
              ChangeNotifierProvider(create: (_) => HomepageConfigProvider()),
              ChangeNotifierProvider.value(value: languageProvider),
              ChangeNotifierProvider.value(value: loggingService),
            ],
            child: const SchulyApp(),
          ),
        );
      }
    },
    (error, stackTrace) {
      // Catch any errors that weren't caught by Flutter or Sentry
      if (sentryDsn.isNotEmpty) {
        Sentry.captureException(error, stackTrace: stackTrace);
      } else {
        // Just log to console if Sentry is not configured
        logError('Uncaught error', source: 'main', error: error, stackTrace: stackTrace);
      }
    },
  );
}

class SchulyApp extends StatefulWidget {
  const SchulyApp({super.key});

  @override
  State<SchulyApp> createState() => _SchulyAppState();
}

class _SchulyAppState extends State<SchulyApp> {
  bool _showSplashScreen = true;

  void _onSplashScreenComplete() {
    setState(() {
      _showSplashScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<ThemeProvider, LanguageProvider, ApiStore>(
      builder: (context, themeProvider, languageProvider, apiStore, _) {
        // Show splash screen during initialization
        if (_showSplashScreen) {
          return DynamicColorBuilder(
            builder: (lightDynamic, darkDynamic) {
              return MaterialApp(
                theme: themeProvider.lightTheme(lightDynamic),
                darkTheme: themeProvider.darkTheme(darkDynamic),
                themeMode: themeProvider.themeMode,
                locale: languageProvider.locale,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  if (languageProvider.locale.languageCode == 'arr') ...[
                    PirateMaterialLocalizations.delegate,
                    PirateCupertinoLocalizations.delegate,
                  ] else if (languageProvider.locale.languageCode == 'kaw') ...[
                    KawaiiMaterialLocalizations.delegate,
                    KawaiiCupertinoLocalizations.delegate,
                  ] else ...[
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('de'),
                  Locale('gsw'),
                  Locale('arr'),
                  Locale('kaw'),
                ],
                home: SplashScreen(onComplete: _onSplashScreenComplete),
              );
            },
          );
        }

        if (apiStore.userEmails.isEmpty) {
          // Wrap LoginPage in MaterialApp with theming
          return DynamicColorBuilder(
            builder: (lightDynamic, darkDynamic) {
              return MaterialApp(
                theme: themeProvider.lightTheme(lightDynamic),
                darkTheme: themeProvider.darkTheme(darkDynamic),
                themeMode: themeProvider.themeMode,
                locale: languageProvider.locale,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  if (languageProvider.locale.languageCode == 'arr') ...[
                    PirateMaterialLocalizations.delegate,
                    PirateCupertinoLocalizations.delegate,
                  ] else if (languageProvider.locale.languageCode == 'kaw') ...[
                    KawaiiMaterialLocalizations.delegate,
                    KawaiiCupertinoLocalizations.delegate,
                  ] else ...[
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('de'),
                  Locale('gsw'),
                  Locale('arr'),
                  Locale('kaw'),
                ],
                home: LoginPage(
                  onApiBaseUrlChanged: (url) async {
                    await setApiBaseUrl(url);
                  },
                  initialApiBaseUrl: apiBaseUrl,
                ),
              );
            },
          );
        }
        return DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) {
            return MaterialApp(
              title: 'Schuly',
              theme: themeProvider.lightTheme(lightDynamic),
              darkTheme: themeProvider.darkTheme(darkDynamic),
              themeMode: themeProvider.themeMode,
              locale: languageProvider.locale,
              localizationsDelegates: [
                AppLocalizations.delegate,
                if (languageProvider.locale.languageCode == 'arr') ...[
                  PirateMaterialLocalizations.delegate,
                  PirateCupertinoLocalizations.delegate,
                ] else if (languageProvider.locale.languageCode == 'kaw') ...[
                  KawaiiMaterialLocalizations.delegate,
                  KawaiiCupertinoLocalizations.delegate,
                ] else ...[
                  GlobalCupertinoLocalizations.delegate,
                ],
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('de'),
                Locale('gsw'),
                Locale('arr'),
                Locale('kaw'),
              ],
              home: MyHomePage(title: 'Schuly', themeProvider: themeProvider),
            );
          },
        );
      },
    );
  } 
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.themeProvider,
  });

  final String title;
  final ThemeProvider themeProvider;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // Initialize logger with context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Logger.init(context);
      logInfo('HomePage initialized', source: 'MyHomePage');
    });

    final apiStore = Provider.of<ApiStore>(context, listen: false);
    if (apiStore.userEmails.isNotEmpty && apiStore.activeUserEmail != null) {
      apiStore.fetchAll();
    }

    // Show app update dialog, release notes dialog, and notification permission dialog if needed
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Check if Microsoft re-authentication is needed (highest priority)
      final apiStore = Provider.of<ApiStore>(context, listen: false);
      if (apiStore.needsMicrosoftReAuth && apiStore.activeUserEmail != null) {
        final email = apiStore.activeUserEmail!;
        logInfo('Opening Microsoft re-authentication for expired token', source: 'MyHomePage');

        if (mounted) {
          final result = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
              builder: (ctx) => MicrosoftAuthPage(
                apiBaseUrl: apiBaseUrl,
                existingUserEmail: email,
                onAuthSuccess: (accessToken, refreshToken, userEmail) async {
                  // Update the user's tokens
                  await apiStore.updateMicrosoftUserTokens(accessToken, refreshToken);

                  // Fetch all data after successful re-authentication
                  await apiStore.fetchAll(forceRefresh: true);
                },
              ),
            ),
          );

          if (result != true && mounted) {
            // User cancelled re-authentication
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.reAuthenticationCancelled),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        }
        return; // Exit early after handling re-authentication
      }

      // Check for app updates first (higher priority)
      await AppUpdateDialog.showIfAvailable(context);

      // Then check for release notes
      if (mounted) {
        await ReleaseNotesDialog.showIfNeeded(context);
      }

      // Finally check notification permissions
      if (mounted) {
        final hasShownBefore = await StorageService.getHasShownPermissionDialog();
        final notificationsEnabled = await StorageService.getPushNotificationsEnabled();

        // Show dialog if notifications are enabled but dialog hasn't been shown before
        // Or if user hasn't seen it yet and might want to enable notifications
        if (!hasShownBefore || (notificationsEnabled && !hasShownBefore)) {
          if (mounted) {
            showNotificationPermissionDialog(context, isStartupCheck: true);
            await StorageService.setHasShownPermissionDialog(true);
          }
        }
      }
    });
  }

  // 2. _onItemTapped is simplified
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 3. _onPageChanged is removed as it was only for PageView

  // This method still works perfectly for navigating from the StartPage
  void navigateToPage(int index) {
    _onItemTapped(index);
  }

  void _showHomepageConfigDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => const HomepageConfigModal(),
    );
  }


  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final apiStore = Provider.of<ApiStore>(context);

    // 4. A list of pages is created to be indexed
    final List<Widget> pages = [
      StartPage(onNavigateToAbsenzen: () => navigateToPage(3)),
      const AgendaPage(),
      const NotesPage(),
      const AbsenzenPage(),
      AccountPage(themeProvider: widget.themeProvider),
    ];

    // Page titles for the header
    final List<String> pageTitles = [
      localizations.start,
      localizations.agenda,
      localizations.grades,
      localizations.absences,
      localizations.account,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          pageTitles[_selectedIndex],
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: _selectedIndex == 0 ? [
          // Homepage configuration icon
          IconButton(
            onPressed: () {
              _showHomepageConfigDialog(context);
            },
            icon: Icon(
              Icons.tune,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: AppLocalizations.of(context)!.customizeHomepageTooltip,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StudentCardPage()),
              );
            },
            icon: Icon(
              Icons.badge_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: AppLocalizations.of(context)!.studentIdCardTooltip,
          ),
        ] : _selectedIndex != 4 ? [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StudentCardPage()),
              );
            },
            icon: Icon(
              Icons.badge_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: AppLocalizations.of(context)!.studentIdCardTooltip,
          ),
        ] : null,
      ),
      // 5. PageView is replaced with animated page transitions
      body: Column(
        children: [
          // Offline mode indicator
          if (apiStore.isOfflineMode)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.orange.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.cloud_off,
                    size: 16,
                    color: Colors.orange[700],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.offlineModeDetected,
                    style: TextStyle(
                      color: Colors.orange[700],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
          return Stack(
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        child: Container(
          key: ValueKey(_selectedIndex),
          child: pages[_selectedIndex],
        ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          final appColors = Theme.of(context).extension<AppColors>();
          final seedColor = appColors?.seedColor ?? Theme.of(context).colorScheme.primary;
          
          return NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            animationDuration: const Duration(milliseconds: 300),
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined,
                  color: _selectedIndex == 0 ? seedColor : null),
                selectedIcon: Icon(Icons.home, color: seedColor),
                label: localizations.start,
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_today_outlined,
                  color: _selectedIndex == 1 ? seedColor : null),
                selectedIcon: Icon(Icons.calendar_today, color: seedColor),
                label: localizations.agenda,
              ),
              NavigationDestination(
                icon: Icon(Icons.grade_outlined,
                  color: _selectedIndex == 2 ? seedColor : null),
                selectedIcon: Icon(Icons.grade, color: seedColor),
                label: localizations.grades,
              ),
              NavigationDestination(
                icon: Icon(Icons.list_alt_outlined,
                  color: _selectedIndex == 3 ? seedColor : null),
                selectedIcon: Icon(Icons.list_alt, color: seedColor),
                label: localizations.absences,
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline,
                  color: _selectedIndex == 4 ? seedColor : null),
                selectedIcon: Icon(Icons.person, color: seedColor),
                label: localizations.account,
              ),
            ],
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final VoidCallback? onComplete;

  const SplashScreen({super.key, this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _currentStepText = '';
  bool _hasStartedInit = false;

  bool _isOfflineMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasStartedInit) {
      _hasStartedInit = true;
      _initializeApp();
    }
  }

  Future<void> _initializeApp() async {
    final apiStore = Provider.of<ApiStore>(context, listen: false);
    final localizations = AppLocalizations.of(context)!;

    // Step 1: Check connection and initialize
    if (mounted) {
      setState(() {
        _currentStepText = localizations.checkingConnection;
      });
    }

    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;

    // Initialize will check connectivity and load data accordingly
    await apiStore.initialize();
    _isOfflineMode = apiStore.isOfflineMode;

    // Show offline mode message if detected
    if (_isOfflineMode && mounted) {
      setState(() {
        _currentStepText = localizations.offlineModeDetected;
      });
      await Future.delayed(const Duration(milliseconds: 800));
      if (!mounted) return;
    }

    // Step 2: Skip update check if offline
    if (!_isOfflineMode) {
      if (mounted) {
        setState(() {
          _currentStepText = localizations.checkingUpdatesInitialization;
        });
      }

      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted) return;

      try {
        await UpdateService.checkForUpdates();
      } catch (e) {
        // Ignore errors, continue to next step
      }
    }

    // Step 3: Show appropriate loading message
    if (mounted) {
      setState(() {
        _currentStepText = _isOfflineMode
            ? localizations.loadingCachedData
            : localizations.loadingData;
      });
    }

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    // Step 4: Finalizing
    if (mounted) {
      setState(() {
        _currentStepText = localizations.finalizingInitialization;
      });
    }

    await Future.delayed(const Duration(milliseconds: 100));

    // Mark initialization as complete
    if (mounted) {
      // Call the completion callback after a brief delay
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && widget.onComplete != null) {
          widget.onComplete!();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App icon
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'assets/app_icon.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Schuly',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),

            // Show offline indicator or loading spinner
            if (_isOfflineMode)
              Icon(
                Icons.cloud_off,
                size: 32,
                color: Colors.orange[700],
              )
            else
              SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Current step text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Text(
                    _currentStepText,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: _isOfflineMode
                          ? Colors.orange[700]
                          : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  if (_isOfflineMode) ...[
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.noInternetConnection,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.orange[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}