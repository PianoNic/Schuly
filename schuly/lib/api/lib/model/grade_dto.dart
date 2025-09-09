//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GradeDto {
  /// Returns a new [GradeDto] instance.
  GradeDto({
    required this.id,
    required this.course,
    required this.courseId,
    required this.courseType,
    required this.subject,
    required this.subjectToken,
    required this.title,
    required this.date,
    required this.mark,
    this.points,
    required this.weight,
    required this.isConfirmed,
    required this.courseGrade,
    required this.examinationGroups,
    this.studentId,
    this.studentName,
    required this.inputType,
    this.comment,
  });

  String id;

  String course;

  String courseId;

  String courseType;

  String subject;

  String subjectToken;

  String title;

  String date;

  String mark;

  String? points;

  String weight;

  bool isConfirmed;

  String courseGrade;

  ExaminationGroupsDto examinationGroups;

  String? studentId;

  String? studentName;

  String inputType;

  String? comment;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GradeDto &&
    other.id == id &&
    other.course == course &&
    other.courseId == courseId &&
    other.courseType == courseType &&
    other.subject == subject &&
    other.subjectToken == subjectToken &&
    other.title == title &&
    other.date == date &&
    other.mark == mark &&
    other.points == points &&
    other.weight == weight &&
    other.isConfirmed == isConfirmed &&
    other.courseGrade == courseGrade &&
    other.examinationGroups == examinationGroups &&
    other.studentId == studentId &&
    other.studentName == studentName &&
    other.inputType == inputType &&
    other.comment == comment;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (course.hashCode) +
    (courseId.hashCode) +
    (courseType.hashCode) +
    (subject.hashCode) +
    (subjectToken.hashCode) +
    (title.hashCode) +
    (date.hashCode) +
    (mark.hashCode) +
    (points == null ? 0 : points!.hashCode) +
    (weight.hashCode) +
    (isConfirmed.hashCode) +
    (courseGrade.hashCode) +
    (examinationGroups.hashCode) +
    (studentId == null ? 0 : studentId!.hashCode) +
    (studentName == null ? 0 : studentName!.hashCode) +
    (inputType.hashCode) +
    (comment == null ? 0 : comment!.hashCode);

  @override
  String toString() => 'GradeDto[id=$id, course=$course, courseId=$courseId, courseType=$courseType, subject=$subject, subjectToken=$subjectToken, title=$title, date=$date, mark=$mark, points=$points, weight=$weight, isConfirmed=$isConfirmed, courseGrade=$courseGrade, examinationGroups=$examinationGroups, studentId=$studentId, studentName=$studentName, inputType=$inputType, comment=$comment]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'course'] = this.course;
      json[r'courseId'] = this.courseId;
      json[r'courseType'] = this.courseType;
      json[r'subject'] = this.subject;
      json[r'subjectToken'] = this.subjectToken;
      json[r'title'] = this.title;
      json[r'date'] = this.date;
      json[r'mark'] = this.mark;
    if (this.points != null) {
      json[r'points'] = this.points;
    } else {
      json[r'points'] = null;
    }
      json[r'weight'] = this.weight;
      json[r'isConfirmed'] = this.isConfirmed;
      json[r'courseGrade'] = this.courseGrade;
      json[r'examinationGroups'] = this.examinationGroups;
    if (this.studentId != null) {
      json[r'studentId'] = this.studentId;
    } else {
      json[r'studentId'] = null;
    }
    if (this.studentName != null) {
      json[r'studentName'] = this.studentName;
    } else {
      json[r'studentName'] = null;
    }
      json[r'inputType'] = this.inputType;
    if (this.comment != null) {
      json[r'comment'] = this.comment;
    } else {
      json[r'comment'] = null;
    }
    return json;
  }

  /// Returns a new [GradeDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GradeDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GradeDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GradeDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GradeDto(
        id: mapValueOfType<String>(json, r'id')!,
        course: mapValueOfType<String>(json, r'course')!,
        courseId: mapValueOfType<String>(json, r'courseId')!,
        courseType: mapValueOfType<String>(json, r'courseType')!,
        subject: mapValueOfType<String>(json, r'subject')!,
        subjectToken: mapValueOfType<String>(json, r'subjectToken')!,
        title: mapValueOfType<String>(json, r'title')!,
        date: mapValueOfType<String>(json, r'date')!,
        mark: mapValueOfType<String>(json, r'mark')!,
        points: mapValueOfType<String>(json, r'points'),
        weight: mapValueOfType<String>(json, r'weight')!,
        isConfirmed: mapValueOfType<bool>(json, r'isConfirmed')!,
        courseGrade: mapValueOfType<String>(json, r'courseGrade')!,
        examinationGroups: ExaminationGroupsDto.fromJson(json[r'examinationGroups'])!,
        studentId: mapValueOfType<String>(json, r'studentId'),
        studentName: mapValueOfType<String>(json, r'studentName'),
        inputType: mapValueOfType<String>(json, r'inputType')!,
        comment: mapValueOfType<String>(json, r'comment'),
      );
    }
    return null;
  }

  static List<GradeDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GradeDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GradeDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GradeDto> mapFromJson(dynamic json) {
    final map = <String, GradeDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GradeDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GradeDto-objects as value to a dart map
  static Map<String, List<GradeDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GradeDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GradeDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'course',
    'courseId',
    'courseType',
    'subject',
    'subjectToken',
    'title',
    'date',
    'mark',
    'weight',
    'isConfirmed',
    'courseGrade',
    'examinationGroups',
    'inputType',
  };
}

