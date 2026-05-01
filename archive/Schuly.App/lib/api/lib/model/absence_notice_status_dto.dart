//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AbsenceNoticeStatusDto {
  /// Returns a new [AbsenceNoticeStatusDto] instance.
  AbsenceNoticeStatusDto({
    this.id,
    this.code,
    this.name,
    this.sort,
    this.comment,
    this.additionalInfo,
    this.iso2,
    this.iso3,
  });

  String? id;

  String? code;

  String? name;

  String? sort;

  String? comment;

  String? additionalInfo;

  String? iso2;

  String? iso3;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AbsenceNoticeStatusDto &&
    other.id == id &&
    other.code == code &&
    other.name == name &&
    other.sort == sort &&
    other.comment == comment &&
    other.additionalInfo == additionalInfo &&
    other.iso2 == iso2 &&
    other.iso3 == iso3;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (code == null ? 0 : code!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (sort == null ? 0 : sort!.hashCode) +
    (comment == null ? 0 : comment!.hashCode) +
    (additionalInfo == null ? 0 : additionalInfo!.hashCode) +
    (iso2 == null ? 0 : iso2!.hashCode) +
    (iso3 == null ? 0 : iso3!.hashCode);

  @override
  String toString() => 'AbsenceNoticeStatusDto[id=$id, code=$code, name=$name, sort=$sort, comment=$comment, additionalInfo=$additionalInfo, iso2=$iso2, iso3=$iso3]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.code != null) {
      json[r'code'] = this.code;
    } else {
      json[r'code'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.sort != null) {
      json[r'sort'] = this.sort;
    } else {
      json[r'sort'] = null;
    }
    if (this.comment != null) {
      json[r'comment'] = this.comment;
    } else {
      json[r'comment'] = null;
    }
    if (this.additionalInfo != null) {
      json[r'additionalInfo'] = this.additionalInfo;
    } else {
      json[r'additionalInfo'] = null;
    }
    if (this.iso2 != null) {
      json[r'iso2'] = this.iso2;
    } else {
      json[r'iso2'] = null;
    }
    if (this.iso3 != null) {
      json[r'iso3'] = this.iso3;
    } else {
      json[r'iso3'] = null;
    }
    return json;
  }

  /// Returns a new [AbsenceNoticeStatusDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AbsenceNoticeStatusDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AbsenceNoticeStatusDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AbsenceNoticeStatusDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AbsenceNoticeStatusDto(
        id: mapValueOfType<String>(json, r'id'),
        code: mapValueOfType<String>(json, r'code'),
        name: mapValueOfType<String>(json, r'name'),
        sort: mapValueOfType<String>(json, r'sort'),
        comment: mapValueOfType<String>(json, r'comment'),
        additionalInfo: mapValueOfType<String>(json, r'additionalInfo'),
        iso2: mapValueOfType<String>(json, r'iso2'),
        iso3: mapValueOfType<String>(json, r'iso3'),
      );
    }
    return null;
  }

  static List<AbsenceNoticeStatusDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AbsenceNoticeStatusDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AbsenceNoticeStatusDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AbsenceNoticeStatusDto> mapFromJson(dynamic json) {
    final map = <String, AbsenceNoticeStatusDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AbsenceNoticeStatusDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AbsenceNoticeStatusDto-objects as value to a dart map
  static Map<String, List<AbsenceNoticeStatusDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AbsenceNoticeStatusDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AbsenceNoticeStatusDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

