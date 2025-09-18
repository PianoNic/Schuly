//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WebCallbackRequestDto {
  /// Returns a new [WebCallbackRequestDto] instance.
  WebCallbackRequestDto({
    required this.code,
    this.state,
  });

  /// Authorization code from Microsoft
  String code;

  String? state;

  @override
  bool operator ==(Object other) => identical(this, other) || other is WebCallbackRequestDto &&
    other.code == code &&
    other.state == state;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (code.hashCode) +
    (state == null ? 0 : state!.hashCode);

  @override
  String toString() => 'WebCallbackRequestDto[code=$code, state=$state]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'code'] = this.code;
    if (this.state != null) {
      json[r'state'] = this.state;
    } else {
      json[r'state'] = null;
    }
    return json;
  }

  /// Returns a new [WebCallbackRequestDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WebCallbackRequestDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "WebCallbackRequestDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "WebCallbackRequestDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return WebCallbackRequestDto(
        code: mapValueOfType<String>(json, r'code')!,
        state: mapValueOfType<String>(json, r'state'),
      );
    }
    return null;
  }

  static List<WebCallbackRequestDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WebCallbackRequestDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WebCallbackRequestDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WebCallbackRequestDto> mapFromJson(dynamic json) {
    final map = <String, WebCallbackRequestDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WebCallbackRequestDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WebCallbackRequestDto-objects as value to a dart map
  static Map<String, List<WebCallbackRequestDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<WebCallbackRequestDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = WebCallbackRequestDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'code',
  };
}

