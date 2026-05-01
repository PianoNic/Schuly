//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MobileOAuthUrlResponseDto {
  /// Returns a new [MobileOAuthUrlResponseDto] instance.
  MobileOAuthUrlResponseDto({
    required this.authorizationUrl,
    required this.codeVerifier,
  });

  /// The OAuth authorization URL to redirect the user to
  String authorizationUrl;

  /// PKCE code verifier that must be stored and used in the callback
  String codeVerifier;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MobileOAuthUrlResponseDto &&
    other.authorizationUrl == authorizationUrl &&
    other.codeVerifier == codeVerifier;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (authorizationUrl.hashCode) +
    (codeVerifier.hashCode);

  @override
  String toString() => 'MobileOAuthUrlResponseDto[authorizationUrl=$authorizationUrl, codeVerifier=$codeVerifier]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'authorization_url'] = this.authorizationUrl;
      json[r'code_verifier'] = this.codeVerifier;
    return json;
  }

  /// Returns a new [MobileOAuthUrlResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MobileOAuthUrlResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MobileOAuthUrlResponseDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MobileOAuthUrlResponseDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MobileOAuthUrlResponseDto(
        authorizationUrl: mapValueOfType<String>(json, r'authorization_url')!,
        codeVerifier: mapValueOfType<String>(json, r'code_verifier')!,
      );
    }
    return null;
  }

  static List<MobileOAuthUrlResponseDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MobileOAuthUrlResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MobileOAuthUrlResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MobileOAuthUrlResponseDto> mapFromJson(dynamic json) {
    final map = <String, MobileOAuthUrlResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MobileOAuthUrlResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MobileOAuthUrlResponseDto-objects as value to a dart map
  static Map<String, List<MobileOAuthUrlResponseDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MobileOAuthUrlResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MobileOAuthUrlResponseDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'authorization_url',
    'code_verifier',
  };
}

