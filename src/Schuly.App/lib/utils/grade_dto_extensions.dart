import 'package:schuly/api/lib/api.dart';

/// Extension to properly deserialize GradeDto from API responses where numeric fields are returned as numbers
extension GradeDtoExtension on GradeDto {
  /// Creates a properly deserialized GradeDto from JSON, handling numeric types
  static GradeDto? fromJsonWithNumericSupport(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Custom parsing that handles numeric types for mark, points, weight
      return GradeDto(
        id: _mapValueOfType<String>(json, r'id'),
        course: _mapValueOfType<String>(json, r'course'),
        courseId: _mapValueOfType<String>(json, r'courseId'),
        courseType: _mapValueOfType<String>(json, r'courseType'),
        subject: _mapValueOfType<String>(json, r'subject'),
        subjectToken: _mapValueOfType<String>(json, r'subjectToken'),
        title: _mapValueOfType<String>(json, r'title'),
        date: _mapValueOfType<String>(json, r'date'),
        mark: _mapNumericValue(json, r'mark'),
        points: _mapNumericValue(json, r'points'),
        weight: _mapNumericValue(json, r'weight'),
        isConfirmed: _mapValueOfType<bool>(json, r'isConfirmed'),
        courseGrade: _mapValueOfType<String>(json, r'courseGrade'),
        examinationGroups: ExaminationGroupsDto.fromJson(json[r'examinationGroups']),
        studentId: _mapValueOfType<String>(json, r'studentId'),
        studentName: _mapValueOfType<String>(json, r'studentName'),
        inputType: _mapValueOfType<String>(json, r'inputType'),
        comment: _mapValueOfType<String>(json, r'comment'),
      );
    }
    return null;
  }

  /// Maps a numeric value from JSON, converting it to a string
  /// Handles both numeric types (int, double, num) and string types
  static String? _mapNumericValue(Map<String, dynamic> json, String key) {
    if (!json.containsKey(key)) {
      return null;
    }
    final value = json[key];
    if (value == null) {
      return null;
    }
    if (value is num) {
      return value.toString();
    }
    if (value is String) {
      return value;
    }
    return null;
  }

  /// Generic helper to map values, similar to mapValueOfType from generated code
  static T? _mapValueOfType<T>(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is T) {
      return value;
    }
    return null;
  }
}
