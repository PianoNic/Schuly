import 'dart:math';

class MarkusRuehlChecker {
  static const List<String> _ruehlPhrases = [
    'des bedarfs',
    'muss net schmegge',
    'muss wirge',
    'schwere gewichte',
    'hohes volumen',
    'maggus',
    'baddibilder',
    'bruddal',
    'appelschorle',
    'reis und fleisch',
    'busting your ass',
    'arsch aufreißen',
    'scheiße fressen',
    'scheiße aussehen',
    'verdammtes handy',
    'konzentrier dich',
    'muskelwachstum',
    'hart trainieren',
    'des isses',
    'halt mal net',
    'schwer und falsch',
    'leidenschaft',
    'kompletter schwachsinn',
    'gute figur',
    'tuna protein shake',
    'anabolisch',
    'meine liebe',
    'nicht nur business',
    'meine leidenschaft',
    'get to the choppa',
    'permanente übungen ändern',
    'vorschriftsmäßig',
    'muskulatur',
    'fitness figur',
    'veganer',
    'anderen sport machen',
    'wir machen bodybuilding',
    'aus leidenschaft',
    'nicht nur ein business',
    'unterschied',
    'kein grund',
    'permanent ändern',
    'rice and chicken',
    'train insane',
    'no pain no gain',
    'light weight baby',
    'yeah buddy',
    'schweres training',
    'brutales training',
    'hau rein',
    'zieh durch',
    'keine ausreden',
    'vollgas',
    'pumpen',
    'pump it up',
    'eisern',
    'disziplin',
    'fokussiert',
    'reiss dich zusammen',
    'gib alles',
    '110 prozent',
    'mr. olympia',
    'hardcore',
    'no excuses',
    'beast mode',
  ];

  static const List<String> _hessianPatterns = [
    'net', // nicht
    'des', // das
    'isses', // ist es
    'appel', // apfel
    'schmegge', // schmecken
    'wirge', // wirken
    'bruddal', // brutal
    'ei gude', // guten tag
    'ebbes', // etwas
    'babba', // vater
    'gude', // guten/gute
    'uff', // auf
    'fer', // für
    'awwer', // aber
    'gudde', // guten
    'degege', // dagegen
    'dezu', // dazu
    'druff', // drauf
    'drin', // drin
    'nix', // nichts
    'gell', // nicht wahr
    'aach', // auch
    'unn', // und
    'isch', // ich
    'mer', // wir
    'se', // sie
    'de', // der/die
    'en', // ein
    'anner', // andere
    'bleede', // blöde
    'guud', // gut
    'schleschd', // schlecht
    'groß', // groß
    'klaa', // klein
    'alde', // alte
    'neie', // neue
    'hawwe', // haben
    'kumme', // kommen
    'mache', // machen
    'gewwe', // geben
    'nemme', // nehmen
  ];

  static const List<String> _motivationalQuotes = [
    'Des bedarfs! 💪',
    'Muss net schmegge, muss wirge!',
    'Schwere Gewichte, hohes Volumen - Muskelwachstum!',
    'Kraft kommt nicht von nichts!',
    'Hart trainieren, gut fressen!',
    'Reis und Fleisch - des isses!',
    'Konzentrier dich auf dein verdammtes Training!',
    'Des macht den Maggus stark!',
    'Bruddal durchziehen!',
    'Appelschorle und ab ins Gym!',
    'Schwer und falsch - aber es wirkt!',
    'Es gibt keinen Grund Übungen permanent zu ändern!',
    'Wir machen Bodybuilding aus Leidenschaft!',
    'Wenn du Scheiße frisst, wirst du scheiße aussehen!',
    'Von Veganern rede ich nicht - die sollen einen anderen Sport machen!',
    'Es ist halt mal net immer lecker, aber des bedarfs!',
    'Busting your ass - des is Training!',
    'Arsch aufreißen für die Gains!',
    'Vorschriftsmäßig muss das Handtuch dahin gelegt werden, wo es nicht gebraucht wird!',
    'Des is meine Leidenschaft, meine Liebe und nicht nur ein Business!',
    'Ohne schwere Gewichte keine schwere Muskulatur!',
    'Training is wie Krieg - gib alles oder geh heim!',
    'Jeden Tag Reis und Hühnchen - des macht Champions!',
    'Pumpen bis zum Anschlag - des is Bodybuilding!',
    '110 Prozent im Gym, keine halben Sachen!',
    'Hardcore oder gar net - des is die Devise!',
    'Beast Mode aktiviert - jetzt wird trainiert!',
    'No pain, no gain - so einfach isses!',
    'Disziplin und Fokus - des macht den Unterschied!',
    'Vollgas im Training, Vollgas im Leben!',
    'Hau rein und zieh durch - keine Ausreden!',
    'Light weight baby? Net bei mir - schwer muss es sein!',
    'Yeah buddy! Noch ein Satz für den Maggus!',
    'Eisern bleiben - des is der Weg zum Erfolg!',
    'Get to the choppa - aber erst nach dem Training!',
    'Mr. Olympia? Des bedarfs harte Arbeit!',
    'Train insane or remain the same!',
    'Reiss dich zusammen und gib alles!',
  ];

  static MarkusRuehlResult checkText(String text) {
    final lowerText = text.toLowerCase();
    int score = 0;
    List<String> foundPhrases = [];
    List<String> foundHessian = [];

    // Check for Rühl-specific phrases
    for (final phrase in _ruehlPhrases) {
      if (lowerText.contains(phrase)) {
        score += 10;
        foundPhrases.add(phrase);
      }
    }

    // Check for Hessian dialect patterns
    for (final pattern in _hessianPatterns) {
      // Check word boundaries to avoid false positives
      final regex = RegExp(r'\b' + pattern + r'\b');
      if (regex.hasMatch(lowerText)) {
        score += 5;
        foundHessian.add(pattern);
      }
    }

    // Special bonus for signature phrases
    if (lowerText.contains('des bedarfs')) score += 20;
    if (lowerText.contains('muss net schmegge') && lowerText.contains('muss wirge')) score += 30;
    if (lowerText.contains('maggus')) score += 15;

    // Check for training/bodybuilding context
    final trainingWords = ['training', 'gym', 'gewichte', 'muskel', 'bodybuilding', 'fitness'];
    for (final word in trainingWords) {
      if (lowerText.contains(word)) score += 3;
    }

    return MarkusRuehlResult(
      score: score,
      foundPhrases: foundPhrases,
      foundHessian: foundHessian,
      level: _getLevel(score),
      motivationalQuote: _getRandomQuote(),
    );
  }

  static MaggusLevel _getLevel(int score) {
    if (score >= 100) return MaggusLevel.legend;
    if (score >= 70) return MaggusLevel.bruddal;
    if (score >= 40) return MaggusLevel.solid;
    if (score >= 20) return MaggusLevel.beginner;
    return MaggusLevel.none;
  }

  static String _getRandomQuote() {
    final random = Random();
    return _motivationalQuotes[random.nextInt(_motivationalQuotes.length)];
  }

  static String transformToMaggus(String text) {
    String result = text;

    // Comprehensive Hessian transformations
    result = result.replaceAll('nicht', 'net');
    result = result.replaceAll('Nicht', 'Net');
    result = result.replaceAll('das', 'des');
    result = result.replaceAll('Das', 'Des');
    result = result.replaceAll('ist es', 'isses');
    result = result.replaceAll('Ist es', 'Isses');
    result = result.replaceAll('ist das', 'is des');
    result = result.replaceAll('Ist das', 'Is des');
    result = result.replaceAll('etwas', 'ebbes');
    result = result.replaceAll('Etwas', 'Ebbes');
    result = result.replaceAll('Apfel', 'Appel');
    result = result.replaceAll('schmecken', 'schmegge');
    result = result.replaceAll('schmeckt', 'schmeggt');
    result = result.replaceAll('wirken', 'wirge');
    result = result.replaceAll('wirkt', 'wirgt');
    result = result.replaceAll('brutal', 'bruddal');
    result = result.replaceAll('Brutal', 'Bruddal');
    result = result.replaceAll('guten', 'gudde');
    result = result.replaceAll('Guten', 'Gudde');
    result = result.replaceAll('auf', 'uff');
    result = result.replaceAll('Auf', 'Uff');
    result = result.replaceAll('für', 'fer');
    result = result.replaceAll('Für', 'Fer');
    result = result.replaceAll('aber', 'awwer');
    result = result.replaceAll('Aber', 'Awwer');
    result = result.replaceAll('nichts', 'nix');
    result = result.replaceAll('Nichts', 'Nix');
    result = result.replaceAll('auch', 'aach');
    result = result.replaceAll('Auch', 'Aach');
    result = result.replaceAll('und', 'unn');
    result = result.replaceAll('Und', 'Unn');
    result = result.replaceAll('ich', 'isch');
    result = result.replaceAll('Ich', 'Isch');
    result = result.replaceAll('ein', 'en');
    result = result.replaceAll('Ein', 'En');
    result = result.replaceAll('andere', 'anner');
    result = result.replaceAll('Andere', 'Anner');
    result = result.replaceAll('gut', 'guud');
    result = result.replaceAll('Gut', 'Guud');
    result = result.replaceAll('schlecht', 'schleschd');
    result = result.replaceAll('Schlecht', 'Schleschd');
    result = result.replaceAll('klein', 'klaa');
    result = result.replaceAll('Klein', 'Klaa');
    result = result.replaceAll('haben', 'hawwe');
    result = result.replaceAll('Haben', 'Hawwe');
    result = result.replaceAll('kommen', 'kumme');
    result = result.replaceAll('Kommen', 'Kumme');
    result = result.replaceAll('machen', 'mache');
    result = result.replaceAll('Machen', 'Mache');
    result = result.replaceAll('geben', 'gewwe');
    result = result.replaceAll('Geben', 'Gewwe');
    result = result.replaceAll('nehmen', 'nemme');
    result = result.replaceAll('Nehmen', 'Nemme');

    // Bodybuilding specific transformations
    result = result.replaceAll('Training', 'Training, des bedarfs');
    result = result.replaceAll('trainieren', 'trainiere bruddal');
    result = result.replaceAll('Gewichte', 'schwere Gewichte');
    result = result.replaceAll('essen', 'fresse');
    result = result.replaceAll('Essen', 'Fresse');
    result = result.replaceAll('Fitness', 'Fitness - des isses');
    result = result.replaceAll('Bodybuilding', 'Baddibilding');
    result = result.replaceAll('Muskeln', 'Muskulatur');

    // Add random Maggus phrases
    final random = Random();
    final randomValue = random.nextDouble();
    if (randomValue > 0.8) {
      result += ' Des bedarfs!';
    } else if (randomValue > 0.6) {
      result += ' Muss net schmegge, muss wirge!';
    } else if (randomValue > 0.4) {
      result += ' Schwere Gewichte, hohes Volumen!';
    } else if (randomValue > 0.2) {
      result += ' Bruddal durchziehe!';
    }

    return result;
  }
}

enum MaggusLevel {
  none('Noch kein Maggus', '😐'),
  beginner('Maggus-Anfänger', '💪'),
  solid('Solider Maggus', '💪💪'),
  bruddal('Bruddaler Maggus', '💪💪💪'),
  legend('Maggus-Legende', '🏆💪');

  final String label;
  final String emoji;

  const MaggusLevel(this.label, this.emoji);
}

class MarkusRuehlResult {
  final int score;
  final List<String> foundPhrases;
  final List<String> foundHessian;
  final MaggusLevel level;
  final String motivationalQuote;

  MarkusRuehlResult({
    required this.score,
    required this.foundPhrases,
    required this.foundHessian,
    required this.level,
    required this.motivationalQuote,
  });

  String get summary {
    if (score == 0) {
      return 'Kein Maggus-Style erkannt. Des muss besser werden!';
    }

    String result = 'Maggus-Score: $score\n';
    result += 'Level: ${level.emoji} ${level.label}\n';

    if (foundPhrases.isNotEmpty) {
      result += '\nGefundene Maggus-Phrasen:\n';
      for (final phrase in foundPhrases) {
        result += '• $phrase\n';
      }
    }

    if (foundHessian.isNotEmpty) {
      result += '\nHessischer Dialekt:\n';
      for (final word in foundHessian) {
        result += '• $word\n';
      }
    }

    result += '\n💪 $motivationalQuote';

    return result;
  }
}