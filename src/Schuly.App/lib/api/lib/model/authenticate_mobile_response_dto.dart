//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AuthenticateMobileResponseDto {
  /// Returns a new [AuthenticateMobileResponseDto] instance.
  AuthenticateMobileResponseDto({
    required this.success,
    this.accessToken,
    this.refreshToken,
    this.message,
    this.error,
  });

  /// Whether authentication was successful
  bool success;

  String? accessToken;

  String? refreshToken;

  String? message;

  String? error;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AuthenticateMobileResponseDto &&
    other.success == success &&
    other.accessToken == accessToken &&
    other.refreshToken == refreshToken &&
    other.message == message &&
    other.error == error;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (success.hashCode) +
    (accessToken == null ? 0 : accessToken!.hashCode) +
    (refreshToken == null ? 0 : refreshToken!.hashCode) +
    (message == null ? 0 : message!.hashCode) +
    (error == null ? 0 : error!.hashCode);

  @override
  String toString() => 'AuthenticateMobileResponseDto[success=$success, accessToken=$accessToken, refreshToken=$refreshToken, message=$message, error=$error]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'success'] = this.success;
    if (this.accessToken != null) {
      json[r'access_token'] = this.accessToken;
    } else {
      json[r'access_token'] = null;
    }
    if (this.refreshToken != null) {
      json[r'refresh_token'] = this.refreshToken;
    } else {
      json[r'refresh_token'] = null;
    }
    if (this.message != null) {
      json[r'message'] = this.message;
    } else {
      json[r'message'] = null;
    }
    if (this.error != null) {
      json[r'error'] = this.error;
    } else {
      json[r'error'] = null;
    }
    return json;
  }

  /// Returns a new [AuthenticateMobileResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AuthenticateMobileResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AuthenticateMobileResponseDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AuthenticateMobileResponseDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AuthenticateMobileResponseDto(
        success: mapValueOfType<bool>(json, r'success')!,
        accessToken: mapValueOfType<String>(json, r'access_token'),
        refreshToken: mapValueOfType<String>(json, r'refresh_token'),
        message: mapValueOfType<String>(json, r'message'),
        error: mapValueOfType<String>(json, r'error'),
      );
    }
    return null;
  }

  static List<AuthenticateMobileResponseDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AuthenticateMobileResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuthenticateMobileResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AuthenticateMobileResponseDto> mapFromJson(dynamic json) {
    final map = <String, AuthenticateMobileResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AuthenticateMobileResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AuthenticateMobileResponseDto-objects as value to a dart map
  static Map<String, List<AuthenticateMobileResponseDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AuthenticateMobileResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AuthenticateMobileResponseDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'success',
  };
}

