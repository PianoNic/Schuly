//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LatenessDto {
  /// Returns a new [LatenessDto] instance.
  LatenessDto({
    required this.id,
    required this.dateExcused,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.reason,
    required this.excused,
    required this.extendedDeadline,
    required this.courseId,
    required this.courseToken,
    required this.comment,
  });

  String id;

  DateTime? dateExcused;

  DateTime date;

  String startTime;

  String endTime;

  String duration;

  String? reason;

  bool excused;

  int extendedDeadline;

  String courseId;

  String courseToken;

  String? comment;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LatenessDto &&
    other.id == id &&
    other.dateExcused == dateExcused &&
    other.date == date &&
    other.startTime == startTime &&
    other.endTime == endTime &&
    other.duration == duration &&
    other.reason == reason &&
    other.excused == excused &&
    other.extendedDeadline == extendedDeadline &&
    other.courseId == courseId &&
    other.courseToken == courseToken &&
    other.comment == comment;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (dateExcused == null ? 0 : dateExcused!.hashCode) +
    (date.hashCode) +
    (startTime.hashCode) +
    (endTime.hashCode) +
    (duration.hashCode) +
    (reason == null ? 0 : reason!.hashCode) +
    (excused.hashCode) +
    (extendedDeadline.hashCode) +
    (courseId.hashCode) +
    (courseToken.hashCode) +
    (comment == null ? 0 : comment!.hashCode);

  @override
  String toString() => 'LatenessDto[id=$id, dateExcused=$dateExcused, date=$date, startTime=$startTime, endTime=$endTime, duration=$duration, reason=$reason, excused=$excused, extendedDeadline=$extendedDeadline, courseId=$courseId, courseToken=$courseToken, comment=$comment]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
    if (this.dateExcused != null) {
      json[r'dateExcused'] = _dateFormatter.format(this.dateExcused!.toUtc());
    } else {
      json[r'dateExcused'] = null;
    }
      json[r'date'] = _dateFormatter.format(this.date.toUtc());
      json[r'startTime'] = this.startTime;
      json[r'endTime'] = this.endTime;
      json[r'duration'] = this.duration;
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    } else {
      json[r'reason'] = null;
    }
      json[r'excused'] = this.excused;
      json[r'extendedDeadline'] = this.extendedDeadline;
      json[r'courseId'] = this.courseId;
      json[r'courseToken'] = this.courseToken;
    if (this.comment != null) {
      json[r'comment'] = this.comment;
    } else {
      json[r'comment'] = null;
    }
    return json;
  }

  /// Returns a new [LatenessDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LatenessDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LatenessDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LatenessDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LatenessDto(
        id: mapValueOfType<String>(json, r'id')!,
        dateExcused: mapDateTime(json, r'dateExcused', r''),
        date: mapDateTime(json, r'date', r'')!,
        startTime: mapValueOfType<String>(json, r'startTime')!,
        endTime: mapValueOfType<String>(json, r'endTime')!,
        duration: mapValueOfType<String>(json, r'duration')!,
        reason: mapValueOfType<String>(json, r'reason'),
        excused: mapValueOfType<bool>(json, r'excused')!,
        extendedDeadline: mapValueOfType<int>(json, r'extendedDeadline')!,
        courseId: mapValueOfType<String>(json, r'courseId')!,
        courseToken: mapValueOfType<String>(json, r'courseToken')!,
        comment: mapValueOfType<String>(json, r'comment'),
      );
    }
    return null;
  }

  static List<LatenessDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LatenessDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LatenessDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LatenessDto> mapFromJson(dynamic json) {
    final map = <String, LatenessDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LatenessDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LatenessDto-objects as value to a dart map
  static Map<String, List<LatenessDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LatenessDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LatenessDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'dateExcused',
    'date',
    'startTime',
    'endTime',
    'duration',
    'reason',
    'excused',
    'extendedDeadline',
    'courseId',
    'courseToken',
    'comment',
  };
}

