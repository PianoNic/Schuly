//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MobileCallbackResponseDto {
  /// Returns a new [MobileCallbackResponseDto] instance.
  MobileCallbackResponseDto({
    required this.accessToken,
    required this.refreshToken,
  });

  /// JWT access token for API authentication
  String accessToken;

  /// Refresh token to obtain new access tokens
  String refreshToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MobileCallbackResponseDto &&
    other.accessToken == accessToken &&
    other.refreshToken == refreshToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accessToken.hashCode) +
    (refreshToken.hashCode);

  @override
  String toString() => 'MobileCallbackResponseDto[accessToken=$accessToken, refreshToken=$refreshToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'access_token'] = this.accessToken;
      json[r'refresh_token'] = this.refreshToken;
    return json;
  }

  /// Returns a new [MobileCallbackResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MobileCallbackResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MobileCallbackResponseDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MobileCallbackResponseDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MobileCallbackResponseDto(
        accessToken: mapValueOfType<String>(json, r'access_token')!,
        refreshToken: mapValueOfType<String>(json, r'refresh_token')!,
      );
    }
    return null;
  }

  static List<MobileCallbackResponseDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MobileCallbackResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MobileCallbackResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MobileCallbackResponseDto> mapFromJson(dynamic json) {
    final map = <String, MobileCallbackResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MobileCallbackResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MobileCallbackResponseDto-objects as value to a dart map
  static Map<String, List<MobileCallbackResponseDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MobileCallbackResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MobileCallbackResponseDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'access_token',
    'refresh_token',
  };
}

