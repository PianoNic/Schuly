// Maggus MaterialLocalizations for 'mag' locale
// This file provides Material widget localizations for the custom 'mag' (Maggus/Markus Rühl) locale.
// Register the delegate in your MaterialApp to enable full Maggus localization for Material widgets.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

/// MaggusMaterialLocalizations provides Material widget localizations for the 'mag' locale.
class MaggusMaterialLocalizations extends GlobalMaterialLocalizations {
  const MaggusMaterialLocalizations({super.localeName = 'mag', required super.fullYearFormat, required super.compactDateFormat, required super.shortDateFormat, required super.mediumDateFormat, required super.longDateFormat, required super.yearMonthFormat, required super.shortMonthDayFormat, required super.decimalFormat, required super.twoDigitZeroPaddedFormat});

  static const LocalizationsDelegate<MaterialLocalizations> delegate = _MaggusMaterialLocalizationsDelegate();

  @override
  String get okButtonLabel => 'OK, des bedarfs!';
  @override
  String get cancelButtonLabel => 'Abbräche';
  @override
  String get closeButtonLabel => 'Zumache';
  @override
  String get continueButtonLabel => 'Weiter, bruddal!';
  @override
  String get deleteButtonTooltip => 'Lösche';
  @override
  String get saveButtonLabel => 'Speichere';
  @override
  String get copyButtonLabel => 'Kopiere';
  @override
  String get pasteButtonLabel => 'Einfüge';
  @override
  String get cutButtonLabel => 'Ausschneide';
  @override
  String get selectAllButtonLabel => 'Alles auswähle';
  @override
  String get searchFieldLabel => "Suche, des isses";

  @override
  String get aboutListTileTitleRaw => "Über des Programm";
  @override
  String get alertDialogLabel => 'Warnung, bruddal';

  @override
  String get anteMeridiemAbbreviation => 'Morge';

  @override
  String get backButtonTooltip => 'Zurück';

  @override
  String get bottomSheetLabel => "Bottom Sheet";

  @override
  String get calendarModeButtonLabel => 'Zum Kalender wechsle';

  @override
  String get clearButtonTooltip => 'Leere';

  @override
  String get closeButtonTooltip => 'Schließe';

  @override
  String get collapsedHint => 'Erweitere';

  @override
  String get collapsedIconTapHint => 'Tippe zum Erweitere';

  @override
  String get currentDateLabel => 'Heute';

  @override
  String get dateHelpText => 'Datum eingebe';

  @override
  String get dateInputLabel => 'Datum eingebe';

  @override
  String get dateOutOfRangeLabel => 'Datum außerhalb des Bereichs';

  @override
  String get datePickerHelpText => 'Datum wähle, des bedarfs';

  @override
  String get dateRangeEndDateSemanticLabelRaw => r'Enddatum $fullDate';

  @override
  String get dateRangeEndLabel => 'Enddatum';

  @override
  String get dateRangePickerHelpText => 'Bereich wähle';

  @override
  String get dateRangeStartDateSemanticLabelRaw => r'Startdatum $fullDate';

  @override
  String get dateRangeStartLabel => 'Startdatum';

  @override
  String get dateSeparator => '/';

  @override
  String get dialModeButtonLabel => 'Zur Uhrenauswahl wechsle';

  @override
  String get dialogLabel => "Dialog";

  @override
  String get drawerLabel => "Navigationsmenü";

  @override
  String get expandedHint => 'Einklappe';

  @override
  String get expandedIconTapHint => 'Tippe zum Einklappe';

  @override
  String get expansionTileCollapsedHint => 'Tippe zum Erweitere';

  @override
  String get expansionTileCollapsedTapHint => 'Erweitere fer mehr Details';

  @override
  String get expansionTileExpandedHint => 'Tippe zum Einklappe';

  @override
  String get expansionTileExpandedTapHint => 'Einklappe';

  @override
  String get firstPageTooltip => 'Erste Seite';

  @override
  String get hideAccountsLabel => 'Accounts verstecke';

  @override
  String get inputDateModeButtonLabel => 'Zur Eingabe wechsle';

  @override
  String get inputTimeModeButtonLabel => 'Zur Texteingabe wechsle';

  @override
  String get invalidDateFormatLabel => 'Ungültiges Format';

  @override
  String get invalidDateRangeLabel => 'Ungültiger Bereich';

  @override
  String get invalidTimeLabel => 'Gültige Zeit eingebe';

  @override
  String get keyboardKeyAlt => 'Alt';

  @override
  String get keyboardKeyAltGraph => 'AltGr';

  @override
  String get keyboardKeyBackspace => 'Rücktaste';

  @override
  String get keyboardKeyCapsLock => 'Feststelltaste';

  @override
  String get keyboardKeyChannelDown => 'Kanal runter';

  @override
  String get keyboardKeyChannelUp => 'Kanal hoch';

  @override
  String get keyboardKeyControl => 'Strg';

  @override
  String get keyboardKeyDelete => 'Entf';

  @override
  String get keyboardKeyEject => 'Auswerfe';

  @override
  String get keyboardKeyEnd => 'Ende';

  @override
  String get keyboardKeyEscape => 'Esc';

  @override
  String get keyboardKeyFn => 'Fn';

  @override
  String get keyboardKeyHome => 'Pos1';

  @override
  String get keyboardKeyInsert => 'Einfg';

  @override
  String get keyboardKeyMeta => 'Meta';

  @override
  String get keyboardKeyMetaMacOs => 'Cmd';

  @override
  String get keyboardKeyMetaWindows => 'Win';

  @override
  String get keyboardKeyNumLock => 'Num';

  @override
  String get keyboardKeyNumpad0 => 'Num 0';

  @override
  String get keyboardKeyNumpad1 => 'Num 1';

  @override
  String get keyboardKeyNumpad2 => 'Num 2';

  @override
  String get keyboardKeyNumpad3 => 'Num 3';

  @override
  String get keyboardKeyNumpad4 => 'Num 4';

  @override
  String get keyboardKeyNumpad5 => 'Num 5';

  @override
  String get keyboardKeyNumpad6 => 'Num 6';

  @override
  String get keyboardKeyNumpad7 => 'Num 7';

  @override
  String get keyboardKeyNumpad8 => 'Num 8';

  @override
  String get keyboardKeyNumpad9 => 'Num 9';

  @override
  String get keyboardKeyNumpadAdd => 'Num +';

  @override
  String get keyboardKeyNumpadComma => 'Num ,';

  @override
  String get keyboardKeyNumpadDecimal => 'Num .';

  @override
  String get keyboardKeyNumpadDivide => 'Num /';

  @override
  String get keyboardKeyNumpadEnter => 'Num Enter';

  @override
  String get keyboardKeyNumpadEqual => 'Num =';

  @override
  String get keyboardKeyNumpadMultiply => 'Num *';

  @override
  String get keyboardKeyNumpadParenLeft => 'Num (';

  @override
  String get keyboardKeyNumpadParenRight => 'Num )';

  @override
  String get keyboardKeyNumpadSubtract => 'Num -';

  @override
  String get keyboardKeyPageDown => 'Bild ab';

  @override
  String get keyboardKeyPageUp => 'Bild auf';

  @override
  String get keyboardKeyPower => 'Power';

  @override
  String get keyboardKeyPowerOff => 'Ausschalte';

  @override
  String get keyboardKeyPrintScreen => 'Druck';

  @override
  String get keyboardKeyScrollLock => 'Rollen';

  @override
  String get keyboardKeySelect => 'Auswähle';

  @override
  String get keyboardKeyShift => 'Umschalt';

  @override
  String get keyboardKeySpace => 'Leertaste';

  @override
  String get lastPageTooltip => 'Letzte Seite';

  @override
  String get licensesPackageDetailTextOther => r'$licenseCount Lizenze';

  @override
  String get licensesPageTitle => "Lizenze";

  @override
  String get lookUpButtonLabel => 'Nachschlage';

  @override
  String get menuBarMenuLabel => 'Menüleiste';

  @override
  String get menuDismissLabel => 'Menü schließe';

  @override
  String get modalBarrierDismissLabel => 'Schließe';

  @override
  String get moreButtonTooltip => 'Mehr';

  @override
  String get nextMonthTooltip => 'Nächster Monat';

  @override
  String get nextPageTooltip => 'Nächste Seite';

  @override
  String get openAppDrawerTooltip => "Navigationsmenü öffne";

  @override
  String get pageRowsInfoTitleApproximateRaw => r'$firstRow–$lastRow von ungefähr $rowCount';

  @override
  String get pageRowsInfoTitleRaw => r'$firstRow–$lastRow von $rowCount';

  @override
  String get popupMenuLabel => 'Popup-Menü';

  @override
  String get postMeridiemAbbreviation => 'Nachmittag';

  @override
  String get previousMonthTooltip => 'Vorheriger Monat';

  @override
  String get previousPageTooltip => 'Vorherige Seite';

  @override
  String get refreshIndicatorSemanticLabel => "Aktualisiere";

  @override
  String get remainingTextFieldCharacterCountOther => r'Noch $remainingCount Zeiche';

  @override
  String get reorderItemDown => 'Nach unte verschiebe';

  @override
  String get reorderItemLeft => 'Nach links verschiebe';

  @override
  String get reorderItemRight => 'Nach rechts verschiebe';

  @override
  String get reorderItemToEnd => 'Ans Ende verschiebe';

  @override
  String get reorderItemToStart => 'An de Anfang verschiebe';

  @override
  String get reorderItemUp => 'Nach obe verschiebe';

  @override
  String get rowsPerPageTitle => 'Zeile pro Seite:';

  @override
  String get scrimLabel => "Scrim";

  @override
  String get scrimOnTapHintRaw => "Schließe";

  @override
  ScriptCategory get scriptCategory => ScriptCategory.englishLike;

  @override
  String get selectYearSemanticsLabel => 'Jahr wähle';

  @override
  String get selectedDateLabel => 'Ausgewähltes Datum';

  @override
  String get selectedRowCountTitleOther => r'$selectedRowCount Elemente ausgewählt';

  @override
  String get showAccountsLabel => 'Accounts zeige';

  @override
  String get showMenuTooltip => 'Menü zeige';

  @override
  String get signedInLabel => 'Angemeldet';

  @override
  String get tabLabelRaw => r'Tab $tabIndex von $tabCount';

  @override
  TimeOfDayFormat get timeOfDayFormatRaw => TimeOfDayFormat.HH_colon_mm;

  @override
  String get timePickerDialHelpText => 'ZEIT WÄHLE';

  @override
  String get timePickerHourLabel => 'Stund';

  @override
  String get timePickerHourModeAnnouncement => 'Stunde wähle';

  @override
  String get timePickerInputHelpText => 'ZEIT EINGEBE';

  @override
  String get timePickerMinuteLabel => 'Minute';

  @override
  String get timePickerMinuteModeAnnouncement => 'Minute wähle';

  @override
  String get unspecifiedDate => 'Datum';

  @override
  String get unspecifiedDateRange => 'Datumsbereich';

  @override
  String get viewLicensesButtonLabel => 'LIZENZE ANZEIGE';

  @override
  String get scanTextButtonLabel => 'Text scanne';

  @override
  String get searchWebButtonLabel => 'Im Web suche';

  @override
  String get shareButtonLabel => 'Teile, bruddal!';
}

class _MaggusMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const _MaggusMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'mag';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    // Use German locale for date/number formatting
    const String localeName = 'de';
    return MaggusMaterialLocalizations(
      fullYearFormat: DateFormat.y(localeName),
      compactDateFormat: DateFormat.yMd(localeName),
      shortDateFormat: DateFormat.yMd(localeName),
      mediumDateFormat: DateFormat.yMMMd(localeName),
      longDateFormat: DateFormat.yMMMMEEEEd(localeName),
      yearMonthFormat: DateFormat.yMMMM(localeName),
      shortMonthDayFormat: DateFormat.MMMd(localeName),
      decimalFormat: NumberFormat.decimalPattern(localeName),
      twoDigitZeroPaddedFormat: NumberFormat('00', localeName),
    );
  }

  @override
  bool shouldReload(_MaggusMaterialLocalizationsDelegate old) => false;
}