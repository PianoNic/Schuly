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
  bool _useMaterialYou = true; // Default to Material You for modern experience
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _themeModeKey = 'theme_mode';
  static const _seedColorKey = 'seed_color';
  static const _neonModeKey = 'neon_mode';
  static const _materialYouKey = 'material_you';

  ThemeProvider() {
    _loadThemePrefs();
  }

  ThemeMode get themeMode => _themeMode;
  Color get seedColor => _seedColor;
  bool get isNeonMode => _isNeonMode;
  bool get useMaterialYou => _useMaterialYou;
  
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
    
    // Disable Material You when manually selecting a color
    if (_useMaterialYou) {
      _useMaterialYou = false;
      _storage.write(key: _materialYouKey, value: 'false');
    }
    
    notifyListeners();
  }

  void setNeonMode(bool isNeon) {
    _isNeonMode = isNeon;
    _storage.write(key: _neonModeKey, value: isNeon.toString());
    
    // Disable Material You when switching to manual color selection
    if (_useMaterialYou) {
      _useMaterialYou = false;
      _storage.write(key: _materialYouKey, value: 'false');
    }
    
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

  void setMaterialYou(bool useMaterialYou) {
    _useMaterialYou = useMaterialYou;
    _storage.write(key: _materialYouKey, value: useMaterialYou.toString());
    notifyListeners();
  }

  Future<void> _loadThemePrefs() async {
    final mode = await _storage.read(key: _themeModeKey);
    final color = await _storage.read(key: _seedColorKey);
    final neonMode = await _storage.read(key: _neonModeKey);
    final materialYou = await _storage.read(key: _materialYouKey);
    
    if (mode != null) {
      _themeMode = ThemeMode.values.firstWhere((e) => e.name == mode, orElse: () => ThemeMode.system);
    }
    if (color != null) {
      _seedColor = Color(int.parse(color));
    }
    if (neonMode != null) {
      _isNeonMode = neonMode == 'true';
    }
    if (materialYou != null) {
      _useMaterialYou = materialYou == 'true';
    }
    notifyListeners();
  }

  Future<void> clearThemePrefs() async {
    await _storage.delete(key: _themeModeKey);
    await _storage.delete(key: _seedColorKey);
    await _storage.delete(key: _neonModeKey);
    await _storage.delete(key: _materialYouKey);
    _themeMode = ThemeMode.system;
    _seedColor = Colors.blue; // Reset to classic blue
    _isNeonMode = false; // Reset to classic mode
    _useMaterialYou = true; // Reset to Material You default
    notifyListeners();
  }

  ThemeData get lightTheme {
    final colorScheme = _useMaterialYou 
        ? null // Let Material 3 use system dynamic colors
        : ColorScheme.fromSeed(
            seedColor: _seedColor,
            brightness: Brightness.light,
          );
    
    // Create base theme with or without Material You
    final baseTheme = ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
    );
    
    // Get the actual color scheme (either dynamic or manual)
    final actualColorScheme = baseTheme.colorScheme;
    final effectiveSeedColor = _useMaterialYou 
        ? actualColorScheme.primary 
        : _seedColor;
    
    return baseTheme.copyWith(
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: isNeonColor && !_useMaterialYou 
            ? effectiveSeedColor.withOpacity(0.15) 
            : effectiveSeedColor.withOpacity(0.2),
        backgroundColor: Colors.white,
        shadowColor: isNeonColor && !_useMaterialYou 
            ? effectiveSeedColor.withOpacity(0.1) 
            : null,
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: effectiveSeedColor),
        actionsIconTheme: IconThemeData(color: effectiveSeedColor),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return effectiveSeedColor;
          }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return effectiveSeedColor.withOpacity(0.5);
          }
          return null;
        }),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: effectiveSeedColor,
        foregroundColor: Colors.white,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppColors(
          seedColor: effectiveSeedColor,
          lightBackground: effectiveSeedColor.withOpacity(0.1),
          surfaceContainer: effectiveSeedColor.withOpacity(0.05),
        ),
      ],
    );
  }

  ThemeData get darkTheme {
    final colorScheme = _useMaterialYou 
        ? null // Let Material 3 use system dynamic colors
        : ColorScheme.fromSeed(
            seedColor: _seedColor,
            brightness: Brightness.dark,
          );
    
    // Create base theme with or without Material You
    final baseTheme = ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
    );
    
    // Get the actual color scheme (either dynamic or manual)
    final actualColorScheme = baseTheme.colorScheme;
    final effectiveSeedColor = _useMaterialYou 
        ? actualColorScheme.primary 
        : _seedColor;
    
    return baseTheme.copyWith(
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: isNeonColor && !_useMaterialYou
            ? effectiveSeedColor.withOpacity(0.25) 
            : effectiveSeedColor.withOpacity(0.3),
        backgroundColor: const Color(0xFF1C1B1F),
        shadowColor: isNeonColor && !_useMaterialYou 
            ? effectiveSeedColor.withOpacity(0.2) 
            : null,
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: effectiveSeedColor),
        actionsIconTheme: IconThemeData(color: effectiveSeedColor),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return effectiveSeedColor;
          }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return effectiveSeedColor.withOpacity(0.5);
          }
          return null;
        }),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: effectiveSeedColor,
        foregroundColor: Colors.white,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppColors(
          seedColor: effectiveSeedColor,
          lightBackground: effectiveSeedColor.withOpacity(0.15),
          surfaceContainer: effectiveSeedColor.withOpacity(0.1),
        ),
      ],
    );
  }
}
