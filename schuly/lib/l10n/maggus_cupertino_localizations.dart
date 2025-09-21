// Maggus CupertinoLocalizations for 'mag' locale
// This file provides Cupertino widget localizations for the custom 'mag' (Maggus/Markus Rühl) locale.

import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

/// MaggusCupertinoLocalizations provides Cupertino widget localizations for the 'mag' locale.
class MaggusCupertinoLocalizations extends GlobalCupertinoLocalizations {
  const MaggusCupertinoLocalizations({
    super.localeName = 'mag',
    required super.fullYearFormat,
    required super.dayFormat,
    required super.mediumDateFormat,
    required super.weekdayFormat,
    required super.singleDigitHourFormat,
    required super.singleDigitMinuteFormat,
    required super.doubleDigitMinuteFormat,
    required super.singleDigitSecondFormat,
    required super.decimalFormat,
  }) : super();

  static const LocalizationsDelegate<CupertinoLocalizations> delegate = _MaggusCupertinoLocalizationsDelegate();

  @override
  String get alertDialogLabel => 'Warnung, bruddal';

  @override
  String get anteMeridiemAbbreviation => 'vorm.';

  @override
  String get postMeridiemAbbreviation => 'nachm.';

  @override
  String get copyButtonLabel => 'Kopiere';

  @override
  String get cutButtonLabel => 'Ausschneide';

  @override
  String get pasteButtonLabel => 'Einfüge';

  @override
  String get selectAllButtonLabel => 'Alles auswähle';

  @override
  String get searchTextFieldPlaceholderLabel => 'Suche, des bedarfs';

  @override
  String get modalBarrierDismissLabel => 'Schließe';

  @override
  String get backButtonLabel => 'Zurück';

  @override
  String get cancelButtonLabel => 'Abbräche';

  @override
  String get tabSemanticsLabelRaw => r'Tab $tabIndex von $tabCount';

  @override
  String get timerPickerHourLabelFew => 'Stunde';

  @override
  String get timerPickerHourLabelMany => 'Stunde';

  @override
  String get timerPickerHourLabelOne => 'Stund';

  @override
  String get timerPickerHourLabelOther => 'Stunde';

  @override
  String get timerPickerHourLabelTwo => 'Stunde';

  @override
  String get timerPickerHourLabelZero => 'Stunde';

  @override
  String get timerPickerMinuteLabelFew => 'Min.';

  @override
  String get timerPickerMinuteLabelMany => 'Min.';

  @override
  String get timerPickerMinuteLabelOne => 'Min.';

  @override
  String get timerPickerMinuteLabelOther => 'Min.';

  @override
  String get timerPickerMinuteLabelTwo => 'Min.';

  @override
  String get timerPickerMinuteLabelZero => 'Min.';

  @override
  String get timerPickerSecondLabelFew => 'Sek.';

  @override
  String get timerPickerSecondLabelMany => 'Sek.';

  @override
  String get timerPickerSecondLabelOne => 'Sek.';

  @override
  String get timerPickerSecondLabelOther => 'Sek.';

  @override
  String get timerPickerSecondLabelTwo => 'Sek.';

  @override
  String get timerPickerSecondLabelZero => 'Sek.';

  @override
  String get datePickerHourSemanticsLabelFew => r'$hour Uhr';

  @override
  String get datePickerHourSemanticsLabelMany => r'$hour Uhr';

  @override
  String get datePickerHourSemanticsLabelOne => r'$hour Uhr';

  @override
  String get datePickerHourSemanticsLabelOther => r'$hour Uhr';

  @override
  String get datePickerHourSemanticsLabelTwo => r'$hour Uhr';

  @override
  String get datePickerHourSemanticsLabelZero => r'$hour Uhr';

  @override
  String get datePickerMinuteSemanticsLabelFew => r'$minute Minute';

  @override
  String get datePickerMinuteSemanticsLabelMany => r'$minute Minute';

  @override
  String get datePickerMinuteSemanticsLabelOne => r'$minute Minute';

  @override
  String get datePickerMinuteSemanticsLabelOther => r'$minute Minute';

  @override
  String get datePickerMinuteSemanticsLabelTwo => r'$minute Minute';

  @override
  String get datePickerMinuteSemanticsLabelZero => r'$minute Minute';

  @override
  String get datePickerDateOrderString => 'dmy';

  @override
  String get datePickerDateTimeOrderString => 'date_time_dayPeriod';

  @override
  String get todayLabel => 'Heute';

  @override
  String get lookUpButtonLabel => 'Nachschlage';

  @override
  String get menuDismissLabel => 'Menü schließe';

  @override
  String get searchWebButtonLabel => 'Im Web suche';

  @override
  String get shareButtonLabel => 'Teile...';

  @override
  String get clearButtonLabel => 'Leere';

  @override
  String get noSpellCheckReplacementsLabel => 'Keine Ersetzunge gefunde';
}

class _MaggusCupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const _MaggusCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'mag';

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    // Use 'de' as fallback for date/number formatting since 'mag' is not a recognized locale
    const String fallbackLocaleName = 'de';
    final DateFormat fullYearFormat = DateFormat.y(fallbackLocaleName);
    final DateFormat dayFormat = DateFormat.d(fallbackLocaleName);
    final DateFormat mediumDateFormat = DateFormat.MMMEd(fallbackLocaleName);
    final DateFormat weekdayFormat = DateFormat.EEEE(fallbackLocaleName);
    final DateFormat singleDigitHourFormat = DateFormat('HH', fallbackLocaleName);
    final DateFormat singleDigitMinuteFormat = DateFormat.m(fallbackLocaleName);
    final DateFormat doubleDigitMinuteFormat = DateFormat('mm', fallbackLocaleName);
    final DateFormat singleDigitSecondFormat = DateFormat.s(fallbackLocaleName);
    final NumberFormat decimalFormat = NumberFormat.decimalPattern(fallbackLocaleName);

    return MaggusCupertinoLocalizations(
      fullYearFormat: fullYearFormat,
      dayFormat: dayFormat,
      mediumDateFormat: mediumDateFormat,
      weekdayFormat: weekdayFormat,
      singleDigitHourFormat: singleDigitHourFormat,
      singleDigitMinuteFormat: singleDigitMinuteFormat,
      doubleDigitMinuteFormat: doubleDigitMinuteFormat,
      singleDigitSecondFormat: singleDigitSecondFormat,
      decimalFormat: decimalFormat,
    );
  }

  @override
  bool shouldReload(_MaggusCupertinoLocalizationsDelegate old) => false;
}