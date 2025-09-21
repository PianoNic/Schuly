// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Schuly';

  @override
  String get noAccountAdded => 'Nog geen account toegevoegd.';

  @override
  String get addAccount => 'Account toevoegen';

  @override
  String get noActiveAccount => 'Geen actief account geselecteerd.';

  @override
  String get selectAccount => 'Account selecteren';

  @override
  String get personalInformation => 'Persoonlijke gegevens';

  @override
  String get quickActions => 'Snelle acties';

  @override
  String get appSettings => 'App-instellingen';

  @override
  String get designAndSettings => 'Ontwerp en instellingen aanpassen';

  @override
  String get helpAndSupport => 'Hulp & Ondersteuning';

  @override
  String get getHelpAndSupport => 'Krijg hulp en ondersteuning';

  @override
  String get emailSupport => 'E-mail ondersteuning';

  @override
  String get contactByEmail => 'Neem direct contact met mij op via e-mail';

  @override
  String get bugReport => 'Bug rapport / Functieverzoek';

  @override
  String get reportBugsOrRequestFeatures =>
      'Meld bugs of vraag nieuwe functies aan';

  @override
  String get copy => 'Kopiëren';

  @override
  String get copiedToClipboard => 'Gekopieerd naar klembord';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Fout';

  @override
  String emailAppError(Object email) {
    return 'Kon e-mail app niet openen. Neem handmatig contact met ons op via: $email';
  }

  @override
  String browserError(Object url) {
    return 'Kon browser niet openen. Bezoek handmatig: $url';
  }

  @override
  String get addAnotherAccount => 'Ander account toevoegen';

  @override
  String get addMultipleAccounts => 'Meerdere accounts toevoegen';

  @override
  String get logout => 'Uitloggen';

  @override
  String get signOutFromApp => 'Uitloggen uit de app';

  @override
  String get name => 'Naam';

  @override
  String get street => 'Straat';

  @override
  String get zipCity => 'Postcode Plaats';

  @override
  String get birthDate => 'Geboortedatum';

  @override
  String get phone => 'Telefoon';

  @override
  String get email => 'E-mail';

  @override
  String get nationality => 'Nationaliteit';

  @override
  String get hometown => 'Woonplaats';

  @override
  String get mobile => 'Mobiel';

  @override
  String get profile1 => 'Profiel 1';

  @override
  String get profile2 => 'Profiel 2';

  @override
  String get start => 'Start';

  @override
  String get agenda => 'Agenda';

  @override
  String get grades => 'Cijfers';

  @override
  String get absences => 'Afwezigheden';

  @override
  String get account => 'Account';

  @override
  String get language => 'Taal';

  @override
  String get selectLanguage => 'Selecteer taal';

  @override
  String get english => 'Engels';

  @override
  String get german => 'Duits';

  @override
  String get swissGerman => 'Zwitsers-Duits';

  @override
  String get pirate => 'Piraat';

  @override
  String get kawaii => 'Kawaii';

  @override
  String get arnold => 'Arnold';

  @override
  String get cancel => 'Annuleren';

  @override
  String get confirm => 'Bevestigen';

  @override
  String get pushNotifications => 'Pushmeldingen';

  @override
  String get featureInDevelopment => 'Functie in ontwikkeling';

  @override
  String get getNotified => 'Ontvang meldingen voor lessen';

  @override
  String get enableNotifications => 'Inschakelen om meldingen te ontvangen';

  @override
  String get notificationsEnabled => 'Meldingen succesvol ingeschakeld';

  @override
  String get notificationPermissionDenied =>
      'Melding toestemming geweigerd. Schakel in bij instellingen.';

  @override
  String get configureNotifications => 'Meldingen configureren';

  @override
  String get chooseTypesAndTiming => 'Kies types en timing voor meldingen';

  @override
  String get whatsNew => 'Wat is nieuw';

  @override
  String get changelogAndFeatures => 'Wijzigingslog en nieuwe functies';

  @override
  String get checkForUpdates => 'Controleer op updates';

  @override
  String get checkForNewVersions => 'Controleer op nieuwe versies';

  @override
  String get aboutApp => 'Over de app';

  @override
  String get version => 'Versie';

  @override
  String get delete => 'Verwijderen';

  @override
  String get close => 'Sluiten';

  @override
  String get add => 'Toevoegen';

  @override
  String get loading => 'Laden...';

  @override
  String get noEventsForThisDay => 'Geen evenementen voor deze dag';

  @override
  String agendaForDate(Object day, Object month, Object year) {
    return 'Agenda voor $day.$month.$year';
  }

  @override
  String get noAgendaForDay => 'Geen evenementen voor deze dag.';

  @override
  String get nextLessons => 'Volgende lessen';

  @override
  String get nextHolidays => 'Volgende vakanties';

  @override
  String get studentIdCard => 'Studentenkaart';

  @override
  String get reloadPage => 'Pagina herladen';

  @override
  String get loadingStudentIdCard => 'Studentenkaart laden...';

  @override
  String get enterValidEmail => 'Voer een geldig e-mailadres in';

  @override
  String get areYouSure => 'Weet je het zeker?';

  @override
  String get updateAvailable => 'Update beschikbaar!';

  @override
  String get later => 'Later';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nee';

  @override
  String get confirmed => 'Bevestigd';

  @override
  String get lateness => 'Vertraging';

  @override
  String get noLatenessFound => 'Geen vertragingen gevonden';

  @override
  String get selectReason => 'Selecteer een reden';

  @override
  String get selectDate => 'Selecteer een datum';

  @override
  String get emailAddress => 'E-mailadres';

  @override
  String get password => 'Wachtwoord';

  @override
  String get login => 'Inloggen';

  @override
  String get enterEmailAddress => 'Voer een e-mailadres in';

  @override
  String get getNewToken => 'Nieuw token ophalen';

  @override
  String get getNewTokenSubtitle =>
      'Haal een nieuw token op voor het actieve account';

  @override
  String get tokenUpdated => 'Token bijgewerkt!';

  @override
  String get noActiveAccountSnack => 'Geen actief account!';

  @override
  String get addAccountTitle => 'Account toevoegen';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get enterEmail => 'Voer e-mail in';

  @override
  String get passwordLabel => 'Wachtwoord';

  @override
  String get enterPassword => 'Voer wachtwoord in';

  @override
  String get accountAdded => 'Account toegevoegd!';

  @override
  String get logoutTitle => 'Uitloggen';

  @override
  String get logoutConfirm => 'Weet je zeker dat je wilt uitloggen?';

  @override
  String get loggedOut => 'Uitgelogd!';

  @override
  String get designSettings => 'Ontwerp instellingen';

  @override
  String get appearance => 'Uiterlijk';

  @override
  String get automatic => 'Automatisch';

  @override
  String get light => 'Licht';

  @override
  String get dark => 'Donker';

  @override
  String get colorStyle => 'Kleurstijl';

  @override
  String get materialYou => 'Material\nYou';

  @override
  String get classic => 'Klassiek';

  @override
  String get neon => 'Neon';

  @override
  String get neonAccentColor => 'Neon accent kleur';

  @override
  String get classicAccentColor => 'Klassieke accent kleur';

  @override
  String get materialYouActive => 'Material You actief';

  @override
  String get materialYouInfo =>
      'Kleuren worden automatisch overgenomen van het systeemthema.';

  @override
  String get neonViolet => 'Neon violet';

  @override
  String get neonCyan => 'Neon cyaan';

  @override
  String get neonGreen => 'Neon groen';

  @override
  String get neonPink => 'Neon roze';

  @override
  String get neonOrange => 'Neon oranje';

  @override
  String get neonBlue => 'Neon blauw';

  @override
  String get neonRed => 'Neon rood';

  @override
  String get neonYellow => 'Neon geel';

  @override
  String get neonMint => 'Neon mint';

  @override
  String get blue => 'Blauw';

  @override
  String get teal => 'Turkoois';

  @override
  String get green => 'Groen';

  @override
  String get pink => 'Roze';

  @override
  String get orange => 'Oranje';

  @override
  String get indigo => 'Indigo';

  @override
  String get red => 'Rood';

  @override
  String get yellow => 'Geel';

  @override
  String get purple => 'Paars';

  @override
  String get previousLessonsDay => 'Vorige dag met lessen';

  @override
  String get nextLessonsDay => 'Volgende dag met lessen';

  @override
  String get noLessonsFound => 'Geen lessen gevonden.';

  @override
  String noLessonsForDay(Object day, Object month, Object year) {
    return 'Geen lessen voor $day.$month.$year';
  }

  @override
  String get noHolidaysFound => 'Geen vakanties gevonden.';

  @override
  String get latestGrades => 'Laatste cijfers';

  @override
  String get noGradesFound => 'Geen cijfers gevonden.';

  @override
  String get openAbsences => 'Open afwezigheden';

  @override
  String get showAll => 'Toon alles';

  @override
  String get noAbsencesFound => 'Geen afwezigheden gevonden.';

  @override
  String get noOpenAbsences => 'Geen open afwezigheden.';

  @override
  String get noReleaseNotes => 'Geen release notes beschikbaar';

  @override
  String get releaseNotesInfo =>
      'Updates en nieuwe functies worden hier getoond';

  @override
  String get notificationTypes => 'Melding types';

  @override
  String get timetable => 'Rooster';

  @override
  String get agendaNotificationSubtitle => 'Meldingen voor lessen';

  @override
  String get gradeNotificationSubtitle => 'Meldingen voor nieuwe cijfers';

  @override
  String get absenceNotificationSubtitle =>
      'Meldingen voor afwezigheidswijzigingen';

  @override
  String get generalNotifications => 'Algemene meldingen';

  @override
  String get generalNotificationSubtitle =>
      'Belangrijke schoolinformatie en updates';

  @override
  String get notificationTime => 'Meldingstijd';

  @override
  String get notificationAdvanceQuestion =>
      'Hoeveel minuten voor de les wil je een melding ontvangen?';

  @override
  String minutesBeforeClass(Object minutes) {
    return '$minutes min';
  }

  @override
  String currentAdvanceSetting(Object minutes) {
    return 'Huidige instelling: $minutes minuten voor de les';
  }

  @override
  String get test => 'Test';

  @override
  String get sendTestNotification => 'Stuur testmelding';

  @override
  String get checkNotificationsWork => 'Controleer of meldingen werken';

  @override
  String get scheduleTestNotification => 'Plan testmelding';

  @override
  String get testScheduledNotificationDesc =>
      'Ontvang een melding over 15 seconden (werkt wanneer app gesloten is)';

  @override
  String get notificationScheduledIn15Seconds =>
      'Melding gepland! Sluit de app om te testen - verschijnt over 15 seconden';

  @override
  String get errorSchedulingNotification => 'Melding plannen mislukt';

  @override
  String get testNotificationSent => 'Testmelding verzonden!';

  @override
  String get exactAlarmPermissionRequired =>
      'Exacte alarm toestemming vereist. Schakel in bij instellingen.';

  @override
  String get openSettings => 'Open instellingen';

  @override
  String get gradeDetails => 'Cijfer details';

  @override
  String get basicInformation => 'Basisinformatie';

  @override
  String get titleLabel => 'Titel';

  @override
  String get subjectLabel => 'Vak';

  @override
  String get courseLabel => 'Cursus';

  @override
  String get dateLabel => 'Datum';

  @override
  String get confirmedLabel => 'Bevestigd';

  @override
  String get gradeLabel => 'Cijfer';

  @override
  String get pointsLabel => 'Punten';

  @override
  String get weightLabel => 'Gewicht';

  @override
  String get courseGradeLabel => 'Cursuscijfer';

  @override
  String get classAverage => 'Klasgemiddelde';

  @override
  String get examGroupLabel => 'Examengroep';

  @override
  String get classAverageLabel => 'Klasgemiddelde';

  @override
  String get groupWeightLabel => 'Groepsgewicht';

  @override
  String get commentLabel => 'Opmerking';

  @override
  String get latestVersionMessage => 'Je gebruikt al de nieuwste versie.';

  @override
  String versionWithNumber(Object version, Object build) {
    return 'Versie $version+$build';
  }

  @override
  String get appLegalese => 'Schuly © 2025 PianoNic';

  @override
  String get appDescription =>
      'Een aangepaste app voor studenten om Schulnetz-gegevens te beheren. Beheer je rooster, cijfers en belangrijke data op één plek.';

  @override
  String get apiEndpoint => 'API-eindpunt';

  @override
  String get enterApiEndpoint => 'Voer API-eindpunt in';

  @override
  String get currentApiInfo => 'Huidige API-info';

  @override
  String get apiInfoStatus => 'API-info status';

  @override
  String get environment => 'Omgeving';

  @override
  String get apiBaseUrl => 'API basis URL';

  @override
  String get save => 'Opslaan';

  @override
  String apiUrlChanged(Object url) {
    return 'API URL gewijzigd: $url';
  }

  @override
  String get getColorName => 'Krijg kleurnaam';

  @override
  String get lessonBreak => 'Pauze';

  @override
  String get lunchBreak => 'Lunchpauze';

  @override
  String get showBreaks => 'Toon pauzes tussen lessen';

  @override
  String get cardSettings => 'Kaartinstellingen';

  @override
  String get tapToCustomize => 'Tik om aan te passen';

  @override
  String get numberOfDaysToShow => 'Aantal dagen om te tonen';

  @override
  String get numberOfGradesToShow => 'Aantal cijfers om te tonen';

  @override
  String get showOnlyOpenAbsences => 'Toon alleen open afwezigheden';

  @override
  String get noConfigurationAvailable =>
      'Geen configuratie-instellingen beschikbaar';

  @override
  String get switchAccount => 'Account wisselen';

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
  String get noAccounts => 'Geen accounts beschikbaar.';

  @override
  String get addFirstAccount => 'Voeg je eerste account toe om te beginnen!';

  @override
  String get active => 'Actief';

  @override
  String get available => 'Beschikbaar';

  @override
  String get removeAccount => 'Account verwijderen';

  @override
  String confirmRemoveAccount(Object email) {
    return 'Account $email verwijderen?';
  }

  @override
  String get remove => 'Verwijderen';

  @override
  String switchedAccount(Object email) {
    return 'Gewisseld naar $email';
  }

  @override
  String switchAccountError(Object error) {
    return 'Account wisselen mislukt: $error';
  }

  @override
  String removedAccount(Object email) {
    return 'Account $email verwijderd';
  }

  @override
  String removeAccountError(Object error) {
    return 'Account verwijderen mislukt: $error';
  }

  @override
  String unexpectedError(Object error) {
    return 'Onverwachte fout: $error';
  }

  @override
  String get weekdayMon => 'Ma';

  @override
  String get weekdayTue => 'Di';

  @override
  String get weekdayWed => 'Wo';

  @override
  String get weekdayThu => 'Do';

  @override
  String get weekdayFri => 'Vr';

  @override
  String get weekdaySat => 'Za';

  @override
  String get weekdaySun => 'Zo';

  @override
  String get absencesTabAll => 'Alle afwezigheden';

  @override
  String get absencesTabLateness => 'Vertraging';

  @override
  String get absencesTabAbsences => 'Afwezigheden';

  @override
  String get absencesTabNotices => 'Meldingen';

  @override
  String get absencesSection => 'Afwezigheden';

  @override
  String get latenessSection => 'Vertraging';

  @override
  String get noticesSection => 'Meldingen';

  @override
  String get noticeItem => 'Melding';

  @override
  String get noReasonGiven => 'Geen reden opgegeven';

  @override
  String get noCommentGiven => 'Geen opmerking opgegeven';

  @override
  String get unknownData => 'Onbekende gegevens';

  @override
  String get noNoticesFound => 'Geen meldingen gevonden.';

  @override
  String get minutes => 'min';

  @override
  String get hours => 'uur';

  @override
  String get latenessFrom => 'Vertraging vanaf';

  @override
  String get duration => 'Duur';

  @override
  String get course => 'Cursus';

  @override
  String get reason => 'Reden';

  @override
  String get comment => 'Opmerking';

  @override
  String get status => 'Status';

  @override
  String get excused => 'Geëxcuseerd';

  @override
  String get notExcused => 'Niet geëxcuseerd';

  @override
  String get from => 'Van';

  @override
  String get to => 'Tot';

  @override
  String get excuseUntil => 'Excuseren tot';

  @override
  String get details => 'Details';

  @override
  String get excuse => 'Excuus';

  @override
  String get excuseComingSoon => 'Excuus - Binnenkort!';

  @override
  String get deleteAbsenceTitle => 'Afwezigheid verwijderen';

  @override
  String get deleteAbsenceConfirm =>
      'Weet je zeker dat je deze afwezigheid wilt verwijderen? Deze actie kan niet ongedaan worden gemaakt.';

  @override
  String get absenceDeleted => 'Afwezigheid verwijderd!';

  @override
  String get appUpdateTest => 'App update test';

  @override
  String get readyToTest => 'Klaar om te testen';

  @override
  String get updateSystemTest => 'Update systeem test';

  @override
  String statusLabel(Object status) {
    return 'Status: $status';
  }

  @override
  String get checking => 'Controleren...';

  @override
  String get forceShowUpdateDialog => 'Forceer update dialoog';

  @override
  String get clearDismissedUpdates => 'Wis afgewezen updates';

  @override
  String get howItWorks => 'Hoe het werkt:';

  @override
  String get updateStep1 =>
      '1. Controleert GitHub releases voor nieuwere versies';

  @override
  String get updateStep2 => '2. Download APK van GitHub release assets';

  @override
  String get updateStep3 => '3. Opent Android installer automatisch';

  @override
  String get updateStep4 => '4. Onthoudt afgewezen updates tot app herstart';

  @override
  String get checkingForUpdates => 'Controleren op updates...';

  @override
  String updateAvailableVersion(Object version) {
    return 'Update beschikbaar: v$version';
  }

  @override
  String get noUpdatesAvailable =>
      'Geen updates beschikbaar of update afgewezen';

  @override
  String errorCheckingUpdates(Object error) {
    return 'Fout bij controleren op updates: $error';
  }

  @override
  String get showingUpdateDialog => 'Update dialoog tonen...';

  @override
  String get updateDialogShown => 'Update dialoog getoond';

  @override
  String errorShowingDialog(Object error) {
    return 'Fout bij tonen dialoog: $error';
  }

  @override
  String get clearingDismissedUpdates => 'Afgewezen updates wissen...';

  @override
  String get dismissedUpdatesCleared => 'Afgewezen updates gewist';

  @override
  String errorClearingDismissed(Object error) {
    return 'Fout bij wissen afgewezen: $error';
  }

  @override
  String get illness => 'Ziekte';

  @override
  String get accident => 'Ongeval';

  @override
  String get military => 'Militair';

  @override
  String get medicalCertificateForSport => 'Geldig medisch attest voor sport';

  @override
  String get otherAbsence => 'Andere afwezigheid';

  @override
  String get createNewAbsence => 'Nieuwe afwezigheid aanmaken';

  @override
  String get reasonRequired => 'Reden *';

  @override
  String get create => 'Aanmaken';

  @override
  String get noError => 'Geen fout';

  @override
  String get unknown => 'Onbekend';

  @override
  String currentVersion(Object version) {
    return 'Huidig: $version';
  }

  @override
  String latestVersion(Object version) {
    return 'Laatste: $version';
  }

  @override
  String get downloadingUpdate => 'Update wordt gedownload...';

  @override
  String get installingUpdate => 'Update wordt geïnstalleerd...';

  @override
  String get install => 'Installeren';

  @override
  String get downloading => 'Downloaden...';

  @override
  String get download => 'Downloaden';

  @override
  String get installing => 'Installeren...';

  @override
  String get downloadError => 'Fout bij downloaden update';

  @override
  String downloadErrorDetails(Object error) {
    return 'Download fout: $error';
  }

  @override
  String get installationNotAllowed => 'Installatie niet toegestaan';

  @override
  String get installationError => 'Installatiefout';

  @override
  String installationErrorDetails(Object error) {
    return 'Installatiefout: $error';
  }

  @override
  String get updateInstallationStarted => 'Update installatie gestart';

  @override
  String get absentFrom => 'Afwezig vanaf *';

  @override
  String get absentTo => 'Afwezig tot *';

  @override
  String get toDateMustBeAfterFromDate => 'Einddatum moet na begindatum zijn';

  @override
  String get absentFromTime => 'Afwezig vanaf (tijd)';

  @override
  String get absentToTime => 'Afwezig tot (tijd)';

  @override
  String get absenceCreatedSuccessfully => 'Afwezigheid succesvol aangemaakt!';

  @override
  String get customizeHomepage => 'Homepage aanpassen';

  @override
  String get visible => 'Zichtbaar';

  @override
  String get hidden => 'Verborgen';

  @override
  String get pushAssistNotifications => 'PushAssist meldingen';

  @override
  String get notificationsBeforeClasses => 'Meldingen voor lessen';

  @override
  String get testNotifications => 'Test meldingen';

  @override
  String get testNotificationDescription => 'Test melding voor PushAssist';

  @override
  String nextClass(Object subject) {
    return 'Volgende les: $subject';
  }

  @override
  String roomAndTeacher(Object room, Object teacher) {
    return 'Lokaal: $room$teacher';
  }

  @override
  String teacher(Object teacher) {
    return ' • Docent: $teacher';
  }

  @override
  String get vibrationTest => '🔔 PushAssist triltest';

  @override
  String get vibrationTestMessage =>
      'Deze melding zou moeten trillen! Controleer je apparaatinstellingen als het niet werkt.';

  @override
  String get monday => 'Ma';

  @override
  String get tuesday => 'Di';

  @override
  String get wednesday => 'Wo';

  @override
  String get thursday => 'Do';

  @override
  String get friday => 'Vr';

  @override
  String get saturday => 'Za';

  @override
  String get sunday => 'Zo';

  @override
  String get january => 'Januari';

  @override
  String get february => 'Februari';

  @override
  String get march => 'Maart';

  @override
  String get april => 'April';

  @override
  String get may => 'Mei';

  @override
  String get june => 'Juni';

  @override
  String get july => 'Juli';

  @override
  String get august => 'Augustus';

  @override
  String get september => 'September';

  @override
  String get october => 'Oktober';

  @override
  String get november => 'November';

  @override
  String get december => 'December';

  @override
  String get studentIdCardTooltip => 'Studentenkaart';

  @override
  String get customizeHomepageTooltip => 'Homepage aanpassen';

  @override
  String get switchAccountButton => 'Account wisselen';

  @override
  String get fetchingAppInfo => 'App-informatie ophalen...';

  @override
  String get checkingUpdatesInitialization => 'Controleren op updates...';

  @override
  String get loadingData => 'Gegevens laden...';

  @override
  String get finalizingInitialization => 'Initialisatie afronden...';

  @override
  String get checkingConnection => 'Verbinding controleren...';

  @override
  String get offlineModeDetected =>
      'Offline modus - gecachte gegevens gebruiken';

  @override
  String get loadingCachedData => 'Gecachte gegevens laden...';

  @override
  String errorCheckingUpdatesDetails(Object error) {
    return 'Fout bij controleren op updates: $error';
  }

  @override
  String get minute => 'minuut';

  @override
  String get beforeClass => 'voor de les';

  @override
  String get notificationPermissions => 'Meldingstoestemmingen';

  @override
  String get notificationPermissionsDescription =>
      'Om tijdige meldingen over je lessen te ontvangen, verleen de volgende toestemmingen:';

  @override
  String get notificationPermission => 'Meldingen';

  @override
  String get notificationPermissionDesc =>
      'Sta Schuly toe om je meldingen te sturen';

  @override
  String get exactAlarmPermission => 'Exacte alarmen';

  @override
  String get exactAlarmPermissionDesc => 'Vereist voor precieze melding timing';

  @override
  String get batteryOptimization => 'Batterij optimalisatie';

  @override
  String get batteryOptimizationDesc =>
      'Schakel batterij optimalisatie uit voor betrouwbare meldingen';

  @override
  String get grant => 'Verlenen';

  @override
  String get allPermissionsGranted =>
      'Alle toestemmingen verleend! Meldingen werken betrouwbaar.';

  @override
  String get somePermissionsMissing =>
      'Sommige toestemmingen ontbreken. Meldingen werken mogelijk niet zoals verwacht.';

  @override
  String get remindLater => 'Later herinneren';

  @override
  String get continueAnyway => 'Toch doorgaan';

  @override
  String get done => 'Klaar';

  @override
  String get checkPermissions => 'Controleer toestemmingen';

  @override
  String get relatedNotices => 'Gerelateerde meldingen';

  @override
  String get exam => 'Examen';

  @override
  String get date => 'Datum';

  @override
  String get time => 'Tijd';

  @override
  String get studentReason => 'Student reden';

  @override
  String get trainerComment => 'Trainer opmerking';

  @override
  String get unexcusedAbsences => 'Ongeëxcuseerde afwezigheden';

  @override
  String get reAuthenticationCancelled =>
      'Her-authenticatie geannuleerd. Sommige functies werken mogelijk niet.';

  @override
  String get consoleLogs => 'Console logs';

  @override
  String get viewAppDebugLogs => 'Bekijk app debug logs';

  @override
  String get buyMeACoffee => 'Koop een koffie voor me';

  @override
  String get supportDevelopment => 'Ondersteun de ontwikkeling';

  @override
  String get couldNotOpenBuyMeACoffee =>
      'Kon Buy Me a Coffee pagina niet openen';

  @override
  String get or => 'OF';

  @override
  String get signInWithMicrosoft => 'Inloggen met Microsoft';

  @override
  String get clearLogs => 'Logs wissen';

  @override
  String get exportLogs => 'Logs exporteren';

  @override
  String get all => 'Alles';

  @override
  String get debug => 'Debug';

  @override
  String get info => 'Info';

  @override
  String get warning => 'Waarschuwing';

  @override
  String get enableLogging => 'Logging inschakelen';

  @override
  String get clearFilters => 'Filters wissen';

  @override
  String get logCopiedToClipboard => 'Log gekopieerd naar klembord';

  @override
  String get clearAllLogs => 'Alle logs wissen?';

  @override
  String get thisActionCannotBeUndone =>
      'Deze actie kan niet ongedaan worden gemaakt.';

  @override
  String get logsCleared => 'Logs gewist';

  @override
  String get clear => 'Wissen';

  @override
  String get logsExportedToClipboard => 'Logs geëxporteerd naar klembord';

  @override
  String endpointReachable(Object statusCode) {
    return 'Eindpunt bereikbaar ($statusCode)';
  }

  @override
  String serverError(Object statusCode) {
    return 'Serverfout: $statusCode';
  }

  @override
  String failedToInitializeMicrosoftAuth(Object error) {
    return 'Microsoft authenticatie initialisatie mislukt: $error';
  }

  @override
  String authenticationFailed(Object error) {
    return 'Authenticatie mislukt: $error';
  }

  @override
  String get noInternetConnection => 'Geen internetverbinding';

  @override
  String get upcomingTests => 'Aankomende toetsen';

  @override
  String get noTestsFound => 'Geen toetsen gevonden';

  @override
  String get noUpcomingTests => 'Geen aankomende toetsen';

  @override
  String get room => 'Lokaal';

  @override
  String get weight => 'Gewicht';

  @override
  String get numberOfTestsToShow => 'Aantal toetsen om te tonen';

  @override
  String get today => 'Vandaag';

  @override
  String get cardView => 'Kaartweergave';

  @override
  String get cardViewDescription =>
      'Gedetailleerde kaarten met uitklapbare test info';

  @override
  String get timelineView => 'Tijdlijn weergave';

  @override
  String get timelineViewDescription =>
      'Compacte tijdlijn met tijd-gebaseerde indeling';
}
