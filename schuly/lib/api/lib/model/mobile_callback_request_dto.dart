//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MobileCallbackRequestDto {
  /// Returns a new [MobileCallbackRequestDto] instance.
  MobileCallbackRequestDto({
    required this.code,
    required this.codeVerifier,
    this.state,
  });

  /// Authorization code from Microsoft
  String code;

  /// PKCE code verifier that was generated during URL creation
  String codeVerifier;

  String? state;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MobileCallbackRequestDto &&
    other.code == code &&
    other.codeVerifier == codeVerifier &&
    other.state == state;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (code.hashCode) +
    (codeVerifier.hashCode) +
    (state == null ? 0 : state!.hashCode);

  @override
  String toString() => 'MobileCallbackRequestDto[code=$code, codeVerifier=$codeVerifier, state=$state]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'code'] = this.code;
      json[r'code_verifier'] = this.codeVerifier;
    if (this.state != null) {
      json[r'state'] = this.state;
    } else {
      json[r'state'] = null;
    }
    return json;
  }

  /// Returns a new [MobileCallbackRequestDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MobileCallbackRequestDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MobileCallbackRequestDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MobileCallbackRequestDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MobileCallbackRequestDto(
        code: mapValueOfType<String>(json, r'code')!,
        codeVerifier: mapValueOfType<String>(json, r'code_verifier')!,
        state: mapValueOfType<String>(json, r'state'),
      );
    }
    return null;
  }

  static List<MobileCallbackRequestDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MobileCallbackRequestDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MobileCallbackRequestDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MobileCallbackRequestDto> mapFromJson(dynamic json) {
    final map = <String, MobileCallbackRequestDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MobileCallbackRequestDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MobileCallbackRequestDto-objects as value to a dart map
  static Map<String, List<MobileCallbackRequestDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MobileCallbackRequestDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MobileCallbackRequestDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'code',
    'code_verifier',
  };
}

