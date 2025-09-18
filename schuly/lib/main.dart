import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'pages/start_page.dart';
import 'pages/agenda_page.dart';
import 'pages/notes_page.dart';
import 'pages/absenzen_page.dart';
import 'pages/account_page.dart';
import 'pages/login_page.dart';
import 'pages/student_card_page.dart';
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
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize push notifications
  await PushNotificationService.initialize();

  await loadApiBaseUrl();
  final apiStore = ApiStore();
  final languageProvider = LanguageProvider();
  final loggingService = LoggingService();
  defaultApiClient = ApiClient(basePath: apiBaseUrl);

  // Log app startup
  loggingService.info('Schuly app started', source: 'main');
  loggingService.info('API base URL: $apiBaseUrl', source: 'main');

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
      final loggingService = Provider.of<LoggingService>(context, listen: false);
      loggingService.info('HomePage initialized', source: 'MyHomePage');
    });

    final apiStore = Provider.of<ApiStore>(context, listen: false);
    if (apiStore.userEmails.isNotEmpty && apiStore.activeUserEmail != null) {
      apiStore.fetchAll();
    }

    // Show app update dialog, release notes dialog, and notification permission dialog if needed
    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
      body: AnimatedSwitcher(
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
  bool _isAuthenticated = false;
  bool _hasStartedInit = false;

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

    // Step 1: App info and authentication
    if (mounted) {
      setState(() {
        _currentStepText = AppLocalizations.of(context)!.fetchingAppInfo;
      });
    }

    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;

    // Check if user is authenticated
    await apiStore.initialize();
    _isAuthenticated = apiStore.userEmails.isNotEmpty;

    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;

    // Step 2: Check for updates
    if (mounted) {
      setState(() {
        _currentStepText = AppLocalizations.of(context)!.checkingUpdatesInitialization;
      });
    }

    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;

    try {
      await UpdateService.checkForUpdates();
    } catch (e) {
      // Ignore errors, continue to next step
    }

    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;

    // Step 3: Load user data
    if (mounted) {
      setState(() {
        _currentStepText = AppLocalizations.of(context)!.loadingData;
      });
    }

    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;

    // Trigger fetchAll if user is authenticated
    if (_isAuthenticated && apiStore.activeUserEmail != null) {
      try {
        await apiStore.fetchAll();
      } catch (e) {
        // Ignore errors, continue to next step
      }
    }

    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;

    // Step 4: Finalizing
    if (mounted) {
      setState(() {
        _currentStepText = AppLocalizations.of(context)!.finalizingInitialization;
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
              child: Text(
                _currentStepText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}