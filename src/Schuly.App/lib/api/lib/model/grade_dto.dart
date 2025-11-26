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
    this.id,
    this.course,
    this.courseId,
    this.courseType,
    this.examId,
    this.subject,
    this.subjectToken,
    this.title,
    this.date,
    this.mark,
    this.points,
    this.weight,
    this.isConfirmed,
    this.isConfirmedByTrainer,
    this.courseGrade,
    this.examinationGroups,
    this.studentId,
    this.studentName,
    this.inputType,
    this.comment,
  });

  String? id;

  String? course;

  String? courseId;

  String? courseType;

  String? examId;

  String? subject;

  String? subjectToken;

  String? title;

  String? date;

  num? mark;

  num? points;

  num? weight;

  bool? isConfirmed;

  bool? isConfirmedByTrainer;

  num? courseGrade;

  ExaminationGroupsDto? examinationGroups;

  String? studentId;

  String? studentName;

  String? inputType;

  String? comment;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GradeDto &&
    other.id == id &&
    other.course == course &&
    other.courseId == courseId &&
    other.courseType == courseType &&
    other.examId == examId &&
    other.subject == subject &&
    other.subjectToken == subjectToken &&
    other.title == title &&
    other.date == date &&
    other.mark == mark &&
    other.points == points &&
    other.weight == weight &&
    other.isConfirmed == isConfirmed &&
    other.isConfirmedByTrainer == isConfirmedByTrainer &&
    other.courseGrade == courseGrade &&
    other.examinationGroups == examinationGroups &&
    other.studentId == studentId &&
    other.studentName == studentName &&
    other.inputType == inputType &&
    other.comment == comment;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (course == null ? 0 : course!.hashCode) +
    (courseId == null ? 0 : courseId!.hashCode) +
    (courseType == null ? 0 : courseType!.hashCode) +
    (examId == null ? 0 : examId!.hashCode) +
    (subject == null ? 0 : subject!.hashCode) +
    (subjectToken == null ? 0 : subjectToken!.hashCode) +
    (title == null ? 0 : title!.hashCode) +
    (date == null ? 0 : date!.hashCode) +
    (mark == null ? 0 : mark!.hashCode) +
    (points == null ? 0 : points!.hashCode) +
    (weight == null ? 0 : weight!.hashCode) +
    (isConfirmed == null ? 0 : isConfirmed!.hashCode) +
    (isConfirmedByTrainer == null ? 0 : isConfirmedByTrainer!.hashCode) +
    (courseGrade == null ? 0 : courseGrade!.hashCode) +
    (examinationGroups == null ? 0 : examinationGroups!.hashCode) +
    (studentId == null ? 0 : studentId!.hashCode) +
    (studentName == null ? 0 : studentName!.hashCode) +
    (inputType == null ? 0 : inputType!.hashCode) +
    (comment == null ? 0 : comment!.hashCode);

  @override
  String toString() => 'GradeDto[id=$id, course=$course, courseId=$courseId, courseType=$courseType, examId=$examId, subject=$subject, subjectToken=$subjectToken, title=$title, date=$date, mark=$mark, points=$points, weight=$weight, isConfirmed=$isConfirmed, isConfirmedByTrainer=$isConfirmedByTrainer, courseGrade=$courseGrade, examinationGroups=$examinationGroups, studentId=$studentId, studentName=$studentName, inputType=$inputType, comment=$comment]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.course != null) {
      json[r'course'] = this.course;
    } else {
      json[r'course'] = null;
    }
    if (this.courseId != null) {
      json[r'courseId'] = this.courseId;
    } else {
      json[r'courseId'] = null;
    }
    if (this.courseType != null) {
      json[r'courseType'] = this.courseType;
    } else {
      json[r'courseType'] = null;
    }
    if (this.examId != null) {
      json[r'examId'] = this.examId;
    } else {
      json[r'examId'] = null;
    }
    if (this.subject != null) {
      json[r'subject'] = this.subject;
    } else {
      json[r'subject'] = null;
    }
    if (this.subjectToken != null) {
      json[r'subjectToken'] = this.subjectToken;
    } else {
      json[r'subjectToken'] = null;
    }
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.date != null) {
      json[r'date'] = this.date;
    } else {
      json[r'date'] = null;
    }
    if (this.mark != null) {
      json[r'mark'] = this.mark;
    } else {
      json[r'mark'] = null;
    }
    if (this.points != null) {
      json[r'points'] = this.points;
    } else {
      json[r'points'] = null;
    }
    if (this.weight != null) {
      json[r'weight'] = this.weight;
    } else {
      json[r'weight'] = null;
    }
    if (this.isConfirmed != null) {
      json[r'isConfirmed'] = this.isConfirmed;
    } else {
      json[r'isConfirmed'] = null;
    }
    if (this.isConfirmedByTrainer != null) {
      json[r'isConfirmedByTrainer'] = this.isConfirmedByTrainer;
    } else {
      json[r'isConfirmedByTrainer'] = null;
    }
    if (this.courseGrade != null) {
      json[r'courseGrade'] = this.courseGrade;
    } else {
      json[r'courseGrade'] = null;
    }
    if (this.examinationGroups != null) {
      json[r'examinationGroups'] = this.examinationGroups;
    } else {
      json[r'examinationGroups'] = null;
    }
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
    if (this.inputType != null) {
      json[r'inputType'] = this.inputType;
    } else {
      json[r'inputType'] = null;
    }
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
        id: mapValueOfType<String>(json, r'id'),
        course: mapValueOfType<String>(json, r'course'),
        courseId: mapValueOfType<String>(json, r'courseId'),
        courseType: mapValueOfType<String>(json, r'courseType'),
        examId: mapValueOfType<String>(json, r'examId'),
        subject: mapValueOfType<String>(json, r'subject'),
        subjectToken: mapValueOfType<String>(json, r'subjectToken'),
        title: mapValueOfType<String>(json, r'title'),
        date: mapValueOfType<String>(json, r'date'),
        mark: json[r'mark'] == null
            ? null
            : num.parse('${json[r'mark']}'),
        points: json[r'points'] == null
            ? null
            : num.parse('${json[r'points']}'),
        weight: json[r'weight'] == null
            ? null
            : num.parse('${json[r'weight']}'),
        isConfirmed: mapValueOfType<bool>(json, r'isConfirmed'),
        isConfirmedByTrainer: mapValueOfType<bool>(json, r'isConfirmedByTrainer'),
        courseGrade: json[r'courseGrade'] == null
            ? null
            : num.parse('${json[r'courseGrade']}'),
        examinationGroups: ExaminationGroupsDto.fromJson(json[r'examinationGroups']),
        studentId: mapValueOfType<String>(json, r'studentId'),
        studentName: mapValueOfType<String>(json, r'studentName'),
        inputType: mapValueOfType<String>(json, r'inputType'),
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
  };
}

