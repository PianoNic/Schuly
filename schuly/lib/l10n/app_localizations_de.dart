// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Schuly';

  @override
  String get noAccountAdded => 'Noch kein Account hinzugefügt.';

  @override
  String get addAccount => 'Account hinzufügen';

  @override
  String get noActiveAccount => 'Kein aktiver Account ausgewählt.';

  @override
  String get selectAccount => 'Account auswählen';

  @override
  String get personalInformation => 'Persönliche Angaben';

  @override
  String get quickActions => 'Schnellaktionen';

  @override
  String get appSettings => 'App Einstellungen';

  @override
  String get designAndSettings => 'Design und Einstellungen anpassen';

  @override
  String get helpAndSupport => 'Hilfe & Support';

  @override
  String get getHelpAndSupport => 'Hilfe und Support erhalten';

  @override
  String get emailSupport => 'E-Mail Support';

  @override
  String get contactByEmail => 'Kontaktiere mich direkt per E-Mail';

  @override
  String get bugReport => 'Bug Report / Feature Request';

  @override
  String get reportBugsOrRequestFeatures =>
      'Melde Bugs oder schlage neue Features vor';

  @override
  String get copy => 'Kopieren';

  @override
  String get copiedToClipboard => 'In Zwischenablage kopiert';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Fehler';

  @override
  String emailAppError(Object email) {
    return 'E-Mail-App konnte nicht geöffnet werden. Bitte kontaktieren Sie uns manuell unter: $email';
  }

  @override
  String browserError(Object url) {
    return 'Browser konnte nicht geöffnet werden. Bitte besuchen Sie manuell: $url';
  }

  @override
  String get addAnotherAccount => 'Weiteren Account hinzufügen';

  @override
  String get addMultipleAccounts => 'Mehrere Accounts hinzufügen';

  @override
  String get logout => 'Abmelden';

  @override
  String get signOutFromApp => 'Aus der App abmelden';

  @override
  String get name => 'Name';

  @override
  String get street => 'Strasse';

  @override
  String get zipCity => 'PLZ Ort';

  @override
  String get birthDate => 'Geburtsdatum';

  @override
  String get phone => 'Telefon';

  @override
  String get email => 'E-Mail';

  @override
  String get nationality => 'Nationalität';

  @override
  String get hometown => 'Heimatort';

  @override
  String get mobile => 'Handy';

  @override
  String get profile1 => 'Profil 1';

  @override
  String get profile2 => 'Profil 2';

  @override
  String get start => 'Start';

  @override
  String get agenda => 'Agenda';

  @override
  String get grades => 'Noten';

  @override
  String get absences => 'Absenzen';

  @override
  String get account => 'Account';

  @override
  String get language => 'Sprache';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get english => 'Englisch';

  @override
  String get german => 'Deutsch';

  @override
  String get swissGerman => 'Schwiizerdüütsch';

  @override
  String get pirate => 'Piraten-Sprache';

  @override
  String get kawaii => 'Kawaii';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get pushNotifications => 'Push-Benachrichtigungen';

  @override
  String get featureInDevelopment => 'Feature wird noch entwickelt';

  @override
  String get getNotified => 'Vor dem Unterricht benachrichtigt werden';

  @override
  String get enableNotifications =>
      'Aktivieren, um Benachrichtigungen zu erhalten';

  @override
  String get notificationsEnabled => 'Benachrichtigungen erfolgreich aktiviert';

  @override
  String get notificationPermissionDenied =>
      'Benachrichtigungsberechtigung verweigert. Bitte in den Einstellungen aktivieren.';

  @override
  String get configureNotifications => 'Benachrichtigungen konfigurieren';

  @override
  String get chooseTypesAndTiming =>
      'Wählen Sie Typen und Timing für Benachrichtigungen';

  @override
  String get whatsNew => 'Was ist neu';

  @override
  String get changelogAndFeatures => 'Changelog und neue Features';

  @override
  String get checkForUpdates => 'Nach Updates suchen';

  @override
  String get checkForNewVersions => 'Auf neue Versionen prüfen';

  @override
  String get aboutApp => 'Über die App';

  @override
  String get version => 'Version';

  @override
  String get delete => 'Löschen';

  @override
  String get close => 'Schließen';

  @override
  String get add => 'Hinzufügen';

  @override
  String get loading => 'Lädt...';

  @override
  String get noEventsForThisDay => 'Keine Termine für diesen Tag';

  @override
  String agendaForDate(Object day, Object month, Object year) {
    return 'Termine für $day.$month.$year';
  }

  @override
  String get noAgendaForDay => 'Keine Termine für diesen Tag.';

  @override
  String get nextLessons => 'Nächste Lektionen';

  @override
  String get nextHolidays => 'Nächste Ferien';

  @override
  String get studentIdCard => 'Schülerausweis';

  @override
  String get reloadPage => 'Seite neu laden';

  @override
  String get loadingStudentIdCard => 'Schülerausweis wird geladen...';

  @override
  String get enterValidEmail =>
      'Bitte geben Sie eine gültige E-Mail-Adresse ein';

  @override
  String get areYouSure => 'Sind Sie sicher?';

  @override
  String get updateAvailable => 'Update verfügbar!';

  @override
  String get later => 'Später';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get confirmed => 'Bestätigt';

  @override
  String get lateness => 'Verspätungen';

  @override
  String get noLatenessFound => 'Keine Verspätungen gefunden.';

  @override
  String get selectReason => 'Bitte wählen Sie einen Grund aus';

  @override
  String get selectDate => 'Bitte wählen Sie ein Datum aus';

  @override
  String get emailAddress => 'E-Mail-Adresse';

  @override
  String get password => 'Passwort';

  @override
  String get login => 'Anmelden';

  @override
  String get enterEmailAddress => 'Bitte geben Sie eine E-Mail-Adresse ein';

  @override
  String get getNewToken => 'Neues Token holen';

  @override
  String get getNewTokenSubtitle =>
      'Hole ein neues Token für den aktiven Account';

  @override
  String get tokenUpdated => 'Token aktualisiert!';

  @override
  String get noActiveAccountSnack => 'Kein aktiver Account!';

  @override
  String get addAccountTitle => 'Account hinzufügen';

  @override
  String get emailLabel => 'E-Mail';

  @override
  String get enterEmail => 'E-Mail eingeben';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get enterPassword => 'Passwort eingeben';

  @override
  String get accountAdded => 'Account hinzugefügt!';

  @override
  String get logoutTitle => 'Abmelden';

  @override
  String get logoutConfirm =>
      'Sind Sie sicher, dass Sie sich abmelden möchten?';

  @override
  String get loggedOut => 'Abgemeldet!';

  @override
  String get designSettings => 'Design Einstellungen';

  @override
  String get appearance => 'Darstellung';

  @override
  String get automatic => 'Automatisch';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get colorStyle => 'Farbstil';

  @override
  String get materialYou => 'Material\nYou';

  @override
  String get classic => 'Klassisch';

  @override
  String get neon => 'Neon';

  @override
  String get neonAccentColor => 'Neon Akzentfarbe';

  @override
  String get classicAccentColor => 'Klassische Akzentfarbe';

  @override
  String get materialYouActive => 'Material You aktiv';

  @override
  String get materialYouInfo =>
      'Farben werden automatisch vom Systemdesign übernommen';

  @override
  String get neonViolet => 'Neon Violett';

  @override
  String get neonCyan => 'Neon Cyan';

  @override
  String get neonGreen => 'Neon Grün';

  @override
  String get neonPink => 'Neon Pink';

  @override
  String get neonOrange => 'Neon Orange';

  @override
  String get neonBlue => 'Neon Blau';

  @override
  String get neonRed => 'Neon Rot';

  @override
  String get neonYellow => 'Neon Gelb';

  @override
  String get neonMint => 'Neon Mint';

  @override
  String get blue => 'Blau';

  @override
  String get teal => 'Türkis';

  @override
  String get green => 'Grün';

  @override
  String get pink => 'Pink';

  @override
  String get orange => 'Orange';

  @override
  String get indigo => 'Indigo';

  @override
  String get red => 'Rot';

  @override
  String get yellow => 'Gelb';

  @override
  String get purple => 'Lila';

  @override
  String get previousLessonsDay => 'Vorheriger Tag mit Lektionen';

  @override
  String get nextLessonsDay => 'Nächster Tag mit Lektionen';

  @override
  String get noLessonsFound => 'Keine Lektionen gefunden.';

  @override
  String noLessonsForDay(Object day, Object month, Object year) {
    return 'Keine Lektionen für $day.$month.$year';
  }

  @override
  String get noHolidaysFound => 'Keine Ferien gefunden.';

  @override
  String get latestGrades => 'Letzte Noten';

  @override
  String get noGradesFound => 'Keine Noten gefunden.';

  @override
  String get openAbsences => 'Offene Absenzen';

  @override
  String get showAll => 'Alle anzeigen';

  @override
  String get noAbsencesFound => 'Keine Absenzen gefunden.';

  @override
  String get noOpenAbsences => 'Keine offenen Absenzen.';

  @override
  String get noReleaseNotes => 'Keine Release Notes verfügbar';

  @override
  String get releaseNotesInfo =>
      'Updates und neue Features werden hier angezeigt';

  @override
  String get notificationTypes => 'Benachrichtigungstypen';

  @override
  String get timetable => 'Stundenplan';

  @override
  String get agendaNotificationSubtitle =>
      'Benachrichtigungen vor Unterrichtsstunden';

  @override
  String get gradeNotificationSubtitle => 'Benachrichtigungen bei neuen Noten';

  @override
  String get absenceNotificationSubtitle =>
      'Benachrichtigungen bei Abwesenheitsänderungen';

  @override
  String get generalNotifications => 'Allgemeine Mitteilungen';

  @override
  String get generalNotificationSubtitle =>
      'Wichtige Schulinformationen und Updates';

  @override
  String get notificationTime => 'Benachrichtigungszeit';

  @override
  String get notificationAdvanceQuestion =>
      'Wie viele Minuten vor Unterrichtsbeginn möchten Sie benachrichtigt werden?';

  @override
  String minutesBeforeClass(Object minutes) {
    return '$minutes Min';
  }

  @override
  String currentAdvanceSetting(Object minutes) {
    return 'Aktuelle Einstellung: $minutes Minuten vor Unterrichtsbeginn';
  }

  @override
  String get test => 'Test';

  @override
  String get sendTestNotification => 'Test-Benachrichtigung senden';

  @override
  String get checkNotificationsWork =>
      'Prüfen Sie, ob Benachrichtigungen funktionieren';

  @override
  String get scheduleTestNotification => 'Test-Benachrichtigung planen';

  @override
  String get testScheduledNotificationDesc =>
      'Erhalte eine Benachrichtigung in 15 Sekunden (funktioniert bei geschlossener App)';

  @override
  String get notificationScheduledIn15Seconds =>
      'Benachrichtigung geplant! App schließen zum Testen - erscheint in 15 Sekunden';

  @override
  String get errorSchedulingNotification =>
      'Fehler beim Planen der Benachrichtigung';

  @override
  String get testNotificationSent => 'Test-Benachrichtigung gesendet!';

  @override
  String get exactAlarmPermissionRequired =>
      'Berechtigung für exakte Alarme erforderlich. Bitte in den Einstellungen aktivieren.';

  @override
  String get openSettings => 'Einstellungen öffnen';

  @override
  String get gradeDetails => 'Notendetails';

  @override
  String get basicInformation => 'Grundinformationen';

  @override
  String get titleLabel => 'Titel';

  @override
  String get subjectLabel => 'Fach';

  @override
  String get courseLabel => 'Kurs';

  @override
  String get dateLabel => 'Datum';

  @override
  String get confirmedLabel => 'Bestätigt';

  @override
  String get gradeLabel => 'Note';

  @override
  String get pointsLabel => 'Punkte';

  @override
  String get weightLabel => 'Gewichtung';

  @override
  String get courseGradeLabel => 'Kursnote';

  @override
  String get classAverage => 'Klassenschnitt';

  @override
  String get examGroupLabel => 'Prüfungsgruppe';

  @override
  String get classAverageLabel => 'Klassenschnitt';

  @override
  String get groupWeightLabel => 'Gruppengewichtung';

  @override
  String get commentLabel => 'Kommentar';

  @override
  String get latestVersionMessage =>
      'Sie verwenden bereits die neueste Version.';

  @override
  String versionWithNumber(Object version, Object build) {
    return 'Version $version+$build';
  }

  @override
  String get appLegalese => 'Schuly © 2025 PianoNic';

  @override
  String get appDescription =>
      'Eine custom App für Schüler zur Verwaltung von Schulnetz-Daten. Verwalten Sie Ihren Stundenplan, Noten und wichtige Termine an einem Ort.';

  @override
  String get apiEndpoint => 'API Endpoint';

  @override
  String get enterApiEndpoint => 'Bitte geben Sie den API Endpoint ein';

  @override
  String get currentApiInfo => 'Aktuelle API Info';

  @override
  String get apiInfoStatus => 'API Info Status';

  @override
  String get environment => 'Umgebung';

  @override
  String get apiBaseUrl => 'API Basis-URL';

  @override
  String get save => 'Speichern';

  @override
  String apiUrlChanged(Object url) {
    return 'API URL geändert: $url';
  }

  @override
  String get getColorName => 'Farbname abrufen';

  @override
  String get lessonBreak => 'Pause';

  @override
  String get lunchBreak => 'Mittagspause';

  @override
  String get showBreaks => 'Pausen zwischen Lektionen anzeigen';

  @override
  String get cardSettings => 'Karten-Einstellungen';

  @override
  String get tapToCustomize => 'Zum Anpassen tippen';

  @override
  String get numberOfDaysToShow => 'Anzahl der anzuzeigenden Tage';

  @override
  String get numberOfGradesToShow => 'Anzahl der anzuzeigenden Noten';

  @override
  String get showOnlyOpenAbsences => 'Nur offene Absenzen anzeigen';

  @override
  String get noConfigurationAvailable =>
      'Keine Konfigurationseinstellungen verfügbar';

  @override
  String get switchAccount => 'Account wechseln';

  @override
  String accountCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Accounts',
      one: '1 Account',
    );
    return '$_temp0';
  }

  @override
  String get noAccounts => 'Keine Accounts verfügbar.';

  @override
  String get addFirstAccount => 'Fügen Sie Ihren ersten Account hinzu!';

  @override
  String get active => 'Aktiv';

  @override
  String get available => 'Verfügbar';

  @override
  String get removeAccount => 'Account entfernen';

  @override
  String confirmRemoveAccount(Object email) {
    return 'Account $email entfernen?';
  }

  @override
  String get remove => 'Entfernen';

  @override
  String switchedAccount(Object email) {
    return 'Zu $email gewechselt';
  }

  @override
  String switchAccountError(Object error) {
    return 'Accountwechsel fehlgeschlagen: $error';
  }

  @override
  String removedAccount(Object email) {
    return 'Account $email entfernt';
  }

  @override
  String removeAccountError(Object error) {
    return 'Account konnte nicht entfernt werden: $error';
  }

  @override
  String unexpectedError(Object error) {
    return 'Unerwarteter Fehler: $error';
  }

  @override
  String get weekdayMon => 'Mo';

  @override
  String get weekdayTue => 'Di';

  @override
  String get weekdayWed => 'Mi';

  @override
  String get weekdayThu => 'Do';

  @override
  String get weekdayFri => 'Fr';

  @override
  String get weekdaySat => 'Sa';

  @override
  String get weekdaySun => 'So';

  @override
  String get absencesTabAll => 'Alle Absenzen';

  @override
  String get absencesTabLateness => 'Verspätungen';

  @override
  String get absencesTabAbsences => 'Absenzen';

  @override
  String get absencesTabNotices => 'Meldungen';

  @override
  String get absencesSection => 'Absenzen';

  @override
  String get latenessSection => 'Verspätungen';

  @override
  String get noticesSection => 'Meldungen';

  @override
  String get noticeItem => 'Meldung';

  @override
  String get noReasonGiven => 'Kein Grund angegeben';

  @override
  String get noCommentGiven => 'Kein Kommentar angegeben';

  @override
  String get unknownData => 'Unbekannte Daten';

  @override
  String get noNoticesFound => 'Keine Meldungen gefunden.';

  @override
  String get minutes => 'Minuten';

  @override
  String get hours => 'Std.';

  @override
  String get latenessFrom => 'Verspätung vom';

  @override
  String get duration => 'Dauer';

  @override
  String get course => 'Kurs';

  @override
  String get reason => 'Grund';

  @override
  String get comment => 'Kommentar';

  @override
  String get status => 'Status';

  @override
  String get excused => 'Entschuldigt';

  @override
  String get notExcused => 'Nicht entschuldigt';

  @override
  String get from => 'Von';

  @override
  String get to => 'Bis';

  @override
  String get excuseUntil => 'Entschuldigen bis';

  @override
  String get details => 'Details';

  @override
  String get excuse => 'Entschuldigen';

  @override
  String get excuseComingSoon => 'Entschuldigung - Kommt bald!';

  @override
  String get deleteAbsenceTitle => 'Absenz löschen';

  @override
  String get deleteAbsenceConfirm =>
      'Sind Sie sicher, dass Sie diese Absenz löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get absenceDeleted => 'Absenz gelöscht!';

  @override
  String get appUpdateTest => 'App Update Test';

  @override
  String get readyToTest => 'Bereit zum Testen';

  @override
  String get updateSystemTest => 'Update System Test';

  @override
  String statusLabel(Object status) {
    return 'Status: $status';
  }

  @override
  String get checking => 'Überprüfe...';

  @override
  String get forceShowUpdateDialog => 'Update-Dialog erzwingen';

  @override
  String get clearDismissedUpdates => 'Verworfene Updates löschen';

  @override
  String get howItWorks => 'So funktioniert es:';

  @override
  String get updateStep1 => '1. Überprüft GitHub Releases auf neuere Versionen';

  @override
  String get updateStep2 => '2. Lädt APK von GitHub Release Assets herunter';

  @override
  String get updateStep3 => '3. Öffnet Android Installer automatisch';

  @override
  String get updateStep4 =>
      '4. Merkt sich verworfene Updates bis zum App-Neustart';

  @override
  String get checkingForUpdates => 'Suche nach Updates...';

  @override
  String updateAvailableVersion(Object version) {
    return 'Update verfügbar: v$version';
  }

  @override
  String get noUpdatesAvailable =>
      'Keine Updates verfügbar oder Update verworfen';

  @override
  String errorCheckingUpdates(Object error) {
    return 'Fehler beim Suchen nach Updates: $error';
  }

  @override
  String get showingUpdateDialog => 'Zeige Update-Dialog...';

  @override
  String get updateDialogShown => 'Update-Dialog angezeigt';

  @override
  String errorShowingDialog(Object error) {
    return 'Fehler beim Anzeigen des Dialogs: $error';
  }

  @override
  String get clearingDismissedUpdates => 'Lösche verworfene Updates...';

  @override
  String get dismissedUpdatesCleared => 'Verworfene Updates gelöscht';

  @override
  String errorClearingDismissed(Object error) {
    return 'Fehler beim Löschen verworfener Updates: $error';
  }

  @override
  String get illness => 'Krankheit';

  @override
  String get accident => 'Unfall';

  @override
  String get military => 'Militär';

  @override
  String get medicalCertificateForSport => 'Gültiges Arztzeugnis für Sport';

  @override
  String get otherAbsence => 'Andere Absenz';

  @override
  String get createNewAbsence => 'Neue Absenz erfassen';

  @override
  String get reasonRequired => 'Grund *';

  @override
  String get create => 'Erfassen';

  @override
  String get noError => 'Kein Fehler';

  @override
  String get unknown => 'Unbekannt';

  @override
  String currentVersion(Object version) {
    return 'Aktuell: $version';
  }

  @override
  String latestVersion(Object version) {
    return 'Neueste: $version';
  }

  @override
  String get downloadingUpdate => 'Update wird heruntergeladen...';

  @override
  String get installingUpdate => 'Update wird installiert...';

  @override
  String get install => 'Installieren';

  @override
  String get downloading => 'Wird heruntergeladen...';

  @override
  String get installing => 'Wird installiert...';

  @override
  String get downloadError => 'Fehler beim Herunterladen des Updates';

  @override
  String downloadErrorDetails(Object error) {
    return 'Download Fehler: $error';
  }

  @override
  String get installationNotAllowed => 'Installation nicht erlaubt';

  @override
  String get installationError => 'Fehler bei der Installation';

  @override
  String installationErrorDetails(Object error) {
    return 'Installation Fehler: $error';
  }

  @override
  String get updateInstallationStarted => 'Update Installation gestartet';

  @override
  String get absentFrom => 'Abwesend von *';

  @override
  String get absentTo => 'Abwesend bis *';

  @override
  String get toDateMustBeAfterFromDate =>
      'Bis-Datum muss nach Von-Datum liegen';

  @override
  String get absentFromTime => 'Abwesend ab (Uhrzeit)';

  @override
  String get absentToTime => 'Abwesend bis (Uhrzeit)';

  @override
  String get absenceCreatedSuccessfully => 'Absenz erfolgreich erfasst!';

  @override
  String get customizeHomepage => 'Start-Seite anpassen';

  @override
  String get visible => 'Sichtbar';

  @override
  String get hidden => 'Ausgeblendet';

  @override
  String get pushAssistNotifications => 'PushAssist Benachrichtigungen';

  @override
  String get notificationsBeforeClasses =>
      'Benachrichtigungen vor Schulstunden';

  @override
  String get testNotifications => 'Test Benachrichtigungen';

  @override
  String get testNotificationDescription =>
      'Test Benachrichtigung für PushAssist';

  @override
  String nextClass(Object subject) {
    return 'Nächste Stunde: $subject';
  }

  @override
  String roomAndTeacher(Object room, Object teacher) {
    return 'Raum: $room$teacher';
  }

  @override
  String teacher(Object teacher) {
    return ' • Lehrer: $teacher';
  }

  @override
  String get vibrationTest => '🔔 PushAssist Vibration Test';

  @override
  String get vibrationTestMessage =>
      'Diese Benachrichtigung sollte vibrieren! Prüfen Sie Ihre Geräteeinstellungen falls nicht.';

  @override
  String get monday => 'Mo';

  @override
  String get tuesday => 'Di';

  @override
  String get wednesday => 'Mi';

  @override
  String get thursday => 'Do';

  @override
  String get friday => 'Fr';

  @override
  String get saturday => 'Sa';

  @override
  String get sunday => 'So';

  @override
  String get january => 'Januar';

  @override
  String get february => 'Februar';

  @override
  String get march => 'März';

  @override
  String get april => 'April';

  @override
  String get may => 'Mai';

  @override
  String get june => 'Juni';

  @override
  String get july => 'Juli';

  @override
  String get august => 'August';

  @override
  String get september => 'September';

  @override
  String get october => 'Oktober';

  @override
  String get november => 'November';

  @override
  String get december => 'Dezember';

  @override
  String get studentIdCardTooltip => 'Schülerausweis';

  @override
  String get customizeHomepageTooltip => 'Start-Seite anpassen';

  @override
  String get switchAccountButton => 'Account wechseln';

  @override
  String get fetchingAppInfo => 'App-Informationen abrufen...';

  @override
  String get checkingUpdatesInitialization => 'Updates überprüfen...';

  @override
  String get loadingData => 'Daten laden...';

  @override
  String get finalizingInitialization => 'Initialisierung abschließen...';

  @override
  String errorCheckingUpdatesDetails(Object error) {
    return 'Fehler beim Suchen nach Updates: $error';
  }

  @override
  String get minute => 'Minute';

  @override
  String get beforeClass => 'vor dem Unterricht';

  @override
  String get notificationPermissions => 'Benachrichtigungsberechtigungen';

  @override
  String get notificationPermissionsDescription =>
      'Um rechtzeitig Benachrichtigungen über Ihren Unterricht zu erhalten, erteilen Sie bitte die folgenden Berechtigungen:';

  @override
  String get notificationPermission => 'Benachrichtigungen';

  @override
  String get notificationPermissionDesc =>
      'Schuly erlauben, Ihnen Benachrichtigungen zu senden';

  @override
  String get exactAlarmPermission => 'Exakte Alarme';

  @override
  String get exactAlarmPermissionDesc =>
      'Erforderlich für präzise Benachrichtigungszeiten';

  @override
  String get batteryOptimization => 'Akkuoptimierung';

  @override
  String get batteryOptimizationDesc =>
      'Akkuoptimierung deaktivieren für zuverlässige Benachrichtigungen';

  @override
  String get grant => 'Erteilen';

  @override
  String get allPermissionsGranted =>
      'Alle Berechtigungen erteilt! Benachrichtigungen funktionieren zuverlässig.';

  @override
  String get somePermissionsMissing =>
      'Einige Berechtigungen fehlen. Benachrichtigungen funktionieren möglicherweise nicht wie erwartet.';

  @override
  String get remindLater => 'Später erinnern';

  @override
  String get continueAnyway => 'Trotzdem fortfahren';

  @override
  String get done => 'Fertig';

  @override
  String get checkPermissions => 'Berechtigungen prüfen';

  @override
  String get relatedNotices => 'Zugehörige Meldungen';

  @override
  String get exam => 'Prüfung';

  @override
  String get date => 'Datum';

  @override
  String get time => 'Zeit';

  @override
  String get studentReason => 'Begründung des Schülers';

  @override
  String get trainerComment => 'Kommentar des Lehrers';

  @override
  String get unexcusedAbsences => 'Unentschuldigte Absenzen';
}
