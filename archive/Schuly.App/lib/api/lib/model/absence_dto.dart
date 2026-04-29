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
    this.id,
    this.studentId,
    this.dateFrom,
    this.dateTo,
    this.hourFrom,
    this.hourTo,
    this.subject,
    this.subjectId,
    this.profile,
    this.profileId,
    this.lessons,
    this.reason,
    this.category,
    this.comment,
    this.remark,
    this.isAcknowledged,
    this.isExcused,
    this.excusedDate,
    this.additionalPeriod,
    this.statusEAE,
    this.dateEAE,
    this.statusEAB,
    this.dateEAB,
    this.commentEAB,
    this.studentTimestamp,
  });

  String? id;

  String? studentId;

  String? dateFrom;

  String? dateTo;

  String? hourFrom;

  String? hourTo;

  String? subject;

  String? subjectId;

  String? profile;

  String? profileId;

  String? lessons;

  String? reason;

  String? category;

  String? comment;

  String? remark;

  bool? isAcknowledged;

  bool? isExcused;

  String? excusedDate;

  int? additionalPeriod;

  String? statusEAE;

  String? dateEAE;

  String? statusEAB;

  String? dateEAB;

  String? commentEAB;

  String? studentTimestamp;

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
    (id == null ? 0 : id!.hashCode) +
    (studentId == null ? 0 : studentId!.hashCode) +
    (dateFrom == null ? 0 : dateFrom!.hashCode) +
    (dateTo == null ? 0 : dateTo!.hashCode) +
    (hourFrom == null ? 0 : hourFrom!.hashCode) +
    (hourTo == null ? 0 : hourTo!.hashCode) +
    (subject == null ? 0 : subject!.hashCode) +
    (subjectId == null ? 0 : subjectId!.hashCode) +
    (profile == null ? 0 : profile!.hashCode) +
    (profileId == null ? 0 : profileId!.hashCode) +
    (lessons == null ? 0 : lessons!.hashCode) +
    (reason == null ? 0 : reason!.hashCode) +
    (category == null ? 0 : category!.hashCode) +
    (comment == null ? 0 : comment!.hashCode) +
    (remark == null ? 0 : remark!.hashCode) +
    (isAcknowledged == null ? 0 : isAcknowledged!.hashCode) +
    (isExcused == null ? 0 : isExcused!.hashCode) +
    (excusedDate == null ? 0 : excusedDate!.hashCode) +
    (additionalPeriod == null ? 0 : additionalPeriod!.hashCode) +
    (statusEAE == null ? 0 : statusEAE!.hashCode) +
    (dateEAE == null ? 0 : dateEAE!.hashCode) +
    (statusEAB == null ? 0 : statusEAB!.hashCode) +
    (dateEAB == null ? 0 : dateEAB!.hashCode) +
    (commentEAB == null ? 0 : commentEAB!.hashCode) +
    (studentTimestamp == null ? 0 : studentTimestamp!.hashCode);

  @override
  String toString() => 'AbsenceDto[id=$id, studentId=$studentId, dateFrom=$dateFrom, dateTo=$dateTo, hourFrom=$hourFrom, hourTo=$hourTo, subject=$subject, subjectId=$subjectId, profile=$profile, profileId=$profileId, lessons=$lessons, reason=$reason, category=$category, comment=$comment, remark=$remark, isAcknowledged=$isAcknowledged, isExcused=$isExcused, excusedDate=$excusedDate, additionalPeriod=$additionalPeriod, statusEAE=$statusEAE, dateEAE=$dateEAE, statusEAB=$statusEAB, dateEAB=$dateEAB, commentEAB=$commentEAB, studentTimestamp=$studentTimestamp]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.studentId != null) {
      json[r'studentId'] = this.studentId;
    } else {
      json[r'studentId'] = null;
    }
    if (this.dateFrom != null) {
      json[r'dateFrom'] = this.dateFrom;
    } else {
      json[r'dateFrom'] = null;
    }
    if (this.dateTo != null) {
      json[r'dateTo'] = this.dateTo;
    } else {
      json[r'dateTo'] = null;
    }
    if (this.hourFrom != null) {
      json[r'hourFrom'] = this.hourFrom;
    } else {
      json[r'hourFrom'] = null;
    }
    if (this.hourTo != null) {
      json[r'hourTo'] = this.hourTo;
    } else {
      json[r'hourTo'] = null;
    }
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
    if (this.profile != null) {
      json[r'profile'] = this.profile;
    } else {
      json[r'profile'] = null;
    }
    if (this.profileId != null) {
      json[r'profileId'] = this.profileId;
    } else {
      json[r'profileId'] = null;
    }
    if (this.lessons != null) {
      json[r'lessons'] = this.lessons;
    } else {
      json[r'lessons'] = null;
    }
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    } else {
      json[r'reason'] = null;
    }
    if (this.category != null) {
      json[r'category'] = this.category;
    } else {
      json[r'category'] = null;
    }
    if (this.comment != null) {
      json[r'comment'] = this.comment;
    } else {
      json[r'comment'] = null;
    }
    if (this.remark != null) {
      json[r'remark'] = this.remark;
    } else {
      json[r'remark'] = null;
    }
    if (this.isAcknowledged != null) {
      json[r'isAcknowledged'] = this.isAcknowledged;
    } else {
      json[r'isAcknowledged'] = null;
    }
    if (this.isExcused != null) {
      json[r'isExcused'] = this.isExcused;
    } else {
      json[r'isExcused'] = null;
    }
    if (this.excusedDate != null) {
      json[r'excusedDate'] = this.excusedDate;
    } else {
      json[r'excusedDate'] = null;
    }
    if (this.additionalPeriod != null) {
      json[r'additionalPeriod'] = this.additionalPeriod;
    } else {
      json[r'additionalPeriod'] = null;
    }
    if (this.statusEAE != null) {
      json[r'statusEAE'] = this.statusEAE;
    } else {
      json[r'statusEAE'] = null;
    }
    if (this.dateEAE != null) {
      json[r'dateEAE'] = this.dateEAE;
    } else {
      json[r'dateEAE'] = null;
    }
    if (this.statusEAB != null) {
      json[r'statusEAB'] = this.statusEAB;
    } else {
      json[r'statusEAB'] = null;
    }
    if (this.dateEAB != null) {
      json[r'dateEAB'] = this.dateEAB;
    } else {
      json[r'dateEAB'] = null;
    }
    if (this.commentEAB != null) {
      json[r'commentEAB'] = this.commentEAB;
    } else {
      json[r'commentEAB'] = null;
    }
    if (this.studentTimestamp != null) {
      json[r'studentTimestamp'] = this.studentTimestamp;
    } else {
      json[r'studentTimestamp'] = null;
    }
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
        id: mapValueOfType<String>(json, r'id'),
        studentId: mapValueOfType<String>(json, r'studentId'),
        dateFrom: mapValueOfType<String>(json, r'dateFrom'),
        dateTo: mapValueOfType<String>(json, r'dateTo'),
        hourFrom: mapValueOfType<String>(json, r'hourFrom'),
        hourTo: mapValueOfType<String>(json, r'hourTo'),
        subject: mapValueOfType<String>(json, r'subject'),
        subjectId: mapValueOfType<String>(json, r'subjectId'),
        profile: mapValueOfType<String>(json, r'profile'),
        profileId: mapValueOfType<String>(json, r'profileId'),
        lessons: mapValueOfType<String>(json, r'lessons'),
        reason: mapValueOfType<String>(json, r'reason'),
        category: mapValueOfType<String>(json, r'category'),
        comment: mapValueOfType<String>(json, r'comment'),
        remark: mapValueOfType<String>(json, r'remark'),
        isAcknowledged: mapValueOfType<bool>(json, r'isAcknowledged'),
        isExcused: mapValueOfType<bool>(json, r'isExcused'),
        excusedDate: mapValueOfType<String>(json, r'excusedDate'),
        additionalPeriod: mapValueOfType<int>(json, r'additionalPeriod'),
        statusEAE: mapValueOfType<String>(json, r'statusEAE'),
        dateEAE: mapValueOfType<String>(json, r'dateEAE'),
        statusEAB: mapValueOfType<String>(json, r'statusEAB'),
        dateEAB: mapValueOfType<String>(json, r'dateEAB'),
        commentEAB: mapValueOfType<String>(json, r'commentEAB'),
        studentTimestamp: mapValueOfType<String>(json, r'studentTimestamp'),
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
  };
}

