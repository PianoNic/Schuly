import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  );

  ThemeData get darkTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
