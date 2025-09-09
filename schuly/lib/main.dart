import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'pages/start_page.dart';
import 'pages/agenda_page.dart';
import 'pages/notes_page.dart';
import 'pages/absenzen_page.dart';
import 'pages/account_page.dart';
import 'pages/login_page.dart';
import 'providers/theme_provider.dart';
import 'providers/api_store.dart';
import 'package:schuly/api/lib/api.dart';

String apiBaseUrl = 'https://schulware.pianonic.ch'; // Default, can be changed at runtime
const _apiUrlKey = 'api_base_url';
final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

Future<void> loadApiBaseUrl() async {
  final storedUrl = await _secureStorage.read(key: _apiUrlKey);
  if (storedUrl != null && storedUrl.isNotEmpty) {
    apiBaseUrl = storedUrl;
    defaultApiClient.basePath = apiBaseUrl;
  }
}

Future<void> setApiBaseUrl(String url) async {
  apiBaseUrl = url;
  defaultApiClient.basePath = url;
  await _secureStorage.write(key: _apiUrlKey, value: url);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadApiBaseUrl();
  final apiStore = ApiStore();
  await apiStore.loadUsers();
  await apiStore.autoLoginIfNeeded();
  defaultApiClient.basePath = apiBaseUrl;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => apiStore),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const SchulyApp(),
    ),
  );
}

class SchulyApp extends StatelessWidget {
  const SchulyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<ApiStore>(
      builder: (context, apiStore, _) {
        if (apiStore.userEmails.isEmpty) {
          // Wrap LoginPage in MaterialApp with theming
          return MaterialApp(
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            home: LoginPage(
              onApiBaseUrlChanged: (url) async {
                await setApiBaseUrl(url);
              },
              initialApiBaseUrl: apiBaseUrl,
            ),
          );
        }
        return MaterialApp(
          title: 'schulNetz',
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: themeProvider.themeMode,
          home: MyHomePage(title: 'schulNetz', themeProvider: themeProvider),
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
    final apiStore = Provider.of<ApiStore>(context, listen: false);
    if (apiStore.userEmails.isNotEmpty && apiStore.activeUserEmail != null) {
      apiStore.fetchAll();
    }
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

  @override
  Widget build(BuildContext context) {
    // 4. A list of pages is created to be indexed
    final List<Widget> pages = [
      StartPage(onNavigateToAbsenzen: () => navigateToPage(3)),
      const AgendaPage(),
      const NotesPage(),
      const AbsenzenPage(),
      AccountPage(themeProvider: widget.themeProvider),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // 5. PageView is replaced with a direct index call to the list
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Start',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          NavigationDestination(
            icon: Icon(Icons.grade_outlined),
            selectedIcon: Icon(Icons.grade),
            label: 'Noten',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list_alt),
            label: 'Absenzen',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}