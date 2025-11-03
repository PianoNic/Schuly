//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ExaminationGroupsDto {
  /// Returns a new [ExaminationGroupsDto] instance.
  ExaminationGroupsDto({
    this.examGroup,
    this.weightExamGroup,
    this.averageExamGroup,
  });

  String? examGroup;

  String? weightExamGroup;

  String? averageExamGroup;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ExaminationGroupsDto &&
    other.examGroup == examGroup &&
    other.weightExamGroup == weightExamGroup &&
    other.averageExamGroup == averageExamGroup;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (examGroup == null ? 0 : examGroup!.hashCode) +
    (weightExamGroup == null ? 0 : weightExamGroup!.hashCode) +
    (averageExamGroup == null ? 0 : averageExamGroup!.hashCode);

  @override
  String toString() => 'ExaminationGroupsDto[examGroup=$examGroup, weightExamGroup=$weightExamGroup, averageExamGroup=$averageExamGroup]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.examGroup != null) {
      json[r'examGroup'] = this.examGroup;
    } else {
      json[r'examGroup'] = null;
    }
    if (this.weightExamGroup != null) {
      json[r'weightExamGroup'] = this.weightExamGroup;
    } else {
      json[r'weightExamGroup'] = null;
    }
    if (this.averageExamGroup != null) {
      json[r'averageExamGroup'] = this.averageExamGroup;
    } else {
      json[r'averageExamGroup'] = null;
    }
    return json;
  }

  /// Returns a new [ExaminationGroupsDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ExaminationGroupsDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ExaminationGroupsDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ExaminationGroupsDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ExaminationGroupsDto(
        examGroup: mapValueOfType<String>(json, r'examGroup'),
        weightExamGroup: mapValueOfType<String>(json, r'weightExamGroup'),
        averageExamGroup: mapValueOfType<String>(json, r'averageExamGroup'),
      );
    }
    return null;
  }

  static List<ExaminationGroupsDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ExaminationGroupsDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ExaminationGroupsDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ExaminationGroupsDto> mapFromJson(dynamic json) {
    final map = <String, ExaminationGroupsDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ExaminationGroupsDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ExaminationGroupsDto-objects as value to a dart map
  static Map<String, List<ExaminationGroupsDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ExaminationGroupsDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ExaminationGroupsDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

