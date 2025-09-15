// Pirate CupertinoLocalizations for 'arr' locale
// This file provides Cupertino widget localizations for the custom 'arr' (pirate) locale.

import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

/// PirateCupertinoLocalizations provides Cupertino widget localizations for the 'arr' (pirate) locale.
class PirateCupertinoLocalizations extends GlobalCupertinoLocalizations {
  const PirateCupertinoLocalizations({
    super.localeName = 'arr',
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

  static const LocalizationsDelegate<CupertinoLocalizations> delegate = _PirateCupertinoLocalizationsDelegate();

  @override
  String get alertDialogLabel => 'Ahoy! Important message';

  @override
  String get anteMeridiemAbbreviation => 'AM';

  @override
  String get postMeridiemAbbreviation => 'PM';

  @override
  String get copyButtonLabel => 'Copy';

  @override
  String get cutButtonLabel => 'Cut';

  @override
  String get pasteButtonLabel => 'Paste';

  @override
  String get selectAllButtonLabel => 'Select all, ye scallywag';

  @override
  String get searchTextFieldPlaceholderLabel => 'Search fer treasure';

  @override
  String get modalBarrierDismissLabel => 'Dismiss';

  @override
  String get backButtonLabel => 'Back';

  @override
  String get cancelButtonLabel => 'Belay that';

  @override
  String get tabSemanticsLabelRaw => r'Tab $tabIndex of $tabCount';

  @override
  String get timerPickerHourLabelFew => 'hours';

  @override
  String get timerPickerHourLabelMany => 'hours';

  @override
  String get timerPickerHourLabelOne => 'hour';

  @override
  String get timerPickerHourLabelOther => 'hours';

  @override
  String get timerPickerHourLabelTwo => 'hours';

  @override
  String get timerPickerHourLabelZero => 'hours';

  @override
  String get timerPickerMinuteLabelFew => 'min';

  @override
  String get timerPickerMinuteLabelMany => 'min';

  @override
  String get timerPickerMinuteLabelOne => 'min';

  @override
  String get timerPickerMinuteLabelOther => 'min';

  @override
  String get timerPickerMinuteLabelTwo => 'min';

  @override
  String get timerPickerMinuteLabelZero => 'min';

  @override
  String get timerPickerSecondLabelFew => 'sec';

  @override
  String get timerPickerSecondLabelMany => 'sec';

  @override
  String get timerPickerSecondLabelOne => 'sec';

  @override
  String get timerPickerSecondLabelOther => 'sec';

  @override
  String get timerPickerSecondLabelTwo => 'sec';

  @override
  String get timerPickerSecondLabelZero => 'sec';

  @override
  String get datePickerHourSemanticsLabelFew => r"$hour o'clock";

  @override
  String get datePickerHourSemanticsLabelMany => r"$hour o'clock";

  @override
  String get datePickerHourSemanticsLabelOne => r"$hour o'clock";

  @override
  String get datePickerHourSemanticsLabelOther => r"$hour o'clock";

  @override
  String get datePickerHourSemanticsLabelTwo => r"$hour o'clock";

  @override
  String get datePickerHourSemanticsLabelZero => r"$hour o'clock";

  @override
  String get datePickerMinuteSemanticsLabelFew => r'$minute minutes';

  @override
  String get datePickerMinuteSemanticsLabelMany => r'$minute minutes';

  @override
  String get datePickerMinuteSemanticsLabelOne => r'$minute minute';

  @override
  String get datePickerMinuteSemanticsLabelOther => r'$minute minutes';

  @override
  String get datePickerMinuteSemanticsLabelTwo => r'$minute minutes';

  @override
  String get datePickerMinuteSemanticsLabelZero => r'$minute minutes';

  @override
  String get datePickerDateOrderString => 'mdy';

  @override
  String get datePickerDateTimeOrderString => 'date_time_dayPeriod';

  @override
  String get todayLabel => 'Today';

  @override
  String get lookUpButtonLabel => 'Look Up';

  @override
  String get menuDismissLabel => 'Dismiss menu';

  @override
  String get searchWebButtonLabel => 'Search the Seven Seas';

  @override
  String get shareButtonLabel => 'Share the booty...';

  @override
  String get clearButtonLabel => 'Clear';

  @override
  String get noSpellCheckReplacementsLabel => 'No Replacements Found';
}

class _PirateCupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const _PirateCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'arr';

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    // Use 'en' as fallback for date/number formatting since 'arr' is not a recognized locale
    const String fallbackLocaleName = 'en';
    final DateFormat fullYearFormat = DateFormat.y(fallbackLocaleName);
    final DateFormat dayFormat = DateFormat.d(fallbackLocaleName);
    final DateFormat mediumDateFormat = DateFormat.MMMEd(fallbackLocaleName);
    final DateFormat weekdayFormat = DateFormat.EEEE(fallbackLocaleName);
    final DateFormat singleDigitHourFormat = DateFormat('HH', fallbackLocaleName);
    final DateFormat singleDigitMinuteFormat = DateFormat.m(fallbackLocaleName);
    final DateFormat doubleDigitMinuteFormat = DateFormat('mm', fallbackLocaleName);
    final DateFormat singleDigitSecondFormat = DateFormat.s(fallbackLocaleName);
    final NumberFormat decimalFormat = NumberFormat.decimalPattern(fallbackLocaleName);

    return PirateCupertinoLocalizations(
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
  bool shouldReload(_PirateCupertinoLocalizationsDelegate old) => false;
}