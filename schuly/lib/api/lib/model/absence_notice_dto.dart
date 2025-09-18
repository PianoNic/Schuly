//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AbsenceNoticeDto {
  /// Returns a new [AbsenceNoticeDto] instance.
  AbsenceNoticeDto({
    required this.id,
    required this.studentId,
    this.studentReason,
    this.studentReasonTimestamp,
    required this.studentIs18,
    required this.date,
    required this.hourFrom,
    required this.hourTo,
    required this.time,
    required this.status,
    required this.statusLong,
    this.comment,
    required this.isExamLesson,
    required this.profile,
    required this.course,
    required this.courseId,
    required this.absenceId,
    required this.absenceSemester,
    this.trainerAcknowledgement,
    this.trainerComment,
    this.trainerCommentTimestamp,
  });

  String id;

  String studentId;

  String? studentReason;

  String? studentReasonTimestamp;

  bool studentIs18;

  String date;

  String hourFrom;

  String hourTo;

  String time;

  String status;

  String statusLong;

  String? comment;

  bool isExamLesson;

  String profile;

  String course;

  String courseId;

  String absenceId;

  int absenceSemester;

  String? trainerAcknowledgement;

  String? trainerComment;

  String? trainerCommentTimestamp;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AbsenceNoticeDto &&
    other.id == id &&
    other.studentId == studentId &&
    other.studentReason == studentReason &&
    other.studentReasonTimestamp == studentReasonTimestamp &&
    other.studentIs18 == studentIs18 &&
    other.date == date &&
    other.hourFrom == hourFrom &&
    other.hourTo == hourTo &&
    other.time == time &&
    other.status == status &&
    other.statusLong == statusLong &&
    other.comment == comment &&
    other.isExamLesson == isExamLesson &&
    other.profile == profile &&
    other.course == course &&
    other.courseId == courseId &&
    other.absenceId == absenceId &&
    other.absenceSemester == absenceSemester &&
    other.trainerAcknowledgement == trainerAcknowledgement &&
    other.trainerComment == trainerComment &&
    other.trainerCommentTimestamp == trainerCommentTimestamp;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (studentId.hashCode) +
    (studentReason == null ? 0 : studentReason!.hashCode) +
    (studentReasonTimestamp == null ? 0 : studentReasonTimestamp!.hashCode) +
    (studentIs18.hashCode) +
    (date.hashCode) +
    (hourFrom.hashCode) +
    (hourTo.hashCode) +
    (time.hashCode) +
    (status.hashCode) +
    (statusLong.hashCode) +
    (comment == null ? 0 : comment!.hashCode) +
    (isExamLesson.hashCode) +
    (profile.hashCode) +
    (course.hashCode) +
    (courseId.hashCode) +
    (absenceId.hashCode) +
    (absenceSemester.hashCode) +
    (trainerAcknowledgement == null ? 0 : trainerAcknowledgement!.hashCode) +
    (trainerComment == null ? 0 : trainerComment!.hashCode) +
    (trainerCommentTimestamp == null ? 0 : trainerCommentTimestamp!.hashCode);

  @override
  String toString() => 'AbsenceNoticeDto[id=$id, studentId=$studentId, studentReason=$studentReason, studentReasonTimestamp=$studentReasonTimestamp, studentIs18=$studentIs18, date=$date, hourFrom=$hourFrom, hourTo=$hourTo, time=$time, status=$status, statusLong=$statusLong, comment=$comment, isExamLesson=$isExamLesson, profile=$profile, course=$course, courseId=$courseId, absenceId=$absenceId, absenceSemester=$absenceSemester, trainerAcknowledgement=$trainerAcknowledgement, trainerComment=$trainerComment, trainerCommentTimestamp=$trainerCommentTimestamp]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'studentId'] = this.studentId;
    if (this.studentReason != null) {
      json[r'studentReason'] = this.studentReason;
    } else {
      json[r'studentReason'] = null;
    }
    if (this.studentReasonTimestamp != null) {
      json[r'studentReasonTimestamp'] = this.studentReasonTimestamp;
    } else {
      json[r'studentReasonTimestamp'] = null;
    }
      json[r'studentIs18'] = this.studentIs18;
      json[r'date'] = this.date;
      json[r'hourFrom'] = this.hourFrom;
      json[r'hourTo'] = this.hourTo;
      json[r'time'] = this.time;
      json[r'status'] = this.status;
      json[r'statusLong'] = this.statusLong;
    if (this.comment != null) {
      json[r'comment'] = this.comment;
    } else {
      json[r'comment'] = null;
    }
      json[r'isExamLesson'] = this.isExamLesson;
      json[r'profile'] = this.profile;
      json[r'course'] = this.course;
      json[r'courseId'] = this.courseId;
      json[r'absenceId'] = this.absenceId;
      json[r'absenceSemester'] = this.absenceSemester;
    if (this.trainerAcknowledgement != null) {
      json[r'trainerAcknowledgement'] = this.trainerAcknowledgement;
    } else {
      json[r'trainerAcknowledgement'] = null;
    }
    if (this.trainerComment != null) {
      json[r'trainerComment'] = this.trainerComment;
    } else {
      json[r'trainerComment'] = null;
    }
    if (this.trainerCommentTimestamp != null) {
      json[r'trainerCommentTimestamp'] = this.trainerCommentTimestamp;
    } else {
      json[r'trainerCommentTimestamp'] = null;
    }
    return json;
  }

  /// Returns a new [AbsenceNoticeDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AbsenceNoticeDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AbsenceNoticeDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AbsenceNoticeDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AbsenceNoticeDto(
        id: mapValueOfType<String>(json, r'id')!,
        studentId: mapValueOfType<String>(json, r'studentId')!,
        studentReason: mapValueOfType<String>(json, r'studentReason'),
        studentReasonTimestamp: mapValueOfType<String>(json, r'studentReasonTimestamp'),
        studentIs18: mapValueOfType<bool>(json, r'studentIs18')!,
        date: mapValueOfType<String>(json, r'date')!,
        hourFrom: mapValueOfType<String>(json, r'hourFrom')!,
        hourTo: mapValueOfType<String>(json, r'hourTo')!,
        time: mapValueOfType<String>(json, r'time')!,
        status: mapValueOfType<String>(json, r'status')!,
        statusLong: mapValueOfType<String>(json, r'statusLong')!,
        comment: mapValueOfType<String>(json, r'comment'),
        isExamLesson: mapValueOfType<bool>(json, r'isExamLesson')!,
        profile: mapValueOfType<String>(json, r'profile')!,
        course: mapValueOfType<String>(json, r'course')!,
        courseId: mapValueOfType<String>(json, r'courseId')!,
        absenceId: mapValueOfType<String>(json, r'absenceId')!,
        absenceSemester: mapValueOfType<int>(json, r'absenceSemester')!,
        trainerAcknowledgement: mapValueOfType<String>(json, r'trainerAcknowledgement'),
        trainerComment: mapValueOfType<String>(json, r'trainerComment'),
        trainerCommentTimestamp: mapValueOfType<String>(json, r'trainerCommentTimestamp'),
      );
    }
    return null;
  }

  static List<AbsenceNoticeDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AbsenceNoticeDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AbsenceNoticeDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AbsenceNoticeDto> mapFromJson(dynamic json) {
    final map = <String, AbsenceNoticeDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AbsenceNoticeDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AbsenceNoticeDto-objects as value to a dart map
  static Map<String, List<AbsenceNoticeDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AbsenceNoticeDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AbsenceNoticeDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'studentId',
    'studentIs18',
    'date',
    'hourFrom',
    'hourTo',
    'time',
    'status',
    'statusLong',
    'isExamLesson',
    'profile',
    'course',
    'courseId',
    'absenceId',
    'absenceSemester',
  };
}

