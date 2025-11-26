//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ClassInfoDto {
  /// Returns a new [ClassInfoDto] instance.
  ClassInfoDto({
    this.id,
    this.token,
    this.semester,
  });

  String? id;

  String? token;

  String? semester;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ClassInfoDto &&
    other.id == id &&
    other.token == token &&
    other.semester == semester;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (token == null ? 0 : token!.hashCode) +
    (semester == null ? 0 : semester!.hashCode);

  @override
  String toString() => 'ClassInfoDto[id=$id, token=$token, semester=$semester]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.token != null) {
      json[r'token'] = this.token;
    } else {
      json[r'token'] = null;
    }
    if (this.semester != null) {
      json[r'semester'] = this.semester;
    } else {
      json[r'semester'] = null;
    }
    return json;
  }

  /// Returns a new [ClassInfoDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ClassInfoDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ClassInfoDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ClassInfoDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ClassInfoDto(
        id: mapValueOfType<String>(json, r'id'),
        token: mapValueOfType<String>(json, r'token'),
        semester: mapValueOfType<String>(json, r'semester'),
      );
    }
    return null;
  }

  static List<ClassInfoDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClassInfoDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClassInfoDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ClassInfoDto> mapFromJson(dynamic json) {
    final map = <String, ClassInfoDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ClassInfoDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ClassInfoDto-objects as value to a dart map
  static Map<String, List<ClassInfoDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ClassInfoDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ClassInfoDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

