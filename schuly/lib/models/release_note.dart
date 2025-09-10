class ReleaseNote {
  final String version;
  final DateTime releaseDate;
  final String title;
  final String description;
  final List<String> features;
  final List<String> bugFixes;
  final List<String> improvements;
  final bool isImportant;

  const ReleaseNote({
    required this.version,
    required this.releaseDate,
    required this.title,
    required this.description,
    this.features = const [],
    this.bugFixes = const [],
    this.improvements = const [],
    this.isImportant = false,
  });

  factory ReleaseNote.fromJson(Map<String, dynamic> json) {
    return ReleaseNote(
      version: json['version'] ?? '',
      releaseDate: DateTime.parse(json['release_date'] ?? DateTime.now().toIso8601String()),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      features: List<String>.from(json['features'] ?? []),
      bugFixes: List<String>.from(json['bug_fixes'] ?? []),
      improvements: List<String>.from(json['improvements'] ?? []),
      isImportant: json['is_important'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'release_date': releaseDate.toIso8601String(),
      'title': title,
      'description': description,
      'features': features,
      'bug_fixes': bugFixes,
      'improvements': improvements,
      'is_important': isImportant,
    };
  }
}