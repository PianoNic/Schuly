// Arnold/Terminator MaterialLocalizations for 'arn' locale
// This file provides localization for the custom 'arn' locale with Arnold Schwarzenegger/Terminator theme.
// Register the delegate in your MaterialApp to enable full localization for Material widgets.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

/// ArnMaterialLocalizations provides Material widget localizations for the 'arn' locale.
class ArnMaterialLocalizations extends GlobalMaterialLocalizations {
  const ArnMaterialLocalizations({super.localeName = 'arn', required super.fullYearFormat, required super.compactDateFormat, required super.shortDateFormat, required super.mediumDateFormat, required super.longDateFormat, required super.yearMonthFormat, required super.shortMonthDayFormat, required super.decimalFormat, required super.twoDigitZeroPaddedFormat});

  static const LocalizationsDelegate<MaterialLocalizations> delegate = _ArnMaterialLocalizationsDelegate();

  @override
  String get okButtonLabel => 'Hasta la vista!';
  @override
  String get cancelButtonLabel => 'Terminate';
  @override
  String get closeButtonLabel => "I'll be back";
  @override
  String get continueButtonLabel => 'Come with me!';
  @override
  String get deleteButtonTooltip => 'Terminate';
  @override
  String get saveButtonLabel => 'Save the future';
  @override
  String get copyButtonLabel => 'Copy';
  @override
  String get pasteButtonLabel => 'Paste';
  @override
  String get cutButtonLabel => 'Cut';
  @override
  String get selectAllButtonLabel => 'Select all targets';
  @override
  String get searchFieldLabel => "Scan for targets";

  @override
  String get aboutListTileTitleRaw => "Mission briefing";
  @override
  String get alertDialogLabel => 'Alert';

  @override
  String get anteMeridiemAbbreviation => 'AM';

  @override
  String get backButtonTooltip => 'Get to the choppa!';

  @override
  String get bottomSheetLabel => "Bottom sheet";

  @override
  String get calendarModeButtonLabel => 'Switch to calendar';

  @override
  String get clearButtonTooltip => 'Clear';

  @override
  String get closeButtonTooltip => "I'll be back";

  @override
  String get collapsedHint => 'Expand';

  @override
  String get collapsedIconTapHint => 'Tap to expand';

  @override
  String get currentDateLabel => 'Today';

  @override
  String get dateHelpText => 'mm/dd/yyyy';

  @override
  String get dateInputLabel => 'Enter date';

  @override
  String get dateOutOfRangeLabel => 'Out of range';

  @override
  String get datePickerHelpText => 'Select date';

  @override
  String get dateRangeEndDateSemanticLabelRaw => r'End date $fullDate';

  @override
  String get dateRangeEndLabel => 'End date';

  @override
  String get dateRangePickerHelpText => 'Select range';

  @override
  String get dateRangeStartDateSemanticLabelRaw => r'Start date $fullDate';

  @override
  String get dateRangeStartLabel => 'Start date';

  @override
  String get dateSeparator => '/';

  @override
  String get dialModeButtonLabel => 'Switch to dial picker mode';

  @override
  String get dialogLabel => "Dialog";

  @override
  String get drawerLabel => "Navigation menu";

  @override
  String get expandedHint => 'Collapse';

  @override
  String get expandedIconTapHint => 'Tap to collapse';

  @override
  String get expansionTileCollapsedHint => 'Tap to expand';

  @override
  String get expansionTileCollapsedTapHint => 'Expand for more details';

  @override
  String get expansionTileExpandedHint => 'Tap to collapse';

  @override
  String get expansionTileExpandedTapHint => 'Collapse';

  @override
  String get firstPageTooltip => 'First page';

  @override
  String get hideAccountsLabel => 'Hide accounts';

  @override
  String get inputDateModeButtonLabel => 'Switch to input';

  @override
  String get inputTimeModeButtonLabel => 'Switch to text input mode';

  @override
  String get invalidDateFormatLabel => 'Invalid format';

  @override
  String get invalidDateRangeLabel => 'Invalid range';

  @override
  String get invalidTimeLabel => 'Enter a valid time';

  @override
  String get keyboardKeyAlt => 'Alt';

  @override
  String get keyboardKeyAltGraph => 'AltGr';

  @override
  String get keyboardKeyBackspace => 'Backspace';

  @override
  String get keyboardKeyCapsLock => 'Caps Lock';

  @override
  String get keyboardKeyChannelDown => 'Channel Down';

  @override
  String get keyboardKeyChannelUp => 'Channel Up';

  @override
  String get keyboardKeyControl => 'Ctrl';

  @override
  String get keyboardKeyDelete => 'Delete';

  @override
  String get keyboardKeyEject => 'Eject';

  @override
  String get keyboardKeyEnd => 'End';

  @override
  String get keyboardKeyEscape => 'Escape';

  @override
  String get keyboardKeyFn => 'Fn';

  @override
  String get keyboardKeyHome => 'Home';

  @override
  String get keyboardKeyInsert => 'Insert';

  @override
  String get keyboardKeyMeta => 'Meta';

  @override
  String get keyboardKeyMetaMacOs => 'Command';

  @override
  String get keyboardKeyMetaWindows => 'Win';

  @override
  String get keyboardKeyNumLock => 'Num Lock';

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
  String get keyboardKeyPageDown => 'PgDown';

  @override
  String get keyboardKeyPageUp => 'PgUp';

  @override
  String get keyboardKeyPower => 'Power';

  @override
  String get keyboardKeyPowerOff => 'Power Off';

  @override
  String get keyboardKeyPrintScreen => 'Print Screen';

  @override
  String get keyboardKeyScrollLock => 'Scroll Lock';

  @override
  String get keyboardKeySelect => 'Select';

  @override
  String get keyboardKeyShift => 'Shift';

  @override
  String get keyboardKeySpace => 'Space';

  @override
  String get lastPageTooltip => 'Last page';

  @override
  String get licensesPackageDetailTextOther => r'$licenseCount licenses';

  @override
  String get licensesPageTitle => "Licenses";

  @override
  String get lookUpButtonLabel => 'Look up';

  @override
  String get menuBarMenuLabel => 'Menu bar menu';

  @override
  String get menuDismissLabel => 'Dismiss menu';

  @override
  String get modalBarrierDismissLabel => 'Dismiss';

  @override
  String get moreButtonTooltip => 'More';

  @override
  String get nextMonthTooltip => 'Next month';

  @override
  String get nextPageTooltip => 'Next page';

  @override
  String get openAppDrawerTooltip => "Open navigation menu";

  @override
  String get pageRowsInfoTitleApproximateRaw => r'$firstRow–$lastRow of approximately $rowCount';

  @override
  String get pageRowsInfoTitleRaw => r'$firstRow–$lastRow of $rowCount';

  @override
  String get popupMenuLabel => 'Popup menu';

  @override
  String get postMeridiemAbbreviation => 'PM';

  @override
  String get previousMonthTooltip => 'Previous month';

  @override
  String get previousPageTooltip => 'Previous page';

  @override
  String get refreshIndicatorSemanticLabel => "Refresh";

  @override
  String get remainingTextFieldCharacterCountOther => r'$remainingCount characters remaining';

  @override
  String get reorderItemDown => 'Move down';

  @override
  String get reorderItemLeft => 'Move left';

  @override
  String get reorderItemRight => 'Move right';

  @override
  String get reorderItemToEnd => 'Move to the end';

  @override
  String get reorderItemToStart => 'Move to the start';

  @override
  String get reorderItemUp => 'Move up';

  @override
  String get rowsPerPageTitle => 'Rows per page:';

  @override
  String get scrimLabel => "Scrim";

  @override
  String get scrimOnTapHintRaw => "Dismiss";

  @override
  ScriptCategory get scriptCategory => ScriptCategory.englishLike;

  @override
  String get selectYearSemanticsLabel => 'Select year';

  @override
  String get selectedDateLabel => 'Selected date';

  @override
  String get selectedRowCountTitleOther => r'$selectedRowCount items selected';

  @override
  String get showAccountsLabel => 'Show accounts';

  @override
  String get showMenuTooltip => 'Show menu';

  @override
  String get signedInLabel => 'Signed in';

  @override
  String get tabLabelRaw => r'Tab $tabIndex of $tabCount';

  @override
  TimeOfDayFormat get timeOfDayFormatRaw => TimeOfDayFormat.h_colon_mm_space_a;

  @override
  String get timePickerDialHelpText => 'SELECT TIME';

  @override
  String get timePickerHourLabel => 'Hour';

  @override
  String get timePickerHourModeAnnouncement => 'Select hours';

  @override
  String get timePickerInputHelpText => 'ENTER TIME';

  @override
  String get timePickerMinuteLabel => 'Minute';

  @override
  String get timePickerMinuteModeAnnouncement => 'Select minutes';

  @override
  String get unspecifiedDate => 'Date';

  @override
  String get unspecifiedDateRange => 'Date range';

  @override
  String get viewLicensesButtonLabel => 'VIEW LICENSES';

  @override
  String get scanTextButtonLabel => 'Scan text';

  @override
  String get searchWebButtonLabel => 'Search web';

  @override
  String get shareButtonLabel => 'Share';
}

class _ArnMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const _ArnMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'arn';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return ArnMaterialLocalizations(
      fullYearFormat: DateFormat.y(),
      compactDateFormat: DateFormat.yMd(),
      shortDateFormat: DateFormat.yMd(),
      mediumDateFormat: DateFormat.yMMMd(),
      longDateFormat: DateFormat.yMMMMEEEEd(),
      yearMonthFormat: DateFormat.yMMMM(),
      shortMonthDayFormat: DateFormat.MMMd(),
      decimalFormat: NumberFormat.decimalPattern(),
      twoDigitZeroPaddedFormat: NumberFormat('00'),
    );
  }

  @override
  bool shouldReload(_ArnMaterialLocalizationsDelegate old) => false;
}