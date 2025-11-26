// Kawaii CupertinoLocalizations for 'kaw' locale
// This file provides Cupertino widget localizations for the custom 'kaw' (kawaii) locale.

import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

/// KawaiiCupertinoLocalizations provides Cupertino widget localizations for the 'kaw' (kawaii) locale.
class KawaiiCupertinoLocalizations extends GlobalCupertinoLocalizations {
  const KawaiiCupertinoLocalizations({
    super.localeName = 'kaw',
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

  static const LocalizationsDelegate<CupertinoLocalizations> delegate = _KawaiiCupertinoLocalizationsDelegate();

  @override
  String get alertDialogLabel => 'Impowtant notice';

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
  String get selectAllButtonLabel => 'Sewect aww';

  @override
  String get searchTextFieldPlaceholderLabel => 'Seawch';

  @override
  String get modalBarrierDismissLabel => 'Dismiss';

  @override
  String get backButtonLabel => 'Back';

  @override
  String get cancelButtonLabel => 'Cancew';

  @override
  String get tabSemanticsLabelRaw => r'Tab $tabIndex of $tabCount';

  @override
  String get timerPickerHourLabelFew => 'houws';

  @override
  String get timerPickerHourLabelMany => 'houws';

  @override
  String get timerPickerHourLabelOne => 'houw';

  @override
  String get timerPickerHourLabelOther => 'houws';

  @override
  String get timerPickerHourLabelTwo => 'houws';

  @override
  String get timerPickerHourLabelZero => 'houws';

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
  String get datePickerHourSemanticsLabelFew => r'$hour owclock';

  @override
  String get datePickerHourSemanticsLabelMany => r'$hour owclock';

  @override
  String get datePickerHourSemanticsLabelOne => r'$hour owclock';

  @override
  String get datePickerHourSemanticsLabelOther => r'$hour owclock';

  @override
  String get datePickerHourSemanticsLabelTwo => r'$hour owclock';

  @override
  String get datePickerHourSemanticsLabelZero => r'$hour owclock';

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
  String get searchWebButtonLabel => 'Seawch Web';

  @override
  String get shareButtonLabel => 'Shawe...';

  @override
  String get clearButtonLabel => 'Cleaw';

  @override
  String get noSpellCheckReplacementsLabel => 'No Wepwacements Found';

  @override
  String get collapsedHint => 'Doubwe tap to expwand';

  @override
  String get expandedHint => 'Doubwe tap to cowwapse';

  @override
  String get expansionTileCollapsedHint => 'Doubwe tap to expwand';

  @override
  String get expansionTileCollapsedTapHint => 'Doubwe tap to expwand';

  @override
  String get expansionTileExpandedHint => 'Doubwe tap to cowwapse';

  @override
  String get expansionTileExpandedTapHint => 'Doubwe tap to cowwapse';
}

class _KawaiiCupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const _KawaiiCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'kaw';

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    // Use 'en' as fallback for date/number formatting since 'kaw' is not a recognized locale
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

    return KawaiiCupertinoLocalizations(
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
  bool shouldReload(_KawaiiCupertinoLocalizationsDelegate old) => false;
}