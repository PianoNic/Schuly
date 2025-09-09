import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color seedColor;
  final Color lightBackground;
  final Color surfaceContainer;

  const AppColors({
    required this.seedColor,
    required this.lightBackground,
    required this.surfaceContainer,
  });

  @override
  AppColors copyWith({
    Color? seedColor,
    Color? lightBackground,
    Color? surfaceContainer,
  }) {
    return AppColors(
      seedColor: seedColor ?? this.seedColor,
      lightBackground: lightBackground ?? this.lightBackground,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      seedColor: Color.lerp(seedColor, other.seedColor, t)!,
      lightBackground: Color.lerp(lightBackground, other.lightBackground, t)!,
      surfaceContainer: Color.lerp(surfaceContainer, other.surfaceContainer, t)!,
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Color _seedColor = Colors.blue;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _themeModeKey = 'theme_mode';
  static const _seedColorKey = 'seed_color';

  ThemeProvider() {
    _loadThemePrefs();
  }

  ThemeMode get themeMode => _themeMode;
  Color get seedColor => _seedColor;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _storage.write(key: _themeModeKey, value: mode.name);
    notifyListeners();
  }

  void setSeedColor(Color color) {
    _seedColor = color;
    _storage.write(key: _seedColorKey, value: color.value.toString());
    notifyListeners();
  }

  Future<void> _loadThemePrefs() async {
    final mode = await _storage.read(key: _themeModeKey);
    final color = await _storage.read(key: _seedColorKey);
    if (mode != null) {
      _themeMode = ThemeMode.values.firstWhere((e) => e.name == mode, orElse: () => ThemeMode.system);
    }
    if (color != null) {
      _seedColor = Color(int.parse(color));
    }
    notifyListeners();
  }

  Future<void> clearThemePrefs() async {
    await _storage.delete(key: _themeModeKey);
    await _storage.delete(key: _seedColorKey);
    _themeMode = ThemeMode.system;
    _seedColor = Colors.blue;
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: _seedColor.withOpacity(0.2),
      backgroundColor: Colors.white,
    ),
    cardTheme: const CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: _seedColor),
      actionsIconTheme: IconThemeData(color: _seedColor),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _seedColor;
        }
        return null;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _seedColor.withOpacity(0.5);
        }
        return null;
      }),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _seedColor,
      foregroundColor: Colors.white,
    ),
    extensions: <ThemeExtension<dynamic>>[
      AppColors(
        seedColor: _seedColor,
        lightBackground: _seedColor.withOpacity(0.1),
        surfaceContainer: _seedColor.withOpacity(0.05),
      ),
    ],
  );

  ThemeData get darkTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: _seedColor.withOpacity(0.3),
      backgroundColor: const Color(0xFF1C1B1F),
    ),
    cardTheme: const CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: _seedColor),
      actionsIconTheme: IconThemeData(color: _seedColor),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _seedColor;
        }
        return null;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _seedColor.withOpacity(0.5);
        }
        return null;
      }),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _seedColor,
      foregroundColor: Colors.white,
    ),
    extensions: <ThemeExtension<dynamic>>[
      AppColors(
        seedColor: _seedColor,
        lightBackground: _seedColor.withOpacity(0.15),
        surfaceContainer: _seedColor.withOpacity(0.1),
      ),
    ],
  );
}
