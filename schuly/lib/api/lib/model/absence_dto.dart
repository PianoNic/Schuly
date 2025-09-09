//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AbsenceDto {
  /// Returns a new [AbsenceDto] instance.
  AbsenceDto({
    required this.id,
    required this.studentId,
    required this.dateFrom,
    required this.dateTo,
    required this.hourFrom,
    required this.hourTo,
    this.subject,
    this.subjectId,
    required this.profile,
    required this.profileId,
    required this.lessons,
    required this.reason,
    required this.category,
    required this.comment,
    this.remark,
    required this.isAcknowledged,
    required this.isExcused,
    this.excusedDate,
    required this.additionalPeriod,
    required this.statusEAE,
    required this.dateEAE,
    required this.statusEAB,
    required this.dateEAB,
    this.commentEAB,
    required this.studentTimestamp,
  });

  String id;

  String studentId;

  String dateFrom;

  String dateTo;

  String hourFrom;

  String hourTo;

  String? subject;

  String? subjectId;

  String profile;

  String profileId;

  String lessons;

  String reason;

  String category;

  String comment;

  String? remark;

  bool isAcknowledged;

  bool isExcused;

  String? excusedDate;

  int additionalPeriod;

  String statusEAE;

  String dateEAE;

  String statusEAB;

  String dateEAB;

  String? commentEAB;

  String studentTimestamp;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AbsenceDto &&
    other.id == id &&
    other.studentId == studentId &&
    other.dateFrom == dateFrom &&
    other.dateTo == dateTo &&
    other.hourFrom == hourFrom &&
    other.hourTo == hourTo &&
    other.subject == subject &&
    other.subjectId == subjectId &&
    other.profile == profile &&
    other.profileId == profileId &&
    other.lessons == lessons &&
    other.reason == reason &&
    other.category == category &&
    other.comment == comment &&
    other.remark == remark &&
    other.isAcknowledged == isAcknowledged &&
    other.isExcused == isExcused &&
    other.excusedDate == excusedDate &&
    other.additionalPeriod == additionalPeriod &&
    other.statusEAE == statusEAE &&
    other.dateEAE == dateEAE &&
    other.statusEAB == statusEAB &&
    other.dateEAB == dateEAB &&
    other.commentEAB == commentEAB &&
    other.studentTimestamp == studentTimestamp;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (studentId.hashCode) +
    (dateFrom.hashCode) +
    (dateTo.hashCode) +
    (hourFrom.hashCode) +
    (hourTo.hashCode) +
    (subject == null ? 0 : subject!.hashCode) +
    (subjectId == null ? 0 : subjectId!.hashCode) +
    (profile.hashCode) +
    (profileId.hashCode) +
    (lessons.hashCode) +
    (reason.hashCode) +
    (category.hashCode) +
    (comment.hashCode) +
    (remark == null ? 0 : remark!.hashCode) +
    (isAcknowledged.hashCode) +
    (isExcused.hashCode) +
    (excusedDate == null ? 0 : excusedDate!.hashCode) +
    (additionalPeriod.hashCode) +
    (statusEAE.hashCode) +
    (dateEAE.hashCode) +
    (statusEAB.hashCode) +
    (dateEAB.hashCode) +
    (commentEAB == null ? 0 : commentEAB!.hashCode) +
    (studentTimestamp.hashCode);

  @override
  String toString() => 'AbsenceDto[id=$id, studentId=$studentId, dateFrom=$dateFrom, dateTo=$dateTo, hourFrom=$hourFrom, hourTo=$hourTo, subject=$subject, subjectId=$subjectId, profile=$profile, profileId=$profileId, lessons=$lessons, reason=$reason, category=$category, comment=$comment, remark=$remark, isAcknowledged=$isAcknowledged, isExcused=$isExcused, excusedDate=$excusedDate, additionalPeriod=$additionalPeriod, statusEAE=$statusEAE, dateEAE=$dateEAE, statusEAB=$statusEAB, dateEAB=$dateEAB, commentEAB=$commentEAB, studentTimestamp=$studentTimestamp]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'studentId'] = this.studentId;
      json[r'dateFrom'] = this.dateFrom;
      json[r'dateTo'] = this.dateTo;
      json[r'hourFrom'] = this.hourFrom;
      json[r'hourTo'] = this.hourTo;
    if (this.subject != null) {
      json[r'subject'] = this.subject;
    } else {
      json[r'subject'] = null;
    }
    if (this.subjectId != null) {
      json[r'subjectId'] = this.subjectId;
    } else {
      json[r'subjectId'] = null;
    }
      json[r'profile'] = this.profile;
      json[r'profileId'] = this.profileId;
      json[r'lessons'] = this.lessons;
      json[r'reason'] = this.reason;
      json[r'category'] = this.category;
      json[r'comment'] = this.comment;
    if (this.remark != null) {
      json[r'remark'] = this.remark;
    } else {
      json[r'remark'] = null;
    }
      json[r'isAcknowledged'] = this.isAcknowledged;
      json[r'isExcused'] = this.isExcused;
    if (this.excusedDate != null) {
      json[r'excusedDate'] = this.excusedDate;
    } else {
      json[r'excusedDate'] = null;
    }
      json[r'additionalPeriod'] = this.additionalPeriod;
      json[r'statusEAE'] = this.statusEAE;
      json[r'dateEAE'] = this.dateEAE;
      json[r'statusEAB'] = this.statusEAB;
      json[r'dateEAB'] = this.dateEAB;
    if (this.commentEAB != null) {
      json[r'commentEAB'] = this.commentEAB;
    } else {
      json[r'commentEAB'] = null;
    }
      json[r'studentTimestamp'] = this.studentTimestamp;
    return json;
  }

  /// Returns a new [AbsenceDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AbsenceDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AbsenceDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AbsenceDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AbsenceDto(
        id: mapValueOfType<String>(json, r'id')!,
        studentId: mapValueOfType<String>(json, r'studentId')!,
        dateFrom: mapValueOfType<String>(json, r'dateFrom')!,
        dateTo: mapValueOfType<String>(json, r'dateTo')!,
        hourFrom: mapValueOfType<String>(json, r'hourFrom')!,
        hourTo: mapValueOfType<String>(json, r'hourTo')!,
        subject: mapValueOfType<String>(json, r'subject'),
        subjectId: mapValueOfType<String>(json, r'subjectId'),
        profile: mapValueOfType<String>(json, r'profile')!,
        profileId: mapValueOfType<String>(json, r'profileId')!,
        lessons: mapValueOfType<String>(json, r'lessons')!,
        reason: mapValueOfType<String>(json, r'reason')!,
        category: mapValueOfType<String>(json, r'category')!,
        comment: mapValueOfType<String>(json, r'comment')!,
        remark: mapValueOfType<String>(json, r'remark'),
        isAcknowledged: mapValueOfType<bool>(json, r'isAcknowledged')!,
        isExcused: mapValueOfType<bool>(json, r'isExcused')!,
        excusedDate: mapValueOfType<String>(json, r'excusedDate'),
        additionalPeriod: mapValueOfType<int>(json, r'additionalPeriod')!,
        statusEAE: mapValueOfType<String>(json, r'statusEAE')!,
        dateEAE: mapValueOfType<String>(json, r'dateEAE')!,
        statusEAB: mapValueOfType<String>(json, r'statusEAB')!,
        dateEAB: mapValueOfType<String>(json, r'dateEAB')!,
        commentEAB: mapValueOfType<String>(json, r'commentEAB'),
        studentTimestamp: mapValueOfType<String>(json, r'studentTimestamp')!,
      );
    }
    return null;
  }

  static List<AbsenceDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AbsenceDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AbsenceDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AbsenceDto> mapFromJson(dynamic json) {
    final map = <String, AbsenceDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AbsenceDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AbsenceDto-objects as value to a dart map
  static Map<String, List<AbsenceDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AbsenceDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AbsenceDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'studentId',
    'dateFrom',
    'dateTo',
    'hourFrom',
    'hourTo',
    'profile',
    'profileId',
    'lessons',
    'reason',
    'category',
    'comment',
    'isAcknowledged',
    'isExcused',
    'additionalPeriod',
    'statusEAE',
    'dateEAE',
    'statusEAB',
    'dateEAB',
    'studentTimestamp',
  };
}

