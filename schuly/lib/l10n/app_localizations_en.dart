// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Schuly';

  @override
  String get noAccountAdded => 'No account added yet.';

  @override
  String get addAccount => 'Add Account';

  @override
  String get noActiveAccount => 'No active account selected.';

  @override
  String get selectAccount => 'Select Account';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get appSettings => 'App Settings';

  @override
  String get designAndSettings => 'Customize design and settings';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get getHelpAndSupport => 'Get help and support';

  @override
  String get emailSupport => 'Email Support';

  @override
  String get contactByEmail => 'Contact me directly by email';

  @override
  String get bugReport => 'Bug Report / Feature Request';

  @override
  String get reportBugsOrRequestFeatures =>
      'Report bugs or request new features';

  @override
  String get copy => 'Copy';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Error';

  @override
  String emailAppError(Object email) {
    return 'Could not open email app. Please contact us manually at: $email';
  }

  @override
  String browserError(Object url) {
    return 'Could not open browser. Please visit manually: $url';
  }

  @override
  String get addAnotherAccount => 'Add Another Account';

  @override
  String get addMultipleAccounts => 'Add multiple accounts';

  @override
  String get logout => 'Logout';

  @override
  String get signOutFromApp => 'Sign out from the app';

  @override
  String get name => 'Name';

  @override
  String get street => 'Street';

  @override
  String get zipCity => 'ZIP City';

  @override
  String get birthDate => 'Birth Date';

  @override
  String get phone => 'Phone';

  @override
  String get email => 'Email';

  @override
  String get nationality => 'Nationality';

  @override
  String get hometown => 'Hometown';

  @override
  String get mobile => 'Mobile';

  @override
  String get profile1 => 'Profile 1';

  @override
  String get profile2 => 'Profile 2';

  @override
  String get start => 'Start';

  @override
  String get agenda => 'Agenda';

  @override
  String get grades => 'Grades';

  @override
  String get absences => 'Absences';

  @override
  String get account => 'Account';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get english => 'English';

  @override
  String get german => 'German';

  @override
  String get swissGerman => 'Swiss German';

  @override
  String get pirate => 'Pirate';

  @override
  String get kawaii => 'Kawaii';

  @override
  String get arnold => 'Terminator';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get featureInDevelopment => 'Feature in development';

  @override
  String get getNotified => 'Get notified before classes';

  @override
  String get enableNotifications => 'Enable to receive notifications';

  @override
  String get notificationsEnabled => 'Notifications enabled successfully';

  @override
  String get notificationPermissionDenied =>
      'Notification permission denied. Please enable in settings.';

  @override
  String get configureNotifications => 'Configure Notifications';

  @override
  String get chooseTypesAndTiming =>
      'Choose types and timing for notifications';

  @override
  String get whatsNew => 'What\'s New';

  @override
  String get changelogAndFeatures => 'Changelog and new features';

  @override
  String get checkForUpdates => 'Check for Updates';

  @override
  String get checkForNewVersions => 'Check for new versions';

  @override
  String get aboutApp => 'About App';

  @override
  String get version => 'Version';

  @override
  String get delete => 'Delete';

  @override
  String get close => 'Close';

  @override
  String get add => 'Add';

  @override
  String get loading => 'Loading...';

  @override
  String get noEventsForThisDay => 'No events for this day';

  @override
  String agendaForDate(Object day, Object month, Object year) {
    return 'Agenda for $day.$month.$year';
  }

  @override
  String get noAgendaForDay => 'No events for this day.';

  @override
  String get nextLessons => 'Next Lessons';

  @override
  String get nextHolidays => 'Next Holidays';

  @override
  String get studentIdCard => 'Student ID Card';

  @override
  String get reloadPage => 'Reload page';

  @override
  String get loadingStudentIdCard => 'Loading student ID card...';

  @override
  String get enterValidEmail => 'Please enter a valid email address';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String get updateAvailable => 'Update Available!';

  @override
  String get later => 'Later';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get confirmed => 'Confirmed';

  @override
  String get lateness => 'Lateness';

  @override
  String get noLatenessFound => 'No lateness found';

  @override
  String get selectReason => 'Please select a reason';

  @override
  String get selectDate => 'Please select a date';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get enterEmailAddress => 'Please enter an email address';

  @override
  String get getNewToken => 'Get new token';

  @override
  String get getNewTokenSubtitle => 'Fetch a new token for the active account';

  @override
  String get tokenUpdated => 'Token updated!';

  @override
  String get noActiveAccountSnack => 'No active account!';

  @override
  String get addAccountTitle => 'Add Account';

  @override
  String get emailLabel => 'Email';

  @override
  String get enterEmail => 'Enter email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get accountAdded => 'Account added!';

  @override
  String get logoutTitle => 'Logout';

  @override
  String get logoutConfirm => 'Are you sure you want to log out?';

  @override
  String get loggedOut => 'Logged out!';

  @override
  String get designSettings => 'Design Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get automatic => 'Automatic';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get colorStyle => 'Color Style';

  @override
  String get materialYou => 'Material\nYou';

  @override
  String get classic => 'Classic';

  @override
  String get neon => 'Neon';

  @override
  String get neonAccentColor => 'Neon Accent Color';

  @override
  String get classicAccentColor => 'Classic Accent Color';

  @override
  String get materialYouActive => 'Material You active';

  @override
  String get materialYouInfo =>
      'Colors are automatically taken from the system theme.';

  @override
  String get neonViolet => 'Neon Violet';

  @override
  String get neonCyan => 'Neon Cyan';

  @override
  String get neonGreen => 'Neon Green';

  @override
  String get neonPink => 'Neon Pink';

  @override
  String get neonOrange => 'Neon Orange';

  @override
  String get neonBlue => 'Neon Blue';

  @override
  String get neonRed => 'Neon Red';

  @override
  String get neonYellow => 'Neon Yellow';

  @override
  String get neonMint => 'Neon Mint';

  @override
  String get blue => 'Blue';

  @override
  String get teal => 'Teal';

  @override
  String get green => 'Green';

  @override
  String get pink => 'Pink';

  @override
  String get orange => 'Orange';

  @override
  String get indigo => 'Indigo';

  @override
  String get red => 'Red';

  @override
  String get yellow => 'Yellow';

  @override
  String get purple => 'Purple';

  @override
  String get previousLessonsDay => 'Previous day with lessons';

  @override
  String get nextLessonsDay => 'Next day with lessons';

  @override
  String get noLessonsFound => 'No lessons found.';

  @override
  String noLessonsForDay(Object day, Object month, Object year) {
    return 'No lessons for $day.$month.$year';
  }

  @override
  String get noHolidaysFound => 'No holidays found.';

  @override
  String get latestGrades => 'Latest grades';

  @override
  String get noGradesFound => 'No grades found.';

  @override
  String get openAbsences => 'Open absences';

  @override
  String get showAll => 'Show all';

  @override
  String get noAbsencesFound => 'No absences found.';

  @override
  String get noOpenAbsences => 'No open absences.';

  @override
  String get noReleaseNotes => 'No release notes available';

  @override
  String get releaseNotesInfo => 'Updates and new features will be shown here';

  @override
  String get notificationTypes => 'Notification types';

  @override
  String get timetable => 'Timetable';

  @override
  String get agendaNotificationSubtitle => 'Notifications before lessons';

  @override
  String get gradeNotificationSubtitle => 'Notifications for new grades';

  @override
  String get absenceNotificationSubtitle => 'Notifications for absence changes';

  @override
  String get generalNotifications => 'General notifications';

  @override
  String get generalNotificationSubtitle =>
      'Important school information and updates';

  @override
  String get notificationTime => 'Notification time';

  @override
  String get notificationAdvanceQuestion =>
      'How many minutes before class do you want to be notified?';

  @override
  String minutesBeforeClass(Object minutes) {
    return '$minutes min';
  }

  @override
  String currentAdvanceSetting(Object minutes) {
    return 'Current setting: $minutes minutes before class';
  }

  @override
  String get test => 'Test';

  @override
  String get sendTestNotification => 'Send test notification';

  @override
  String get checkNotificationsWork => 'Check if notifications work';

  @override
  String get scheduleTestNotification => 'Schedule test notification';

  @override
  String get testScheduledNotificationDesc =>
      'Receive a notification in 15 seconds (works when app is closed)';

  @override
  String get notificationScheduledIn15Seconds =>
      'Notification scheduled! Close the app to test - appears in 15 seconds';

  @override
  String get errorSchedulingNotification => 'Failed to schedule notification';

  @override
  String get testNotificationSent => 'Test notification sent!';

  @override
  String get exactAlarmPermissionRequired =>
      'Exact alarm permission required. Please enable in settings.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get gradeDetails => 'Grade Details';

  @override
  String get basicInformation => 'Basic Information';

  @override
  String get titleLabel => 'Title';

  @override
  String get subjectLabel => 'Subject';

  @override
  String get courseLabel => 'Course';

  @override
  String get dateLabel => 'Date';

  @override
  String get confirmedLabel => 'Confirmed';

  @override
  String get gradeLabel => 'Grade';

  @override
  String get pointsLabel => 'Points';

  @override
  String get weightLabel => 'Weight';

  @override
  String get courseGradeLabel => 'Course Grade';

  @override
  String get classAverage => 'Class Average';

  @override
  String get examGroupLabel => 'Exam Group';

  @override
  String get classAverageLabel => 'Class Average';

  @override
  String get groupWeightLabel => 'Group Weight';

  @override
  String get commentLabel => 'Comment';

  @override
  String get latestVersionMessage =>
      'You are already using the latest version.';

  @override
  String versionWithNumber(Object version, Object build) {
    return 'Version $version+$build';
  }

  @override
  String get appLegalese => 'Schuly © 2025 PianoNic';

  @override
  String get appDescription =>
      'A custom app for students to manage Schulnetz data. Manage your timetable, grades, and important dates in one place.';

  @override
  String get apiEndpoint => 'API Endpoint';

  @override
  String get enterApiEndpoint => 'Please enter API endpoint';

  @override
  String get currentApiInfo => 'Current API Info';

  @override
  String get apiInfoStatus => 'API Info Status';

  @override
  String get environment => 'Environment';

  @override
  String get apiBaseUrl => 'API Base URL';

  @override
  String get save => 'Save';

  @override
  String apiUrlChanged(Object url) {
    return 'API URL changed: $url';
  }

  @override
  String get getColorName => 'Get color name';

  @override
  String get lessonBreak => 'Break';

  @override
  String get lunchBreak => 'Lunch Break';

  @override
  String get showBreaks => 'Show breaks between lessons';

  @override
  String get cardSettings => 'Card Settings';

  @override
  String get tapToCustomize => 'Tap to customize';

  @override
  String get numberOfDaysToShow => 'Number of days to show';

  @override
  String get numberOfGradesToShow => 'Number of grades to show';

  @override
  String get showOnlyOpenAbsences => 'Show only open absences';

  @override
  String get noConfigurationAvailable => 'No configuration settings available';

  @override
  String get switchAccount => 'Switch Account';

  @override
  String accountCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count accounts',
      one: '1 account',
    );
    return '$_temp0';
  }

  @override
  String get noAccounts => 'No accounts available.';

  @override
  String get addFirstAccount => 'Add your first account to get started!';

  @override
  String get active => 'Active';

  @override
  String get available => 'Available';

  @override
  String get removeAccount => 'Remove Account';

  @override
  String confirmRemoveAccount(Object email) {
    return 'Remove account $email?';
  }

  @override
  String get remove => 'Remove';

  @override
  String switchedAccount(Object email) {
    return 'Switched to $email';
  }

  @override
  String switchAccountError(Object error) {
    return 'Failed to switch account: $error';
  }

  @override
  String removedAccount(Object email) {
    return 'Removed account $email';
  }

  @override
  String removeAccountError(Object error) {
    return 'Failed to remove account: $error';
  }

  @override
  String unexpectedError(Object error) {
    return 'Unexpected error: $error';
  }

  @override
  String get weekdayMon => 'Mon';

  @override
  String get weekdayTue => 'Tue';

  @override
  String get weekdayWed => 'Wed';

  @override
  String get weekdayThu => 'Thu';

  @override
  String get weekdayFri => 'Fri';

  @override
  String get weekdaySat => 'Sat';

  @override
  String get weekdaySun => 'Sun';

  @override
  String get absencesTabAll => 'All Absences';

  @override
  String get absencesTabLateness => 'Lateness';

  @override
  String get absencesTabAbsences => 'Absences';

  @override
  String get absencesTabNotices => 'Notices';

  @override
  String get absencesSection => 'Absences';

  @override
  String get latenessSection => 'Lateness';

  @override
  String get noticesSection => 'Notices';

  @override
  String get noticeItem => 'Notice';

  @override
  String get noReasonGiven => 'No reason given';

  @override
  String get noCommentGiven => 'No comment given';

  @override
  String get unknownData => 'Unknown data';

  @override
  String get noNoticesFound => 'No notices found.';

  @override
  String get minutes => 'minutes';

  @override
  String get hours => 'hr';

  @override
  String get latenessFrom => 'Lateness from';

  @override
  String get duration => 'Duration';

  @override
  String get course => 'Course';

  @override
  String get reason => 'Reason';

  @override
  String get comment => 'Comment';

  @override
  String get status => 'Status';

  @override
  String get excused => 'Excused';

  @override
  String get notExcused => 'Not excused';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get excuseUntil => 'Excuse until';

  @override
  String get details => 'Details';

  @override
  String get excuse => 'Excuse';

  @override
  String get excuseComingSoon => 'Excuse - Coming Soon!';

  @override
  String get deleteAbsenceTitle => 'Delete Absence';

  @override
  String get deleteAbsenceConfirm =>
      'Are you sure you want to delete this absence? This action cannot be undone.';

  @override
  String get absenceDeleted => 'Absence deleted!';

  @override
  String get appUpdateTest => 'App Update Test';

  @override
  String get readyToTest => 'Ready to test';

  @override
  String get updateSystemTest => 'Update System Test';

  @override
  String statusLabel(Object status) {
    return 'Status: $status';
  }

  @override
  String get checking => 'Checking...';

  @override
  String get forceShowUpdateDialog => 'Force Show Update Dialog';

  @override
  String get clearDismissedUpdates => 'Clear Dismissed Updates';

  @override
  String get howItWorks => 'How it works:';

  @override
  String get updateStep1 => '1. Checks GitHub releases for newer versions';

  @override
  String get updateStep2 => '2. Downloads APK from GitHub release assets';

  @override
  String get updateStep3 => '3. Opens Android installer automatically';

  @override
  String get updateStep4 => '4. Remembers dismissed updates until app restart';

  @override
  String get checkingForUpdates => 'Checking for updates...';

  @override
  String updateAvailableVersion(Object version) {
    return 'Update available: v$version';
  }

  @override
  String get noUpdatesAvailable => 'No updates available or update dismissed';

  @override
  String errorCheckingUpdates(Object error) {
    return 'Error checking for updates: $error';
  }

  @override
  String get showingUpdateDialog => 'Showing update dialog...';

  @override
  String get updateDialogShown => 'Update dialog shown';

  @override
  String errorShowingDialog(Object error) {
    return 'Error showing dialog: $error';
  }

  @override
  String get clearingDismissedUpdates => 'Clearing dismissed updates...';

  @override
  String get dismissedUpdatesCleared => 'Dismissed updates cleared';

  @override
  String errorClearingDismissed(Object error) {
    return 'Error clearing dismissed: $error';
  }

  @override
  String get illness => 'Illness';

  @override
  String get accident => 'Accident';

  @override
  String get military => 'Military';

  @override
  String get medicalCertificateForSport =>
      'Valid medical certificate for sports';

  @override
  String get otherAbsence => 'Other absence';

  @override
  String get createNewAbsence => 'Create new absence';

  @override
  String get reasonRequired => 'Reason *';

  @override
  String get create => 'Create';

  @override
  String get noError => 'No error';

  @override
  String get unknown => 'Unknown';

  @override
  String currentVersion(Object version) {
    return 'Current: $version';
  }

  @override
  String latestVersion(Object version) {
    return 'Latest: $version';
  }

  @override
  String get downloadingUpdate => 'Update is being downloaded...';

  @override
  String get installingUpdate => 'Update is being installed...';

  @override
  String get install => 'Install';

  @override
  String get downloading => 'Downloading...';

  @override
  String get download => 'Download';

  @override
  String get installing => 'Installing...';

  @override
  String get downloadError => 'Error downloading update';

  @override
  String downloadErrorDetails(Object error) {
    return 'Download error: $error';
  }

  @override
  String get installationNotAllowed => 'Installation not allowed';

  @override
  String get installationError => 'Installation error';

  @override
  String installationErrorDetails(Object error) {
    return 'Installation error: $error';
  }

  @override
  String get updateInstallationStarted => 'Update installation started';

  @override
  String get absentFrom => 'Absent from *';

  @override
  String get absentTo => 'Absent to *';

  @override
  String get toDateMustBeAfterFromDate => 'End date must be after start date';

  @override
  String get absentFromTime => 'Absent from (time)';

  @override
  String get absentToTime => 'Absent to (time)';

  @override
  String get absenceCreatedSuccessfully => 'Absence created successfully!';

  @override
  String get customizeHomepage => 'Customize homepage';

  @override
  String get visible => 'Visible';

  @override
  String get hidden => 'Hidden';

  @override
  String get pushAssistNotifications => 'PushAssist Notifications';

  @override
  String get notificationsBeforeClasses => 'Notifications before classes';

  @override
  String get testNotifications => 'Test Notifications';

  @override
  String get testNotificationDescription => 'Test notification for PushAssist';

  @override
  String nextClass(Object subject) {
    return 'Next class: $subject';
  }

  @override
  String roomAndTeacher(Object room, Object teacher) {
    return 'Room: $room$teacher';
  }

  @override
  String teacher(Object teacher) {
    return ' • Teacher: $teacher';
  }

  @override
  String get vibrationTest => '🔔 PushAssist Vibration Test';

  @override
  String get vibrationTestMessage =>
      'This notification should vibrate! Check your device settings if it doesn\'t.';

  @override
  String get monday => 'Mon';

  @override
  String get tuesday => 'Tue';

  @override
  String get wednesday => 'Wed';

  @override
  String get thursday => 'Thu';

  @override
  String get friday => 'Fri';

  @override
  String get saturday => 'Sat';

  @override
  String get sunday => 'Sun';

  @override
  String get january => 'January';

  @override
  String get february => 'February';

  @override
  String get march => 'March';

  @override
  String get april => 'April';

  @override
  String get may => 'May';

  @override
  String get june => 'June';

  @override
  String get july => 'July';

  @override
  String get august => 'August';

  @override
  String get september => 'September';

  @override
  String get october => 'October';

  @override
  String get november => 'November';

  @override
  String get december => 'December';

  @override
  String get studentIdCardTooltip => 'Student ID card';

  @override
  String get customizeHomepageTooltip => 'Customize homepage';

  @override
  String get switchAccountButton => 'Switch account';

  @override
  String get fetchingAppInfo => 'Fetching app information...';

  @override
  String get checkingUpdatesInitialization => 'Checking for updates...';

  @override
  String get loadingData => 'Loading data...';

  @override
  String get finalizingInitialization => 'Finalizing initialization...';

  @override
  String get checkingConnection => 'Checking connection...';

  @override
  String get offlineModeDetected => 'Offline mode - using cached data';

  @override
  String get loadingCachedData => 'Loading cached data...';

  @override
  String errorCheckingUpdatesDetails(Object error) {
    return 'Error checking for updates: $error';
  }

  @override
  String get privacyAndDataCollection => 'Privacy & Data Collection';

  @override
  String get welcomeToSchuly => 'Welcome to Schuly!';

  @override
  String get privacyConsentIntro =>
      'To help us improve your experience and fix issues quickly, we collect error reports when the app crashes or encounters problems.';

  @override
  String get whatWeCollect => 'What we collect:';

  @override
  String get whatWeDontCollect => 'What we DON\'T collect:';

  @override
  String get errorReports => 'Error Reports';

  @override
  String get errorReportsDesc =>
      'Stack traces, error messages, and breadcrumbs to help us fix bugs';

  @override
  String get deviceInformation => 'Device Information';

  @override
  String get deviceInformationDesc =>
      'Device model, OS version, screen size, memory, battery level, and app version';

  @override
  String get performanceData => 'Performance Data';

  @override
  String get performanceDataDesc =>
      'API response times, app lifecycle events, and memory usage';

  @override
  String get usagePatterns => 'Usage Patterns';

  @override
  String get usagePatternsDesc =>
      'Navigation breadcrumbs and API operations performed (fetchAll, etc.)';

  @override
  String get userContext => 'User Context';

  @override
  String get userContextDesc =>
      'Your email address (for identifying issues specific to your account)';

  @override
  String get personalData => 'Personal Data';

  @override
  String get personalDataDesc =>
      'Your grades, schedule content, notes, and personal messages stay private';

  @override
  String get credentials => 'Credentials';

  @override
  String get credentialsDesc =>
      'Your passwords, authentication tokens, and sensitive API responses are filtered out';

  @override
  String get privacyConsentChangeAnytime =>
      'You can change this setting anytime in the app settings.';

  @override
  String get privacyConsentHelpMessage =>
      'Error reports include your email address for debugging purposes. This data is only used to fix bugs and improve app stability. By consenting, you help make Schuly better for everyone.';

  @override
  String get privacyConsentDecline => 'Decline';

  @override
  String get privacyConsentAccept => 'Accept & Continue';

  @override
  String get errorTracking => 'Error Tracking';

  @override
  String get errorTrackingEnabledDesc =>
      'Help improve app stability by sharing error reports with debugging context';

  @override
  String get errorTrackingDisabledDesc => 'Error tracking is disabled';

  @override
  String get errorTrackingEnabled =>
      'Thank you! Error tracking has been enabled.';

  @override
  String get errorTrackingDisabled =>
      'Error tracking has been disabled. Please restart the app for changes to take effect.';

  @override
  String get errorTrackingRestartRequired =>
      'Please restart the app for changes to take effect.';

  @override
  String get minute => 'minute';

  @override
  String get beforeClass => 'before class';

  @override
  String get notificationPermissions => 'Notification Permissions';

  @override
  String get notificationPermissionsDescription =>
      'To receive timely notifications about your classes, please grant the following permissions:';

  @override
  String get notificationPermission => 'Notifications';

  @override
  String get notificationPermissionDesc =>
      'Allow Schuly to send you notifications';

  @override
  String get exactAlarmPermission => 'Exact Alarms';

  @override
  String get exactAlarmPermissionDesc =>
      'Required for precise notification timing';

  @override
  String get batteryOptimization => 'Battery Optimization';

  @override
  String get batteryOptimizationDesc =>
      'Disable battery optimization for reliable notifications';

  @override
  String get grant => 'Grant';

  @override
  String get allPermissionsGranted =>
      'All permissions granted! Notifications will work reliably.';

  @override
  String get somePermissionsMissing =>
      'Some permissions are missing. Notifications may not work as expected.';

  @override
  String get remindLater => 'Remind Later';

  @override
  String get continueAnyway => 'Continue Anyway';

  @override
  String get done => 'Done';

  @override
  String get checkPermissions => 'Check Permissions';

  @override
  String get relatedNotices => 'Related Notices';

  @override
  String get exam => 'Exam';

  @override
  String get date => 'Date';

  @override
  String get time => 'Time';

  @override
  String get studentReason => 'Student Reason';

  @override
  String get trainerComment => 'Trainer Comment';

  @override
  String get unexcusedAbsences => 'Unexcused Absences';

  @override
  String get reAuthenticationCancelled =>
      'Re-authentication cancelled. Some features may not work.';

  @override
  String get consoleLogs => 'Console Logs';

  @override
  String get viewAppDebugLogs => 'View app debug logs';

  @override
  String get buyMeACoffee => 'Buy me a coffee';

  @override
  String get supportDevelopment => 'Support the development';

  @override
  String get couldNotOpenBuyMeACoffee => 'Could not open Buy Me a Coffee page';

  @override
  String get or => 'OR';

  @override
  String get signInWithMicrosoft => 'Sign in with Microsoft';

  @override
  String get clearLogs => 'Clear logs';

  @override
  String get exportLogs => 'Export logs';

  @override
  String get all => 'All';

  @override
  String get debug => 'Debug';

  @override
  String get info => 'Info';

  @override
  String get warning => 'Warning';

  @override
  String get enableLogging => 'Enable logging';

  @override
  String get clearFilters => 'Clear filters';

  @override
  String get logCopiedToClipboard => 'Log copied to clipboard';

  @override
  String get clearAllLogs => 'Clear all logs?';

  @override
  String get thisActionCannotBeUndone => 'This action cannot be undone.';

  @override
  String get logsCleared => 'Logs cleared';

  @override
  String get clear => 'Clear';

  @override
  String get logsExportedToClipboard => 'Logs exported to clipboard';

  @override
  String endpointReachable(Object statusCode) {
    return 'Endpoint reachable ($statusCode)';
  }

  @override
  String serverError(Object statusCode) {
    return 'Server error: $statusCode';
  }

  @override
  String failedToInitializeMicrosoftAuth(Object error) {
    return 'Failed to initialize Microsoft authentication: $error';
  }

  @override
  String authenticationFailed(Object error) {
    return 'Authentication failed: $error';
  }

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get upcomingTests => 'Upcoming Tests';

  @override
  String get noTestsFound => 'No tests found';

  @override
  String get noUpcomingTests => 'No upcoming tests';

  @override
  String get room => 'Room';

  @override
  String get weight => 'Weight';

  @override
  String get numberOfTestsToShow => 'Number of tests to show';

  @override
  String get today => 'Today';

  @override
  String get cardView => 'Card View';

  @override
  String get cardViewDescription => 'Detailed cards with expandable test info';

  @override
  String get timelineView => 'Timeline View';

  @override
  String get timelineViewDescription =>
      'Compact timeline with time-based layout';

  @override
  String get shareYourMaggusLevel => 'Share your Maggus level';

  @override
  String myMaggusScore(Object score) {
    return 'My Maggus Score: $score Points!';
  }

  @override
  String get testYourMaggusLevel =>
      'Test your own Maggus level in the Schuly App!';

  @override
  String get gradeDisplaySettings => 'Grade Display Settings';

  @override
  String get chooseGradeDisplay => 'Choose how grades are displayed:';

  @override
  String get exactGrades => 'Exact Grades';

  @override
  String get exactGradesDesc => 'Show precise grade values';

  @override
  String get roundedGrades => 'Report Card Grades';

  @override
  String get roundedGradesDesc => 'Rounded to nearest 0.5 (Zeugnisnote)';

  @override
  String get bothGrades => 'Both';

  @override
  String get bothGradesDesc => 'Show exact and rounded grades';

  @override
  String get gradeRoundingInfo =>
      'Report card grades are rounded to the nearest 0.5 as they appear on official documents.';

  @override
  String get gradeColors => 'Grade Colors';

  @override
  String get useGradeColors => 'Use Grade Colors';

  @override
  String get useGradeColorsDesc => 'Color grades based on their value';

  @override
  String get redThreshold => 'Red (below)';

  @override
  String get yellowThreshold => 'Yellow (below)';

  @override
  String get greenThreshold => 'Green';

  @override
  String get preview => 'Preview';

  @override
  String get appInformation => 'App Information';

  @override
  String get overview => 'Overview';

  @override
  String get statistics => 'Statistics';
}
