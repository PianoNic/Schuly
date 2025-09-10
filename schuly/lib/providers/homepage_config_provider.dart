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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon.codePoint,
      'isVisible': isVisible,
    };
  }

  static SectionConfig fromJson(Map<String, dynamic> json) {
    return SectionConfig(
      id: json['id'],
      title: json['title'],
      icon: IconData(
        json['icon'],
        fontFamily: 'MaterialIcons',
      ),
      isVisible: json['isVisible'],
    );
  }
}

class HomepageConfigProvider extends ChangeNotifier {
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

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = _sections.map((s) => s.toJson()).toList();
      await prefs.setString('homepage_sections', jsonEncode(jsonList));
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
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      print('Error loading homepage config: $e');
      _isLoaded = true;
      notifyListeners();
    }
  }
}
