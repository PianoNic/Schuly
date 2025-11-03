//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AgendaDto {
  /// Returns a new [AgendaDto] instance.
  AgendaDto({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.text,
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
    this.client = '',
    this.clientname = '',
    this.weight,
  });

  String id;

  String startDate;

  String endDate;

  String text;

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

  String? lessons;

  String? publishToInfoSystem;

  String? studentNames;

  String? studentIds;

  String client;

  String clientname;

  String? weight;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AgendaDto &&
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
    other.lessons == lessons &&
    other.publishToInfoSystem == publishToInfoSystem &&
    other.studentNames == studentNames &&
    other.studentIds == studentIds &&
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
    (comment.hashCode) +
    (roomToken.hashCode) +
    (roomId.hashCode) +
    (teachers.hashCode) +
    (teacherIds.hashCode) +
    (teacherTokens.hashCode) +
    (courseId.hashCode) +
    (courseToken.hashCode) +
    (courseName.hashCode) +
    (status.hashCode) +
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
    (weight == null ? 0 : weight!.hashCode);

  @override
  String toString() => 'AgendaDto[id=$id, startDate=$startDate, endDate=$endDate, text=$text, comment=$comment, roomToken=$roomToken, roomId=$roomId, teachers=$teachers, teacherIds=$teacherIds, teacherTokens=$teacherTokens, courseId=$courseId, courseToken=$courseToken, courseName=$courseName, status=$status, color=$color, eventType=$eventType, eventRoomStatus=$eventRoomStatus, timetableText=$timetableText, infoFacilityManagement=$infoFacilityManagement, importset=$importset, lessons=$lessons, publishToInfoSystem=$publishToInfoSystem, studentNames=$studentNames, studentIds=$studentIds, client=$client, clientname=$clientname, weight=$weight]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'startDate'] = this.startDate;
      json[r'endDate'] = this.endDate;
      json[r'text'] = this.text;
      json[r'comment'] = this.comment;
      json[r'roomToken'] = this.roomToken;
      json[r'roomId'] = this.roomId;
      json[r'teachers'] = this.teachers;
      json[r'teacherIds'] = this.teacherIds;
      json[r'teacherTokens'] = this.teacherTokens;
      json[r'courseId'] = this.courseId;
      json[r'courseToken'] = this.courseToken;
      json[r'courseName'] = this.courseName;
      json[r'status'] = this.status;
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
    if (this.weight != null) {
      json[r'weight'] = this.weight;
    } else {
      json[r'weight'] = null;
    }
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

  /// Returns a new [AgendaDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AgendaDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AgendaDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AgendaDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AgendaDto(
        id: mapValueOfType<String>(json, r'id')!,
        startDate: mapValueOfType<String>(json, r'startDate')!,
        endDate: mapValueOfType<String>(json, r'endDate')!,
        text: mapValueOfType<String>(json, r'text')!,
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
        lessons: mapValueOfType<String>(json, r'lessons'),
        publishToInfoSystem: mapValueOfType<String>(json, r'publishToInfoSystem'),
        studentNames: mapValueOfType<String>(json, r'studentNames'),
        studentIds: mapValueOfType<String>(json, r'studentIds'),
        client: mapValueOfType<String>(json, r'client') ?? '',
        clientname: mapValueOfType<String>(json, r'clientname') ?? '',
        weight: _parseNumberOrString(json[r'weight']),
      );
    }
    return null;
  }

  static List<AgendaDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AgendaDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AgendaDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AgendaDto> mapFromJson(dynamic json) {
    final map = <String, AgendaDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AgendaDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AgendaDto-objects as value to a dart map
  static Map<String, List<AgendaDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AgendaDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AgendaDto.listFromJson(entry.value, growable: growable,);
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
    'comment',
    'roomToken',
    'roomId',
    'teachers',
    'teacherIds',
    'teacherTokens',
    'courseId',
    'courseToken',
    'courseName',
    'status',
    'color',
    'eventType',
  };
}

