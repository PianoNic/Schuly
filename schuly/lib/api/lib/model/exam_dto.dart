//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ExamDto {
  /// Returns a new [ExamDto] instance.
  ExamDto({
    required this.id,
    required this.startDate,
    required this.endDate,
    this.text,
    this.comment,
    required this.roomToken,
    this.roomId,
    this.teachers,
    this.teacherIds,
    this.teacherTokens,
    required this.courseId,
    required this.courseToken,
    required this.courseName,
    this.status,
    required this.color,
    required this.eventType,
    this.eventRoomStatus,
    this.timetableText,
    this.infoFacilityManagement,
    this.importset,
    this.lessons,
    this.publishToInfoSystem,
    this.studentNames,
    this.studentIds,
    required this.client,
    required this.clientname,
    required this.weight,
  });

  String id;

  String startDate;

  String endDate;

  String? text;

  String? comment;

  String roomToken;

  String? roomId;

  List<String>? teachers;

  List<String>? teacherIds;

  List<String>? teacherTokens;

  String courseId;

  String courseToken;

  String courseName;

  String? status;

  String color;

  String eventType;

  String? eventRoomStatus;

  String? timetableText;

  String? infoFacilityManagement;

  String? importset;

  List<String>? lessons;

  bool? publishToInfoSystem;

  List<String>? studentNames;

  List<String>? studentIds;

  String client;

  String clientname;

  String weight;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ExamDto &&
    other.id == id &&
    other.startDate == startDate &&
    other.endDate == endDate &&
    other.text == text &&
    other.comment == comment &&
    other.roomToken == roomToken &&
    other.roomId == roomId &&
    _deepEquality.equals(other.teachers, teachers) &&
    _deepEquality.equals(other.teacherIds, teacherIds) &&
    _deepEquality.equals(other.teacherTokens, teacherTokens) &&
    other.courseId == courseId &&
    other.courseToken == courseToken &&
    other.courseName == courseName &&
    other.status == status &&
    other.color == color &&
    other.eventType == eventType &&
    other.eventRoomStatus == eventRoomStatus &&
    other.timetableText == timetableText &&
    other.infoFacilityManagement == infoFacilityManagement &&
    other.importset == importset &&
    _deepEquality.equals(other.lessons, lessons) &&
    other.publishToInfoSystem == publishToInfoSystem &&
    _deepEquality.equals(other.studentNames, studentNames) &&
    _deepEquality.equals(other.studentIds, studentIds) &&
    other.client == client &&
    other.clientname == clientname &&
    other.weight == weight;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (startDate.hashCode) +
    (endDate.hashCode) +
    (text.hashCode) +
    (comment == null ? 0 : comment!.hashCode) +
    (roomToken.hashCode) +
    (roomId == null ? 0 : roomId!.hashCode) +
    (teachers == null ? 0 : teachers!.hashCode) +
    (teacherIds == null ? 0 : teacherIds!.hashCode) +
    (teacherTokens == null ? 0 : teacherTokens!.hashCode) +
    (courseId.hashCode) +
    (courseToken.hashCode) +
    (courseName.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (color.hashCode) +
    (eventType.hashCode) +
    (eventRoomStatus == null ? 0 : eventRoomStatus!.hashCode) +
    (timetableText == null ? 0 : timetableText!.hashCode) +
    (infoFacilityManagement == null ? 0 : infoFacilityManagement!.hashCode) +
    (importset == null ? 0 : importset!.hashCode) +
    (lessons == null ? 0 : lessons!.hashCode) +
    (publishToInfoSystem == null ? 0 : publishToInfoSystem!.hashCode) +
    (studentNames == null ? 0 : studentNames!.hashCode) +
    (studentIds == null ? 0 : studentIds!.hashCode) +
    (client.hashCode) +
    (clientname.hashCode) +
    (weight.hashCode);

  @override
  String toString() => 'ExamDto[id=$id, startDate=$startDate, endDate=$endDate, text=$text, comment=$comment, roomToken=$roomToken, roomId=$roomId, teachers=$teachers, teacherIds=$teacherIds, teacherTokens=$teacherTokens, courseId=$courseId, courseToken=$courseToken, courseName=$courseName, status=$status, color=$color, eventType=$eventType, eventRoomStatus=$eventRoomStatus, timetableText=$timetableText, infoFacilityManagement=$infoFacilityManagement, importset=$importset, lessons=$lessons, publishToInfoSystem=$publishToInfoSystem, studentNames=$studentNames, studentIds=$studentIds, client=$client, clientname=$clientname, weight=$weight]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'startDate'] = this.startDate;
      json[r'endDate'] = this.endDate;
      json[r'text'] = this.text;
    if (this.comment != null) {
      json[r'comment'] = this.comment;
    } else {
      json[r'comment'] = null;
    }
      json[r'roomToken'] = this.roomToken;
    if (this.roomId != null) {
      json[r'roomId'] = this.roomId;
    } else {
      json[r'roomId'] = null;
    }
    if (this.teachers != null) {
      json[r'teachers'] = this.teachers;
    } else {
      json[r'teachers'] = null;
    }
    if (this.teacherIds != null) {
      json[r'teacherIds'] = this.teacherIds;
    } else {
      json[r'teacherIds'] = null;
    }
    if (this.teacherTokens != null) {
      json[r'teacherTokens'] = this.teacherTokens;
    } else {
      json[r'teacherTokens'] = null;
    }
      json[r'courseId'] = this.courseId;
      json[r'courseToken'] = this.courseToken;
      json[r'courseName'] = this.courseName;
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
      json[r'color'] = this.color;
      json[r'eventType'] = this.eventType;
    if (this.eventRoomStatus != null) {
      json[r'eventRoomStatus'] = this.eventRoomStatus;
    } else {
      json[r'eventRoomStatus'] = null;
    }
    if (this.timetableText != null) {
      json[r'timetableText'] = this.timetableText;
    } else {
      json[r'timetableText'] = null;
    }
    if (this.infoFacilityManagement != null) {
      json[r'infoFacilityManagement'] = this.infoFacilityManagement;
    } else {
      json[r'infoFacilityManagement'] = null;
    }
    if (this.importset != null) {
      json[r'importset'] = this.importset;
    } else {
      json[r'importset'] = null;
    }
    if (this.lessons != null) {
      json[r'lessons'] = this.lessons;
    } else {
      json[r'lessons'] = null;
    }
    if (this.publishToInfoSystem != null) {
      json[r'publishToInfoSystem'] = this.publishToInfoSystem;
    } else {
      json[r'publishToInfoSystem'] = null;
    }
    if (this.studentNames != null) {
      json[r'studentNames'] = this.studentNames;
    } else {
      json[r'studentNames'] = null;
    }
    if (this.studentIds != null) {
      json[r'studentIds'] = this.studentIds;
    } else {
      json[r'studentIds'] = null;
    }
      json[r'client'] = this.client;
      json[r'clientname'] = this.clientname;
      json[r'weight'] = this.weight;
    return json;
  }

  /// Helper method to parse numeric or string values from JSON
  /// The API returns weight as numbers (e.g., 1) but the DTO stores it as string
  static String? _parseNumberOrString(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is String) {
      return value;
    }
    if (value is num) {
      return value.toString();
    }
    return null;
  }

  /// Returns a new [ExamDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ExamDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ExamDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ExamDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ExamDto(
        id: mapValueOfType<String>(json, r'id')!,
        startDate: mapValueOfType<String>(json, r'startDate')!,
        endDate: mapValueOfType<String>(json, r'endDate')!,
        text: mapValueOfType<String>(json, r'text'),
        comment: mapValueOfType<String>(json, r'comment'),
        roomToken: mapValueOfType<String>(json, r'roomToken')!,
        roomId: mapValueOfType<String>(json, r'roomId'),
        teachers: json[r'teachers'] is Iterable
            ? (json[r'teachers'] as Iterable).cast<String>().toList(growable: false)
            : null,
        teacherIds: json[r'teacherIds'] is Iterable
            ? (json[r'teacherIds'] as Iterable).cast<String>().toList(growable: false)
            : null,
        teacherTokens: json[r'teacherTokens'] is Iterable
            ? (json[r'teacherTokens'] as Iterable).cast<String>().toList(growable: false)
            : null,
        courseId: mapValueOfType<String>(json, r'courseId')!,
        courseToken: mapValueOfType<String>(json, r'courseToken')!,
        courseName: mapValueOfType<String>(json, r'courseName')!,
        status: mapValueOfType<String>(json, r'status'),
        color: mapValueOfType<String>(json, r'color')!,
        eventType: mapValueOfType<String>(json, r'eventType')!,
        eventRoomStatus: mapValueOfType<String>(json, r'eventRoomStatus'),
        timetableText: mapValueOfType<String>(json, r'timetableText'),
        infoFacilityManagement: mapValueOfType<String>(json, r'infoFacilityManagement'),
        importset: mapValueOfType<String>(json, r'importset'),
        lessons: json[r'lessons'] is Iterable
            ? (json[r'lessons'] as Iterable).cast<String>().toList(growable: false)
            : null,
        publishToInfoSystem: mapValueOfType<bool>(json, r'publishToInfoSystem'),
        studentNames: json[r'studentNames'] is Iterable
            ? (json[r'studentNames'] as Iterable).cast<String>().toList(growable: false)
            : null,
        studentIds: json[r'studentIds'] is Iterable
            ? (json[r'studentIds'] as Iterable).cast<String>().toList(growable: false)
            : null,
        client: mapValueOfType<String>(json, r'client')!,
        clientname: mapValueOfType<String>(json, r'clientname')!,
        weight: _parseNumberOrString(json[r'weight'])!,
      );
    }
    return null;
  }

  static List<ExamDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ExamDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ExamDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ExamDto> mapFromJson(dynamic json) {
    final map = <String, ExamDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ExamDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ExamDto-objects as value to a dart map
  static Map<String, List<ExamDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ExamDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ExamDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'startDate',
    'endDate',
    'text',
    'roomToken',
    'courseId',
    'courseToken',
    'courseName',
    'color',
    'eventType',
    'client',
    'clientname',
    'weight',
  };
}

