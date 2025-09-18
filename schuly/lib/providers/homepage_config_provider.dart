import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SectionConfig {
  final String id;
  final String title;
  final IconData icon;
  bool isVisible;

  SectionConfig({
    required this.id,
    required this.title,
    required this.icon,
    required this.isVisible,
  });

  SectionConfig copyWith({
    String? id,
    String? title,
    IconData? icon,
    bool? isVisible,
  }) {
    return SectionConfig(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  // Map IconData to string identifier for JSON serialization
  static String _getIconKey(IconData iconData) {
    if (iconData == Icons.schedule) return 'schedule';
    if (iconData == Icons.beach_access) return 'beach_access';
    if (iconData == Icons.grade) return 'grade';
    if (iconData == Icons.list_alt) return 'list_alt';
    return 'schedule'; // fallback
  }

  // Map string identifier back to IconData
  static IconData _getIconFromKey(String key) {
    switch (key) {
      case 'schedule':
        return Icons.schedule;
      case 'beach_access':
        return Icons.beach_access;
      case 'grade':
        return Icons.grade;
      case 'list_alt':
        return Icons.list_alt;
      default:
        return Icons.schedule; // fallback
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': _getIconKey(icon),
      'isVisible': isVisible,
    };
  }

  static SectionConfig fromJson(Map<String, dynamic> json) {
    IconData iconData;
    
    // Handle both old format (codePoint) and new format (string key)
    if (json['icon'] is int) {
      // Old format - migrate from codePoint to string key
      iconData = _getIconFromCodePoint(json['icon']);
    } else {
      // New format - use string key
      iconData = _getIconFromKey(json['icon']);
    }
    
    return SectionConfig(
      id: json['id'],
      title: json['title'],
      icon: iconData,
      isVisible: json['isVisible'],
    );
  }

  // Helper method to migrate from old codePoint format
  static IconData _getIconFromCodePoint(int codePoint) {
    // Map known codePoints to their corresponding Icons
    if (codePoint == Icons.schedule.codePoint) return Icons.schedule;
    if (codePoint == Icons.beach_access.codePoint) return Icons.beach_access;
    if (codePoint == Icons.grade.codePoint) return Icons.grade;
    if (codePoint == Icons.list_alt.codePoint) return Icons.list_alt;
    return Icons.schedule; // fallback
  }
}

class HomepageConfigProvider extends ChangeNotifier {
  bool _showBreaks = true;

  List<SectionConfig> _sections = [
    SectionConfig(
      id: 'lessons',
      title: 'Nächste Lektionen',
      icon: Icons.schedule,
      isVisible: true,
    ),
    SectionConfig(
      id: 'holidays',
      title: 'Nächste Ferien',
      icon: Icons.beach_access,
      isVisible: true,
    ),
    SectionConfig(
      id: 'grades',
      title: 'Letzte Noten',
      icon: Icons.grade,
      isVisible: true,
    ),
    SectionConfig(
      id: 'absences',
      title: 'Offene Absenzen',
      icon: Icons.list_alt,
      isVisible: true,
    ),
  ];

  bool _isLoaded = false;

  HomepageConfigProvider() {
    _load();
  }

  List<SectionConfig> get sections => List.unmodifiable(_sections);
  bool get showBreaks => _showBreaks;

  bool get isLoaded => _isLoaded;

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = _sections.removeAt(oldIndex);
    _sections.insert(newIndex, item);
    _save();
    notifyListeners();
  }

  void toggleVisibility(String id) {
    final idx = _sections.indexWhere((s) => s.id == id);
    if (idx != -1) {
      _sections[idx].isVisible = !_sections[idx].isVisible;
      _save();
      notifyListeners();
    }
  }

  void toggleShowBreaks() {
    _showBreaks = !_showBreaks;
    _save();
    notifyListeners();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = _sections.map((s) => s.toJson()).toList();
      await prefs.setString('homepage_sections', jsonEncode(jsonList));
      await prefs.setBool('homepage_show_breaks', _showBreaks);
    } catch (e) {
      print('Error saving homepage config: $e');
    }
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('homepage_sections');
      if (jsonString != null) {
        final List decoded = jsonDecode(jsonString);
        _sections = decoded.map((e) => SectionConfig.fromJson(e)).toList();
      }
      _showBreaks = prefs.getBool('homepage_show_breaks') ?? true;
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      print('Error loading homepage config: $e');
      _isLoaded = true;
      notifyListeners();
    }
  }
}
