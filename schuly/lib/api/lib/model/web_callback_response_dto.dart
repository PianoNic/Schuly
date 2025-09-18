//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WebCallbackResponseDto {
  /// Returns a new [WebCallbackResponseDto] instance.
  WebCallbackResponseDto({
    required this.success,
    required this.message,
  });

  /// Whether the web authentication was successful
  bool success;

  /// Status message about the authentication
  String message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is WebCallbackResponseDto &&
    other.success == success &&
    other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (success.hashCode) +
    (message.hashCode);

  @override
  String toString() => 'WebCallbackResponseDto[success=$success, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'success'] = this.success;
      json[r'message'] = this.message;
    return json;
  }

  /// Returns a new [WebCallbackResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WebCallbackResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "WebCallbackResponseDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "WebCallbackResponseDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return WebCallbackResponseDto(
        success: mapValueOfType<bool>(json, r'success')!,
        message: mapValueOfType<String>(json, r'message')!,
      );
    }
    return null;
  }

  static List<WebCallbackResponseDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WebCallbackResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WebCallbackResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WebCallbackResponseDto> mapFromJson(dynamic json) {
    final map = <String, WebCallbackResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WebCallbackResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WebCallbackResponseDto-objects as value to a dart map
  static Map<String, List<WebCallbackResponseDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<WebCallbackResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = WebCallbackResponseDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'success',
    'message',
  };
}

