import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en'); // Default to English

  Locale get locale => _locale;

  LanguageProvider() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final languageCode = await StorageService.getLanguage();
    if (languageCode != null) {
      _locale = _createLocaleFromCode(languageCode);
      notifyListeners();
    }
  }

  Future<void> setLanguage(String languageCode) async {
    _locale = _createLocaleFromCode(languageCode);
    await StorageService.setLanguage(languageCode);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await StorageService.setLanguage(locale.languageCode);
    notifyListeners();
  }

  Locale _createLocaleFromCode(String languageCode) {
    switch (languageCode) {
      case 'en':
        return const Locale('en');
      case 'de':
        return const Locale('de');
      case 'gsw':
        return const Locale('gsw');
      case 'arr':
        return const Locale('arr');
      case 'kaw':
        return const Locale('kaw');
      default:
        return const Locale('en'); // Default to English
    }
  }
}