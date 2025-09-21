import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_arr.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_gsw.dart';
import 'app_localizations_kaw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('arr'),
    Locale('de'),
    Locale('en'),
    Locale('gsw'),
    Locale('kaw'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Schuly'**
  String get appTitle;

  /// Message shown when no accounts are configured
  ///
  /// In en, this message translates to:
  /// **'No account added yet.'**
  String get noAccountAdded;

  /// Button text to add a new account
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get addAccount;

  /// Message shown when no account is currently active
  ///
  /// In en, this message translates to:
  /// **'No active account selected.'**
  String get noActiveAccount;

  /// Button text to select an account
  ///
  /// In en, this message translates to:
  /// **'Select Account'**
  String get selectAccount;

  /// Title for personal information section
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// Title for quick actions section
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// Menu item for app settings
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// Subtitle for app settings option
  ///
  /// In en, this message translates to:
  /// **'Customize design and settings'**
  String get designAndSettings;

  /// Menu item for help and support
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// Subtitle for help and support option
  ///
  /// In en, this message translates to:
  /// **'Get help and support'**
  String get getHelpAndSupport;

  /// Title for email support card
  ///
  /// In en, this message translates to:
  /// **'Email Support'**
  String get emailSupport;

  /// Subtitle for email support card
  ///
  /// In en, this message translates to:
  /// **'Contact me directly by email'**
  String get contactByEmail;

  /// Title for bug report card
  ///
  /// In en, this message translates to:
  /// **'Bug Report / Feature Request'**
  String get bugReport;

  /// Subtitle for bug report card
  ///
  /// In en, this message translates to:
  /// **'Report bugs or request new features'**
  String get reportBugsOrRequestFeatures;

  /// Button text to copy to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// Snackbar message when copied to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Dialog title for errors
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Error message when email app cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open email app. Please contact us manually at: {email}'**
  String emailAppError(Object email);

  /// Error message when browser cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open browser. Please visit manually: {url}'**
  String browserError(Object url);

  /// Menu item to add another account
  ///
  /// In en, this message translates to:
  /// **'Add Another Account'**
  String get addAnotherAccount;

  /// Subtitle for add account option
  ///
  /// In en, this message translates to:
  /// **'Add multiple accounts'**
  String get addMultipleAccounts;

  /// Menu item to logout
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Subtitle for logout option
  ///
  /// In en, this message translates to:
  /// **'Sign out from the app'**
  String get signOutFromApp;

  /// Label for name field
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Label for street field
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get street;

  /// Label for zip code and city field
  ///
  /// In en, this message translates to:
  /// **'ZIP City'**
  String get zipCity;

  /// Label for birth date field
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birthDate;

  /// Label for phone field
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Label for email field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Label for nationality field
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get nationality;

  /// Label for hometown field
  ///
  /// In en, this message translates to:
  /// **'Hometown'**
  String get hometown;

  /// Label for mobile phone field
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// Label for profile 1 field
  ///
  /// In en, this message translates to:
  /// **'Profile 1'**
  String get profile1;

  /// Label for profile 2 field
  ///
  /// In en, this message translates to:
  /// **'Profile 2'**
  String get profile2;

  /// Navigation tab label for start/home page
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// Navigation tab label for agenda/schedule page
  ///
  /// In en, this message translates to:
  /// **'Agenda'**
  String get agenda;

  /// Navigation tab label for grades page
  ///
  /// In en, this message translates to:
  /// **'Grades'**
  String get grades;

  /// Navigation tab label for absences page
  ///
  /// In en, this message translates to:
  /// **'Absences'**
  String get absences;

  /// Navigation tab label for account page
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Label for language selection
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Title for language selection dialog
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// German language option
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get german;

  /// Swiss German language option
  ///
  /// In en, this message translates to:
  /// **'Swiss German'**
  String get swissGerman;

  /// Pirate language option
  ///
  /// In en, this message translates to:
  /// **'Pirate'**
  String get pirate;

  /// Kawaii language option
  ///
  /// In en, this message translates to:
  /// **'Kawaii'**
  String get kawaii;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Label for push notifications setting
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// Subtitle for features not yet available
  ///
  /// In en, this message translates to:
  /// **'Feature in development'**
  String get featureInDevelopment;

  /// Subtitle when notifications are enabled
  ///
  /// In en, this message translates to:
  /// **'Get notified before classes'**
  String get getNotified;

  /// Subtitle when notifications are disabled
  ///
  /// In en, this message translates to:
  /// **'Enable to receive notifications'**
  String get enableNotifications;

  /// Success message when notifications are enabled
  ///
  /// In en, this message translates to:
  /// **'Notifications enabled successfully'**
  String get notificationsEnabled;

  /// Error message when notification permission is denied
  ///
  /// In en, this message translates to:
  /// **'Notification permission denied. Please enable in settings.'**
  String get notificationPermissionDenied;

  /// Menu item for notification configuration
  ///
  /// In en, this message translates to:
  /// **'Configure Notifications'**
  String get configureNotifications;

  /// Subtitle for notification configuration
  ///
  /// In en, this message translates to:
  /// **'Choose types and timing for notifications'**
  String get chooseTypesAndTiming;

  /// Menu item for release notes
  ///
  /// In en, this message translates to:
  /// **'What\'s New'**
  String get whatsNew;

  /// Subtitle for what's new option
  ///
  /// In en, this message translates to:
  /// **'Changelog and new features'**
  String get changelogAndFeatures;

  /// Menu item to check for app updates
  ///
  /// In en, this message translates to:
  /// **'Check for Updates'**
  String get checkForUpdates;

  /// Subtitle for update check option
  ///
  /// In en, this message translates to:
  /// **'Check for new versions'**
  String get checkForNewVersions;

  /// Menu item for app information
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// Version label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Close button text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Add button text
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Loading text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Message when no events are found for selected day
  ///
  /// In en, this message translates to:
  /// **'No events for this day'**
  String get noEventsForThisDay;

  /// Agenda section header for a specific date.
  ///
  /// In en, this message translates to:
  /// **'Agenda for {day}.{month}.{year}'**
  String agendaForDate(Object day, Object month, Object year);

  /// No description provided for @noAgendaForDay.
  ///
  /// In en, this message translates to:
  /// **'No events for this day.'**
  String get noAgendaForDay;

  /// Title for next lessons section
  ///
  /// In en, this message translates to:
  /// **'Next Lessons'**
  String get nextLessons;

  /// Title for next holidays section
  ///
  /// In en, this message translates to:
  /// **'Next Holidays'**
  String get nextHolidays;

  /// Student ID card label
  ///
  /// In en, this message translates to:
  /// **'Student ID Card'**
  String get studentIdCard;

  /// Button text to reload the page
  ///
  /// In en, this message translates to:
  /// **'Reload page'**
  String get reloadPage;

  /// Message shown when student ID card is loading
  ///
  /// In en, this message translates to:
  /// **'Loading student ID card...'**
  String get loadingStudentIdCard;

  /// Validation message for email input
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get enterValidEmail;

  /// Confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// Update dialog title
  ///
  /// In en, this message translates to:
  /// **'Update Available!'**
  String get updateAvailable;

  /// Later button text
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// Yes button text
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No button text
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Status: confirmed
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// Lateness/tardiness label
  ///
  /// In en, this message translates to:
  /// **'Lateness'**
  String get lateness;

  /// Message when no lateness records found
  ///
  /// In en, this message translates to:
  /// **'No lateness found'**
  String get noLatenessFound;

  /// Validation for reason selection
  ///
  /// In en, this message translates to:
  /// **'Please select a reason'**
  String get selectReason;

  /// Validation for date selection
  ///
  /// In en, this message translates to:
  /// **'Please select a date'**
  String get selectDate;

  /// Email address input label
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// Password input label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Validation message for empty email
  ///
  /// In en, this message translates to:
  /// **'Please enter an email address'**
  String get enterEmailAddress;

  /// Button text to fetch a new token for the active account
  ///
  /// In en, this message translates to:
  /// **'Get new token'**
  String get getNewToken;

  /// Subtitle for fetching a new token
  ///
  /// In en, this message translates to:
  /// **'Fetch a new token for the active account'**
  String get getNewTokenSubtitle;

  /// Message shown when token is successfully updated
  ///
  /// In en, this message translates to:
  /// **'Token updated!'**
  String get tokenUpdated;

  /// Snackbar message when no active account is selected
  ///
  /// In en, this message translates to:
  /// **'No active account!'**
  String get noActiveAccountSnack;

  /// Title for add account dialog
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get addAccountTitle;

  /// Label for email input field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// Placeholder for email input field
  ///
  /// In en, this message translates to:
  /// **'Enter email'**
  String get enterEmail;

  /// Label for password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Placeholder for password input field
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// Message shown when account is successfully added
  ///
  /// In en, this message translates to:
  /// **'Account added!'**
  String get accountAdded;

  /// Title for logout dialog
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutTitle;

  /// Confirmation message for logout
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirm;

  /// Message shown when user is successfully logged out
  ///
  /// In en, this message translates to:
  /// **'Logged out!'**
  String get loggedOut;

  /// Title for design settings section
  ///
  /// In en, this message translates to:
  /// **'Design Settings'**
  String get designSettings;

  /// Label for appearance settings
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Option for automatic appearance mode
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get automatic;

  /// Option for light appearance mode
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Option for dark appearance mode
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// Label for color style settings
  ///
  /// In en, this message translates to:
  /// **'Color Style'**
  String get colorStyle;

  /// Option for Material You color style
  ///
  /// In en, this message translates to:
  /// **'Material\nYou'**
  String get materialYou;

  /// Option for classic color style
  ///
  /// In en, this message translates to:
  /// **'Classic'**
  String get classic;

  /// Option for neon color style
  ///
  /// In en, this message translates to:
  /// **'Neon'**
  String get neon;

  /// Label for neon accent color settings
  ///
  /// In en, this message translates to:
  /// **'Neon Accent Color'**
  String get neonAccentColor;

  /// Label for classic accent color settings
  ///
  /// In en, this message translates to:
  /// **'Classic Accent Color'**
  String get classicAccentColor;

  /// Message indicating Material You is active
  ///
  /// In en, this message translates to:
  /// **'Material You active'**
  String get materialYouActive;

  /// Information about Material You color style
  ///
  /// In en, this message translates to:
  /// **'Colors are automatically taken from the system theme.'**
  String get materialYouInfo;

  /// Neon violet color option
  ///
  /// In en, this message translates to:
  /// **'Neon Violet'**
  String get neonViolet;

  /// Neon cyan color option
  ///
  /// In en, this message translates to:
  /// **'Neon Cyan'**
  String get neonCyan;

  /// Neon green color option
  ///
  /// In en, this message translates to:
  /// **'Neon Green'**
  String get neonGreen;

  /// Neon pink color option
  ///
  /// In en, this message translates to:
  /// **'Neon Pink'**
  String get neonPink;

  /// Neon orange color option
  ///
  /// In en, this message translates to:
  /// **'Neon Orange'**
  String get neonOrange;

  /// Neon blue color option
  ///
  /// In en, this message translates to:
  /// **'Neon Blue'**
  String get neonBlue;

  /// Neon red color option
  ///
  /// In en, this message translates to:
  /// **'Neon Red'**
  String get neonRed;

  /// Neon yellow color option
  ///
  /// In en, this message translates to:
  /// **'Neon Yellow'**
  String get neonYellow;

  /// Neon mint color option
  ///
  /// In en, this message translates to:
  /// **'Neon Mint'**
  String get neonMint;

  /// Blue color option
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get blue;

  /// Teal color option
  ///
  /// In en, this message translates to:
  /// **'Teal'**
  String get teal;

  /// Green color option
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get green;

  /// Pink color option
  ///
  /// In en, this message translates to:
  /// **'Pink'**
  String get pink;

  /// Orange color option
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get orange;

  /// Indigo color option
  ///
  /// In en, this message translates to:
  /// **'Indigo'**
  String get indigo;

  /// Red color option
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get red;

  /// Yellow color option
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get yellow;

  /// Purple color option
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get purple;

  /// No description provided for @previousLessonsDay.
  ///
  /// In en, this message translates to:
  /// **'Previous day with lessons'**
  String get previousLessonsDay;

  /// No description provided for @nextLessonsDay.
  ///
  /// In en, this message translates to:
  /// **'Next day with lessons'**
  String get nextLessonsDay;

  /// No description provided for @noLessonsFound.
  ///
  /// In en, this message translates to:
  /// **'No lessons found.'**
  String get noLessonsFound;

  /// No description provided for @noLessonsForDay.
  ///
  /// In en, this message translates to:
  /// **'No lessons for {day}.{month}.{year}'**
  String noLessonsForDay(Object day, Object month, Object year);

  /// No description provided for @noHolidaysFound.
  ///
  /// In en, this message translates to:
  /// **'No holidays found.'**
  String get noHolidaysFound;

  /// No description provided for @latestGrades.
  ///
  /// In en, this message translates to:
  /// **'Latest grades'**
  String get latestGrades;

  /// No description provided for @noGradesFound.
  ///
  /// In en, this message translates to:
  /// **'No grades found.'**
  String get noGradesFound;

  /// No description provided for @openAbsences.
  ///
  /// In en, this message translates to:
  /// **'Open absences'**
  String get openAbsences;

  /// Button text to show all release notes
  ///
  /// In en, this message translates to:
  /// **'Show all'**
  String get showAll;

  /// No description provided for @noAbsencesFound.
  ///
  /// In en, this message translates to:
  /// **'No absences found.'**
  String get noAbsencesFound;

  /// No description provided for @noOpenAbsences.
  ///
  /// In en, this message translates to:
  /// **'No open absences.'**
  String get noOpenAbsences;

  /// No description provided for @noReleaseNotes.
  ///
  /// In en, this message translates to:
  /// **'No release notes available'**
  String get noReleaseNotes;

  /// No description provided for @releaseNotesInfo.
  ///
  /// In en, this message translates to:
  /// **'Updates and new features will be shown here'**
  String get releaseNotesInfo;

  /// No description provided for @notificationTypes.
  ///
  /// In en, this message translates to:
  /// **'Notification types'**
  String get notificationTypes;

  /// No description provided for @timetable.
  ///
  /// In en, this message translates to:
  /// **'Timetable'**
  String get timetable;

  /// No description provided for @agendaNotificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications before lessons'**
  String get agendaNotificationSubtitle;

  /// No description provided for @gradeNotificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications for new grades'**
  String get gradeNotificationSubtitle;

  /// No description provided for @absenceNotificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications for absence changes'**
  String get absenceNotificationSubtitle;

  /// No description provided for @generalNotifications.
  ///
  /// In en, this message translates to:
  /// **'General notifications'**
  String get generalNotifications;

  /// No description provided for @generalNotificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Important school information and updates'**
  String get generalNotificationSubtitle;

  /// No description provided for @notificationTime.
  ///
  /// In en, this message translates to:
  /// **'Notification time'**
  String get notificationTime;

  /// No description provided for @notificationAdvanceQuestion.
  ///
  /// In en, this message translates to:
  /// **'How many minutes before class do you want to be notified?'**
  String get notificationAdvanceQuestion;

  /// No description provided for @minutesBeforeClass.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String minutesBeforeClass(Object minutes);

  /// No description provided for @currentAdvanceSetting.
  ///
  /// In en, this message translates to:
  /// **'Current setting: {minutes} minutes before class'**
  String currentAdvanceSetting(Object minutes);

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get test;

  /// No description provided for @sendTestNotification.
  ///
  /// In en, this message translates to:
  /// **'Send test notification'**
  String get sendTestNotification;

  /// No description provided for @checkNotificationsWork.
  ///
  /// In en, this message translates to:
  /// **'Check if notifications work'**
  String get checkNotificationsWork;

  /// Button to schedule a test notification
  ///
  /// In en, this message translates to:
  /// **'Schedule test notification'**
  String get scheduleTestNotification;

  /// Description for scheduled test notification
  ///
  /// In en, this message translates to:
  /// **'Receive a notification in 15 seconds (works when app is closed)'**
  String get testScheduledNotificationDesc;

  /// Success message when test notification is scheduled
  ///
  /// In en, this message translates to:
  /// **'Notification scheduled! Close the app to test - appears in 15 seconds'**
  String get notificationScheduledIn15Seconds;

  /// Error message when notification scheduling fails
  ///
  /// In en, this message translates to:
  /// **'Failed to schedule notification'**
  String get errorSchedulingNotification;

  /// Success message when test notification is sent
  ///
  /// In en, this message translates to:
  /// **'Test notification sent!'**
  String get testNotificationSent;

  /// Error message when exact alarm permission is required
  ///
  /// In en, this message translates to:
  /// **'Exact alarm permission required. Please enable in settings.'**
  String get exactAlarmPermissionRequired;

  /// Button to open app settings
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @gradeDetails.
  ///
  /// In en, this message translates to:
  /// **'Grade Details'**
  String get gradeDetails;

  /// No description provided for @basicInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInformation;

  /// No description provided for @titleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleLabel;

  /// No description provided for @subjectLabel.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subjectLabel;

  /// No description provided for @courseLabel.
  ///
  /// In en, this message translates to:
  /// **'Course'**
  String get courseLabel;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;

  /// No description provided for @confirmedLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmedLabel;

  /// No description provided for @gradeLabel.
  ///
  /// In en, this message translates to:
  /// **'Grade'**
  String get gradeLabel;

  /// No description provided for @pointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get pointsLabel;

  /// No description provided for @weightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weightLabel;

  /// No description provided for @courseGradeLabel.
  ///
  /// In en, this message translates to:
  /// **'Course Grade'**
  String get courseGradeLabel;

  /// No description provided for @classAverage.
  ///
  /// In en, this message translates to:
  /// **'Class Average'**
  String get classAverage;

  /// No description provided for @examGroupLabel.
  ///
  /// In en, this message translates to:
  /// **'Exam Group'**
  String get examGroupLabel;

  /// No description provided for @classAverageLabel.
  ///
  /// In en, this message translates to:
  /// **'Class Average'**
  String get classAverageLabel;

  /// No description provided for @groupWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Group Weight'**
  String get groupWeightLabel;

  /// No description provided for @commentLabel.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get commentLabel;

  /// No description provided for @latestVersionMessage.
  ///
  /// In en, this message translates to:
  /// **'You are already using the latest version.'**
  String get latestVersionMessage;

  /// Version string with version and build number.
  ///
  /// In en, this message translates to:
  /// **'Version {version}+{build}'**
  String versionWithNumber(Object version, Object build);

  /// No description provided for @appLegalese.
  ///
  /// In en, this message translates to:
  /// **'Schuly © 2025 PianoNic'**
  String get appLegalese;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'A custom app for students to manage Schulnetz data. Manage your timetable, grades, and important dates in one place.'**
  String get appDescription;

  /// No description provided for @apiEndpoint.
  ///
  /// In en, this message translates to:
  /// **'API Endpoint'**
  String get apiEndpoint;

  /// Validation message for empty API endpoint
  ///
  /// In en, this message translates to:
  /// **'Please enter API endpoint'**
  String get enterApiEndpoint;

  /// No description provided for @currentApiInfo.
  ///
  /// In en, this message translates to:
  /// **'Current API Info'**
  String get currentApiInfo;

  /// No description provided for @apiInfoStatus.
  ///
  /// In en, this message translates to:
  /// **'API Info Status'**
  String get apiInfoStatus;

  /// No description provided for @environment.
  ///
  /// In en, this message translates to:
  /// **'Environment'**
  String get environment;

  /// No description provided for @apiBaseUrl.
  ///
  /// In en, this message translates to:
  /// **'API Base URL'**
  String get apiBaseUrl;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Snackbar message when API URL is changed
  ///
  /// In en, this message translates to:
  /// **'API URL changed: {url}'**
  String apiUrlChanged(Object url);

  /// Returns the localized color name for a given key.
  ///
  /// In en, this message translates to:
  /// **'Get color name'**
  String get getColorName;

  /// Label for break between lessons
  ///
  /// In en, this message translates to:
  /// **'Break'**
  String get lessonBreak;

  /// Label for lunch break
  ///
  /// In en, this message translates to:
  /// **'Lunch Break'**
  String get lunchBreak;

  /// Setting to show/hide breaks between lessons
  ///
  /// In en, this message translates to:
  /// **'Show breaks between lessons'**
  String get showBreaks;

  /// Title for card-specific settings
  ///
  /// In en, this message translates to:
  /// **'Card Settings'**
  String get cardSettings;

  /// Hint text for tappable cards
  ///
  /// In en, this message translates to:
  /// **'Tap to customize'**
  String get tapToCustomize;

  /// Setting for how many days to display
  ///
  /// In en, this message translates to:
  /// **'Number of days to show'**
  String get numberOfDaysToShow;

  /// Setting for how many grades to display
  ///
  /// In en, this message translates to:
  /// **'Number of grades to show'**
  String get numberOfGradesToShow;

  /// Setting to filter absences
  ///
  /// In en, this message translates to:
  /// **'Show only open absences'**
  String get showOnlyOpenAbsences;

  /// Message shown when a card has no configurable settings
  ///
  /// In en, this message translates to:
  /// **'No configuration settings available'**
  String get noConfigurationAvailable;

  /// Header/title for the account switcher modal
  ///
  /// In en, this message translates to:
  /// **'Switch Account'**
  String get switchAccount;

  /// Shows the number of accounts
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 account} other{{count} accounts}}'**
  String accountCount(num count);

  /// Message when there are no accounts to switch
  ///
  /// In en, this message translates to:
  /// **'No accounts available.'**
  String get noAccounts;

  /// Subtitle encouraging the user to add their first account
  ///
  /// In en, this message translates to:
  /// **'Add your first account to get started!'**
  String get addFirstAccount;

  /// Label for the active account
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// Label for available (not active) accounts
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// Button/dialog title for removing an account
  ///
  /// In en, this message translates to:
  /// **'Remove Account'**
  String get removeAccount;

  /// Confirmation for removing an account
  ///
  /// In en, this message translates to:
  /// **'Remove account {email}?'**
  String confirmRemoveAccount(Object email);

  /// Button text for confirming removal
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// Snackbar message when switching account
  ///
  /// In en, this message translates to:
  /// **'Switched to {email}'**
  String switchedAccount(Object email);

  /// Error message when switching account fails
  ///
  /// In en, this message translates to:
  /// **'Failed to switch account: {error}'**
  String switchAccountError(Object error);

  /// Snackbar message when removing account
  ///
  /// In en, this message translates to:
  /// **'Removed account {email}'**
  String removedAccount(Object email);

  /// Error message when removing account fails
  ///
  /// In en, this message translates to:
  /// **'Failed to remove account: {error}'**
  String removeAccountError(Object error);

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Unexpected error: {error}'**
  String unexpectedError(Object error);

  /// Abbreviation for Monday
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get weekdayMon;

  /// Abbreviation for Tuesday
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get weekdayTue;

  /// Abbreviation for Wednesday
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get weekdayWed;

  /// Abbreviation for Thursday
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get weekdayThu;

  /// Abbreviation for Friday
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get weekdayFri;

  /// Abbreviation for Saturday
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get weekdaySat;

  /// Abbreviation for Sunday
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get weekdaySun;

  /// No description provided for @absencesTabAll.
  ///
  /// In en, this message translates to:
  /// **'All Absences'**
  String get absencesTabAll;

  /// No description provided for @absencesTabLateness.
  ///
  /// In en, this message translates to:
  /// **'Lateness'**
  String get absencesTabLateness;

  /// No description provided for @absencesTabAbsences.
  ///
  /// In en, this message translates to:
  /// **'Absences'**
  String get absencesTabAbsences;

  /// No description provided for @absencesTabNotices.
  ///
  /// In en, this message translates to:
  /// **'Notices'**
  String get absencesTabNotices;

  /// No description provided for @absencesSection.
  ///
  /// In en, this message translates to:
  /// **'Absences'**
  String get absencesSection;

  /// No description provided for @latenessSection.
  ///
  /// In en, this message translates to:
  /// **'Lateness'**
  String get latenessSection;

  /// No description provided for @noticesSection.
  ///
  /// In en, this message translates to:
  /// **'Notices'**
  String get noticesSection;

  /// No description provided for @noticeItem.
  ///
  /// In en, this message translates to:
  /// **'Notice'**
  String get noticeItem;

  /// No description provided for @noReasonGiven.
  ///
  /// In en, this message translates to:
  /// **'No reason given'**
  String get noReasonGiven;

  /// No description provided for @noCommentGiven.
  ///
  /// In en, this message translates to:
  /// **'No comment given'**
  String get noCommentGiven;

  /// No description provided for @unknownData.
  ///
  /// In en, this message translates to:
  /// **'Unknown data'**
  String get unknownData;

  /// No description provided for @noNoticesFound.
  ///
  /// In en, this message translates to:
  /// **'No notices found.'**
  String get noNoticesFound;

  /// Plural form of minutes
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hr'**
  String get hours;

  /// No description provided for @latenessFrom.
  ///
  /// In en, this message translates to:
  /// **'Lateness from'**
  String get latenessFrom;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @course.
  ///
  /// In en, this message translates to:
  /// **'Course'**
  String get course;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @excused.
  ///
  /// In en, this message translates to:
  /// **'Excused'**
  String get excused;

  /// No description provided for @notExcused.
  ///
  /// In en, this message translates to:
  /// **'Not excused'**
  String get notExcused;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @excuseUntil.
  ///
  /// In en, this message translates to:
  /// **'Excuse until'**
  String get excuseUntil;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @excuse.
  ///
  /// In en, this message translates to:
  /// **'Excuse'**
  String get excuse;

  /// No description provided for @excuseComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Excuse - Coming Soon!'**
  String get excuseComingSoon;

  /// No description provided for @deleteAbsenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Absence'**
  String get deleteAbsenceTitle;

  /// No description provided for @deleteAbsenceConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this absence? This action cannot be undone.'**
  String get deleteAbsenceConfirm;

  /// No description provided for @absenceDeleted.
  ///
  /// In en, this message translates to:
  /// **'Absence deleted!'**
  String get absenceDeleted;

  /// Title for app update test page
  ///
  /// In en, this message translates to:
  /// **'App Update Test'**
  String get appUpdateTest;

  /// Initial status message for update test
  ///
  /// In en, this message translates to:
  /// **'Ready to test'**
  String get readyToTest;

  /// Title for update system test section
  ///
  /// In en, this message translates to:
  /// **'Update System Test'**
  String get updateSystemTest;

  /// Status label with status value
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String statusLabel(Object status);

  /// Progress text when checking for updates
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get checking;

  /// Button text to force show update dialog
  ///
  /// In en, this message translates to:
  /// **'Force Show Update Dialog'**
  String get forceShowUpdateDialog;

  /// Button text to clear dismissed updates
  ///
  /// In en, this message translates to:
  /// **'Clear Dismissed Updates'**
  String get clearDismissedUpdates;

  /// Title for explanation section
  ///
  /// In en, this message translates to:
  /// **'How it works:'**
  String get howItWorks;

  /// First step of update process
  ///
  /// In en, this message translates to:
  /// **'1. Checks GitHub releases for newer versions'**
  String get updateStep1;

  /// Second step of update process
  ///
  /// In en, this message translates to:
  /// **'2. Downloads APK from GitHub release assets'**
  String get updateStep2;

  /// Third step of update process
  ///
  /// In en, this message translates to:
  /// **'3. Opens Android installer automatically'**
  String get updateStep3;

  /// Fourth step of update process
  ///
  /// In en, this message translates to:
  /// **'4. Remembers dismissed updates until app restart'**
  String get updateStep4;

  /// Status when checking for updates
  ///
  /// In en, this message translates to:
  /// **'Checking for updates...'**
  String get checkingForUpdates;

  /// Status when update is available
  ///
  /// In en, this message translates to:
  /// **'Update available: v{version}'**
  String updateAvailableVersion(Object version);

  /// Status when no updates are available
  ///
  /// In en, this message translates to:
  /// **'No updates available or update dismissed'**
  String get noUpdatesAvailable;

  /// Error message when checking for updates fails
  ///
  /// In en, this message translates to:
  /// **'Error checking for updates: {error}'**
  String errorCheckingUpdates(Object error);

  /// Status when showing update dialog
  ///
  /// In en, this message translates to:
  /// **'Showing update dialog...'**
  String get showingUpdateDialog;

  /// Status when update dialog is shown
  ///
  /// In en, this message translates to:
  /// **'Update dialog shown'**
  String get updateDialogShown;

  /// Error message when showing dialog fails
  ///
  /// In en, this message translates to:
  /// **'Error showing dialog: {error}'**
  String errorShowingDialog(Object error);

  /// Status when clearing dismissed updates
  ///
  /// In en, this message translates to:
  /// **'Clearing dismissed updates...'**
  String get clearingDismissedUpdates;

  /// Status when dismissed updates are cleared
  ///
  /// In en, this message translates to:
  /// **'Dismissed updates cleared'**
  String get dismissedUpdatesCleared;

  /// Error message when clearing dismissed updates fails
  ///
  /// In en, this message translates to:
  /// **'Error clearing dismissed: {error}'**
  String errorClearingDismissed(Object error);

  /// Absence reason: illness
  ///
  /// In en, this message translates to:
  /// **'Illness'**
  String get illness;

  /// Absence reason: accident
  ///
  /// In en, this message translates to:
  /// **'Accident'**
  String get accident;

  /// Absence reason: military
  ///
  /// In en, this message translates to:
  /// **'Military'**
  String get military;

  /// Absence reason: medical certificate for sports
  ///
  /// In en, this message translates to:
  /// **'Valid medical certificate for sports'**
  String get medicalCertificateForSport;

  /// Absence reason: other
  ///
  /// In en, this message translates to:
  /// **'Other absence'**
  String get otherAbsence;

  /// Title for creating a new absence
  ///
  /// In en, this message translates to:
  /// **'Create new absence'**
  String get createNewAbsence;

  /// Required field label for absence reason
  ///
  /// In en, this message translates to:
  /// **'Reason *'**
  String get reasonRequired;

  /// Create button text
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// Message when there are no errors
  ///
  /// In en, this message translates to:
  /// **'No error'**
  String get noError;

  /// Unknown value placeholder
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// Current version label in update dialog
  ///
  /// In en, this message translates to:
  /// **'Current: {version}'**
  String currentVersion(Object version);

  /// Latest version label in update dialog
  ///
  /// In en, this message translates to:
  /// **'Latest: {version}'**
  String latestVersion(Object version);

  /// Status message during update download
  ///
  /// In en, this message translates to:
  /// **'Update is being downloaded...'**
  String get downloadingUpdate;

  /// Status message during update installation
  ///
  /// In en, this message translates to:
  /// **'Update is being installed...'**
  String get installingUpdate;

  /// Install button text
  ///
  /// In en, this message translates to:
  /// **'Install'**
  String get install;

  /// Downloading button text
  ///
  /// In en, this message translates to:
  /// **'Downloading...'**
  String get downloading;

  /// Installing button text
  ///
  /// In en, this message translates to:
  /// **'Installing...'**
  String get installing;

  /// Error message when download fails
  ///
  /// In en, this message translates to:
  /// **'Error downloading update'**
  String get downloadError;

  /// Detailed download error message
  ///
  /// In en, this message translates to:
  /// **'Download error: {error}'**
  String downloadErrorDetails(Object error);

  /// Error when installation permission is denied
  ///
  /// In en, this message translates to:
  /// **'Installation not allowed'**
  String get installationNotAllowed;

  /// Generic installation error message
  ///
  /// In en, this message translates to:
  /// **'Installation error'**
  String get installationError;

  /// Detailed installation error message
  ///
  /// In en, this message translates to:
  /// **'Installation error: {error}'**
  String installationErrorDetails(Object error);

  /// Success message when installation starts
  ///
  /// In en, this message translates to:
  /// **'Update installation started'**
  String get updateInstallationStarted;

  /// Label for absence start date field
  ///
  /// In en, this message translates to:
  /// **'Absent from *'**
  String get absentFrom;

  /// Label for absence end date field
  ///
  /// In en, this message translates to:
  /// **'Absent to *'**
  String get absentTo;

  /// Validation for date range
  ///
  /// In en, this message translates to:
  /// **'End date must be after start date'**
  String get toDateMustBeAfterFromDate;

  /// Label for absence start time field
  ///
  /// In en, this message translates to:
  /// **'Absent from (time)'**
  String get absentFromTime;

  /// Label for absence end time field
  ///
  /// In en, this message translates to:
  /// **'Absent to (time)'**
  String get absentToTime;

  /// Success message for absence creation
  ///
  /// In en, this message translates to:
  /// **'Absence created successfully!'**
  String get absenceCreatedSuccessfully;

  /// Title for homepage configuration modal
  ///
  /// In en, this message translates to:
  /// **'Customize homepage'**
  String get customizeHomepage;

  /// Status text for visible sections
  ///
  /// In en, this message translates to:
  /// **'Visible'**
  String get visible;

  /// Status text for hidden sections
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get hidden;

  /// Notification channel name
  ///
  /// In en, this message translates to:
  /// **'PushAssist Notifications'**
  String get pushAssistNotifications;

  /// Notification channel description
  ///
  /// In en, this message translates to:
  /// **'Notifications before classes'**
  String get notificationsBeforeClasses;

  /// Test notification channel name
  ///
  /// In en, this message translates to:
  /// **'Test Notifications'**
  String get testNotifications;

  /// Test notification channel description
  ///
  /// In en, this message translates to:
  /// **'Test notification for PushAssist'**
  String get testNotificationDescription;

  /// Notification title for next class
  ///
  /// In en, this message translates to:
  /// **'Next class: {subject}'**
  String nextClass(Object subject);

  /// Notification body with room and teacher
  ///
  /// In en, this message translates to:
  /// **'Room: {room}{teacher}'**
  String roomAndTeacher(Object room, Object teacher);

  /// Teacher part of notification
  ///
  /// In en, this message translates to:
  /// **' • Teacher: {teacher}'**
  String teacher(Object teacher);

  /// Test notification title
  ///
  /// In en, this message translates to:
  /// **'🔔 PushAssist Vibration Test'**
  String get vibrationTest;

  /// Test notification message
  ///
  /// In en, this message translates to:
  /// **'This notification should vibrate! Check your device settings if it doesn\'t.'**
  String get vibrationTestMessage;

  /// Monday abbreviation
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get monday;

  /// Tuesday abbreviation
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tuesday;

  /// Wednesday abbreviation
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wednesday;

  /// Thursday abbreviation
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thursday;

  /// Friday abbreviation
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get friday;

  /// Saturday abbreviation
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get saturday;

  /// Sunday abbreviation
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sunday;

  /// January month name
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// February month name
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// March month name
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// April month name
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// May month name
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// June month name
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// July month name
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// August month name
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// September month name
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// October month name
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// November month name
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// December month name
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// Tooltip for student ID card button
  ///
  /// In en, this message translates to:
  /// **'Student ID card'**
  String get studentIdCardTooltip;

  /// Tooltip for homepage customization button
  ///
  /// In en, this message translates to:
  /// **'Customize homepage'**
  String get customizeHomepageTooltip;

  /// Button text to switch account
  ///
  /// In en, this message translates to:
  /// **'Switch account'**
  String get switchAccountButton;

  /// Loading message during app initialization
  ///
  /// In en, this message translates to:
  /// **'Fetching app information...'**
  String get fetchingAppInfo;

  /// Loading message during update check on startup
  ///
  /// In en, this message translates to:
  /// **'Checking for updates...'**
  String get checkingUpdatesInitialization;

  /// Loading message during data fetch
  ///
  /// In en, this message translates to:
  /// **'Loading data...'**
  String get loadingData;

  /// Loading message during app startup finalization
  ///
  /// In en, this message translates to:
  /// **'Finalizing initialization...'**
  String get finalizingInitialization;

  /// Message shown when checking API connection
  ///
  /// In en, this message translates to:
  /// **'Checking connection...'**
  String get checkingConnection;

  /// Message shown when offline mode is detected
  ///
  /// In en, this message translates to:
  /// **'Offline mode - using cached data'**
  String get offlineModeDetected;

  /// Message shown when loading cached data in offline mode
  ///
  /// In en, this message translates to:
  /// **'Loading cached data...'**
  String get loadingCachedData;

  /// Detailed error message for update check failure
  ///
  /// In en, this message translates to:
  /// **'Error checking for updates: {error}'**
  String errorCheckingUpdatesDetails(Object error);

  /// Singular form of minute
  ///
  /// In en, this message translates to:
  /// **'minute'**
  String get minute;

  /// Text shown under the time display
  ///
  /// In en, this message translates to:
  /// **'before class'**
  String get beforeClass;

  /// Title for notification permissions dialog
  ///
  /// In en, this message translates to:
  /// **'Notification Permissions'**
  String get notificationPermissions;

  /// Description for notification permissions dialog
  ///
  /// In en, this message translates to:
  /// **'To receive timely notifications about your classes, please grant the following permissions:'**
  String get notificationPermissionsDescription;

  /// Basic notification permission
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationPermission;

  /// Description for notification permission
  ///
  /// In en, this message translates to:
  /// **'Allow Schuly to send you notifications'**
  String get notificationPermissionDesc;

  /// Exact alarm permission
  ///
  /// In en, this message translates to:
  /// **'Exact Alarms'**
  String get exactAlarmPermission;

  /// Description for exact alarm permission
  ///
  /// In en, this message translates to:
  /// **'Required for precise notification timing'**
  String get exactAlarmPermissionDesc;

  /// Battery optimization permission
  ///
  /// In en, this message translates to:
  /// **'Battery Optimization'**
  String get batteryOptimization;

  /// Description for battery optimization
  ///
  /// In en, this message translates to:
  /// **'Disable battery optimization for reliable notifications'**
  String get batteryOptimizationDesc;

  /// Button to grant permission
  ///
  /// In en, this message translates to:
  /// **'Grant'**
  String get grant;

  /// Message when all permissions are granted
  ///
  /// In en, this message translates to:
  /// **'All permissions granted! Notifications will work reliably.'**
  String get allPermissionsGranted;

  /// Message when some permissions are missing
  ///
  /// In en, this message translates to:
  /// **'Some permissions are missing. Notifications may not work as expected.'**
  String get somePermissionsMissing;

  /// Button to dismiss permission dialog
  ///
  /// In en, this message translates to:
  /// **'Remind Later'**
  String get remindLater;

  /// Button to continue without all permissions
  ///
  /// In en, this message translates to:
  /// **'Continue Anyway'**
  String get continueAnyway;

  /// Done button
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Button to check notification permissions
  ///
  /// In en, this message translates to:
  /// **'Check Permissions'**
  String get checkPermissions;

  /// Header for absence notices related to an absence
  ///
  /// In en, this message translates to:
  /// **'Related Notices'**
  String get relatedNotices;

  /// Label for exam lessons
  ///
  /// In en, this message translates to:
  /// **'Exam'**
  String get exam;

  /// Date label
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Time label
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// Label for student's reason for absence
  ///
  /// In en, this message translates to:
  /// **'Student Reason'**
  String get studentReason;

  /// Label for trainer's comment on absence
  ///
  /// In en, this message translates to:
  /// **'Trainer Comment'**
  String get trainerComment;

  /// Header for unexcused absences section
  ///
  /// In en, this message translates to:
  /// **'Unexcused Absences'**
  String get unexcusedAbsences;

  /// Message when re-authentication is cancelled
  ///
  /// In en, this message translates to:
  /// **'Re-authentication cancelled. Some features may not work.'**
  String get reAuthenticationCancelled;

  /// Title for console logs page
  ///
  /// In en, this message translates to:
  /// **'Console Logs'**
  String get consoleLogs;

  /// Subtitle for console logs menu item
  ///
  /// In en, this message translates to:
  /// **'View app debug logs'**
  String get viewAppDebugLogs;

  /// Buy me a coffee menu item
  ///
  /// In en, this message translates to:
  /// **'Buy me a coffee'**
  String get buyMeACoffee;

  /// Subtitle for buy me a coffee item
  ///
  /// In en, this message translates to:
  /// **'Support the development'**
  String get supportDevelopment;

  /// Error when Buy Me a Coffee page cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open Buy Me a Coffee page'**
  String get couldNotOpenBuyMeACoffee;

  /// Text shown between login options
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// Microsoft sign in button text
  ///
  /// In en, this message translates to:
  /// **'Sign in with Microsoft'**
  String get signInWithMicrosoft;

  /// Clear logs button text
  ///
  /// In en, this message translates to:
  /// **'Clear logs'**
  String get clearLogs;

  /// Export logs button text
  ///
  /// In en, this message translates to:
  /// **'Export logs'**
  String get exportLogs;

  /// All filter option
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Debug log level
  ///
  /// In en, this message translates to:
  /// **'Debug'**
  String get debug;

  /// Info log level
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// Warning log level
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// Enable logging toggle text
  ///
  /// In en, this message translates to:
  /// **'Enable logging'**
  String get enableLogging;

  /// Clear filters button text
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFilters;

  /// Message when log is copied to clipboard
  ///
  /// In en, this message translates to:
  /// **'Log copied to clipboard'**
  String get logCopiedToClipboard;

  /// Clear all logs confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Clear all logs?'**
  String get clearAllLogs;

  /// Warning message for irreversible actions
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get thisActionCannotBeUndone;

  /// Message when logs are cleared
  ///
  /// In en, this message translates to:
  /// **'Logs cleared'**
  String get logsCleared;

  /// Clear button text
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Message when logs are exported to clipboard
  ///
  /// In en, this message translates to:
  /// **'Logs exported to clipboard'**
  String get logsExportedToClipboard;

  /// Message when API endpoint is reachable
  ///
  /// In en, this message translates to:
  /// **'Endpoint reachable ({statusCode})'**
  String endpointReachable(Object statusCode);

  /// Server error message with status code
  ///
  /// In en, this message translates to:
  /// **'Server error: {statusCode}'**
  String serverError(Object statusCode);

  /// Error when Microsoft authentication fails to initialize
  ///
  /// In en, this message translates to:
  /// **'Failed to initialize Microsoft authentication: {error}'**
  String failedToInitializeMicrosoftAuth(Object error);

  /// Generic authentication failure message
  ///
  /// In en, this message translates to:
  /// **'Authentication failed: {error}'**
  String authenticationFailed(Object error);

  /// Message shown when there is no internet connection
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// Title for upcoming tests card
  ///
  /// In en, this message translates to:
  /// **'Upcoming Tests'**
  String get upcomingTests;

  /// Message when no tests are available
  ///
  /// In en, this message translates to:
  /// **'No tests found'**
  String get noTestsFound;

  /// Message when there are no upcoming tests
  ///
  /// In en, this message translates to:
  /// **'No upcoming tests'**
  String get noUpcomingTests;

  /// Room label for test location
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get room;

  /// Weight label for test importance
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// Setting label for number of tests to display
  ///
  /// In en, this message translates to:
  /// **'Number of tests to show'**
  String get numberOfTestsToShow;

  /// Tooltip for home button to return to today
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Option for card view in agenda settings
  ///
  /// In en, this message translates to:
  /// **'Card View'**
  String get cardView;

  /// Description for card view option
  ///
  /// In en, this message translates to:
  /// **'Detailed cards with expandable test info'**
  String get cardViewDescription;

  /// Option for timeline view in agenda settings
  ///
  /// In en, this message translates to:
  /// **'Timeline View'**
  String get timelineView;

  /// Description for timeline view option
  ///
  /// In en, this message translates to:
  /// **'Compact timeline with time-based layout'**
  String get timelineViewDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['arr', 'de', 'en', 'gsw', 'kaw'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'arr':
      return AppLocalizationsArr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'gsw':
      return AppLocalizationsGsw();
    case 'kaw':
      return AppLocalizationsKaw();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
