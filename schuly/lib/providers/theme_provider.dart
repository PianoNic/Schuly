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
  Color _seedColor = Colors.blue; // Default to classic blue
  bool _isNeonMode = false; // Default to classic colors
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _themeModeKey = 'theme_mode';
  static const _seedColorKey = 'seed_color';
  static const _neonModeKey = 'neon_mode';

  ThemeProvider() {
    _loadThemePrefs();
  }

  ThemeMode get themeMode => _themeMode;
  Color get seedColor => _seedColor;
  bool get isNeonMode => _isNeonMode;
  
  // List of neon colors for special effects
  static const List<Color> _neonColors = [
    Color(0xFF8A2BE2), // Neon Violet
    Color(0xFF00FFFF), // Neon Cyan
    Color(0xFF39FF14), // Neon Green
    Color(0xFFFF69B4), // Neon Pink (lighter)
    Color(0xFFFF6600), // Neon Orange
    Color(0xFF0080FF), // Neon Blue
    Color(0xFFFF0040), // Neon Red
    Color(0xFFFFFF00), // Neon Yellow
    Color(0xFF00FF80), // Neon Mint (replaced lila)
  ];
  
  // List of classic colors
  static const List<Color> _classicColors = [
    Colors.blue,        // Classic Blue
    Colors.teal,        // Classic Teal
    Colors.green,       // Classic Green
    Colors.pink,        // Classic Pink (lighter)
    Colors.orange,      // Classic Orange
    Colors.indigo,      // Classic Indigo
    Colors.red,         // Classic Red
    Colors.amber,       // Classic Amber
    Colors.purple,      // Classic Purple
  ];
  
  bool get isNeonColor => _isNeonMode;

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

  void setNeonMode(bool isNeon) {
    _isNeonMode = isNeon;
    _storage.write(key: _neonModeKey, value: isNeon.toString());
    
    // Switch to appropriate default color when toggling modes
    if (isNeon && _classicColors.contains(_seedColor)) {
      _seedColor = _neonColors[0]; // Default to neon violet
      _storage.write(key: _seedColorKey, value: _seedColor.value.toString());
    } else if (!isNeon && _neonColors.contains(_seedColor)) {
      _seedColor = _classicColors[0]; // Default to classic blue
      _storage.write(key: _seedColorKey, value: _seedColor.value.toString());
    }
    
    notifyListeners();
  }

  Future<void> _loadThemePrefs() async {
    final mode = await _storage.read(key: _themeModeKey);
    final color = await _storage.read(key: _seedColorKey);
    final neonMode = await _storage.read(key: _neonModeKey);
    
    if (mode != null) {
      _themeMode = ThemeMode.values.firstWhere((e) => e.name == mode, orElse: () => ThemeMode.system);
    }
    if (color != null) {
      _seedColor = Color(int.parse(color));
    }
    if (neonMode != null) {
      _isNeonMode = neonMode == 'true';
    }
    notifyListeners();
  }

  Future<void> clearThemePrefs() async {
    await _storage.delete(key: _themeModeKey);
    await _storage.delete(key: _seedColorKey);
    await _storage.delete(key: _neonModeKey);
    _themeMode = ThemeMode.system;
    _seedColor = Colors.blue; // Reset to classic blue
    _isNeonMode = false; // Reset to classic mode
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: isNeonColor ? _seedColor.withOpacity(0.15) : _seedColor.withOpacity(0.2),
      backgroundColor: Colors.white,
      shadowColor: isNeonColor ? _seedColor.withOpacity(0.1) : null,
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
      indicatorColor: isNeonColor ? _seedColor.withOpacity(0.25) : _seedColor.withOpacity(0.3),
      backgroundColor: const Color(0xFF1C1B1F),
      shadowColor: isNeonColor ? _seedColor.withOpacity(0.2) : null,
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
