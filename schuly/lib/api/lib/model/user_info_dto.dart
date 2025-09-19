//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserInfoDto {
  /// Returns a new [UserInfoDto] instance.
  UserInfoDto({
    required this.id,
    required this.userType,
    required this.idNr,
    required this.lastName,
    required this.firstName,
    required this.loginActive,
    required this.gender,
    required this.birthday,
    required this.street,
    this.addressLine2,
    this.postOfficeBox,
    required this.zip,
    required this.city,
    required this.nationality,
    required this.hometown,
    required this.phone,
    required this.mobile,
    required this.email,
    required this.emailPrivate,
    required this.profil1,
    this.profil2,
    required this.entryDate,
    required this.exitDate,
    this.regularClasses = const [],
    this.additionalClasses = const [],
  });

  String id;

  String userType;

  String idNr;

  String lastName;

  String firstName;

  bool loginActive;

  String gender;

  String birthday;

  String street;

  String? addressLine2;

  String? postOfficeBox;

  String zip;

  String city;

  String nationality;

  String hometown;

  String phone;

  String mobile;

  String email;

  String emailPrivate;

  String profil1;

  String? profil2;

  String entryDate;

  String exitDate;

  List<ClassInfoDto> regularClasses;

  List<ClassInfoDto> additionalClasses;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserInfoDto &&
    other.id == id &&
    other.userType == userType &&
    other.idNr == idNr &&
    other.lastName == lastName &&
    other.firstName == firstName &&
    other.loginActive == loginActive &&
    other.gender == gender &&
    other.birthday == birthday &&
    other.street == street &&
    other.addressLine2 == addressLine2 &&
    other.postOfficeBox == postOfficeBox &&
    other.zip == zip &&
    other.city == city &&
    other.nationality == nationality &&
    other.hometown == hometown &&
    other.phone == phone &&
    other.mobile == mobile &&
    other.email == email &&
    other.emailPrivate == emailPrivate &&
    other.profil1 == profil1 &&
    other.profil2 == profil2 &&
    other.entryDate == entryDate &&
    other.exitDate == exitDate &&
    _deepEquality.equals(other.regularClasses, regularClasses) &&
    _deepEquality.equals(other.additionalClasses, additionalClasses);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (userType.hashCode) +
    (idNr.hashCode) +
    (lastName.hashCode) +
    (firstName.hashCode) +
    (loginActive.hashCode) +
    (gender.hashCode) +
    (birthday.hashCode) +
    (street.hashCode) +
    (addressLine2 == null ? 0 : addressLine2!.hashCode) +
    (postOfficeBox == null ? 0 : postOfficeBox!.hashCode) +
    (zip.hashCode) +
    (city.hashCode) +
    (nationality.hashCode) +
    (hometown.hashCode) +
    (phone.hashCode) +
    (mobile.hashCode) +
    (email.hashCode) +
    (emailPrivate.hashCode) +
    (profil1.hashCode) +
    (profil2 == null ? 0 : profil2!.hashCode) +
    (entryDate.hashCode) +
    (exitDate.hashCode) +
    (regularClasses.hashCode) +
    (additionalClasses.hashCode);

  @override
  String toString() => 'UserInfoDto[id=$id, userType=$userType, idNr=$idNr, lastName=$lastName, firstName=$firstName, loginActive=$loginActive, gender=$gender, birthday=$birthday, street=$street, addressLine2=$addressLine2, postOfficeBox=$postOfficeBox, zip=$zip, city=$city, nationality=$nationality, hometown=$hometown, phone=$phone, mobile=$mobile, email=$email, emailPrivate=$emailPrivate, profil1=$profil1, profil2=$profil2, entryDate=$entryDate, exitDate=$exitDate, regularClasses=$regularClasses, additionalClasses=$additionalClasses]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'userType'] = this.userType;
      json[r'idNr'] = this.idNr;
      json[r'lastName'] = this.lastName;
      json[r'firstName'] = this.firstName;
      json[r'loginActive'] = this.loginActive;
      json[r'gender'] = this.gender;
      json[r'birthday'] = this.birthday;
      json[r'street'] = this.street;
    if (this.addressLine2 != null) {
      json[r'addressLine2'] = this.addressLine2;
    } else {
      json[r'addressLine2'] = null;
    }
    if (this.postOfficeBox != null) {
      json[r'postOfficeBox'] = this.postOfficeBox;
    } else {
      json[r'postOfficeBox'] = null;
    }
      json[r'zip'] = this.zip;
      json[r'city'] = this.city;
      json[r'nationality'] = this.nationality;
      json[r'hometown'] = this.hometown;
      json[r'phone'] = this.phone;
      json[r'mobile'] = this.mobile;
      json[r'email'] = this.email;
      json[r'emailPrivate'] = this.emailPrivate;
      json[r'profil1'] = this.profil1;
    if (this.profil2 != null) {
      json[r'profil2'] = this.profil2;
    } else {
      json[r'profil2'] = null;
    }
      json[r'entryDate'] = this.entryDate;
      json[r'exitDate'] = this.exitDate;
      json[r'regularClasses'] = this.regularClasses;
      json[r'additionalClasses'] = this.additionalClasses;
    return json;
  }

  /// Returns a new [UserInfoDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserInfoDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserInfoDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserInfoDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserInfoDto(
        id: mapValueOfType<String>(json, r'id')!,
        userType: mapValueOfType<String>(json, r'userType')!,
        idNr: mapValueOfType<String>(json, r'idNr')!,
        lastName: mapValueOfType<String>(json, r'lastName')!,
        firstName: mapValueOfType<String>(json, r'firstName')!,
        loginActive: mapValueOfType<bool>(json, r'loginActive')!,
        gender: mapValueOfType<String>(json, r'gender')!,
        birthday: mapValueOfType<String>(json, r'birthday')!,
        street: mapValueOfType<String>(json, r'street')!,
        addressLine2: mapValueOfType<String>(json, r'addressLine2'),
        postOfficeBox: mapValueOfType<String>(json, r'postOfficeBox'),
        zip: mapValueOfType<String>(json, r'zip')!,
        city: mapValueOfType<String>(json, r'city')!,
        nationality: mapValueOfType<String>(json, r'nationality')!,
        hometown: mapValueOfType<String>(json, r'hometown')!,
        phone: mapValueOfType<String>(json, r'phone')!,
        mobile: mapValueOfType<String>(json, r'mobile')!,
        email: mapValueOfType<String>(json, r'email')!,
        emailPrivate: mapValueOfType<String>(json, r'emailPrivate')!,
        profil1: mapValueOfType<String>(json, r'profil1')!,
        profil2: mapValueOfType<String>(json, r'profil2'),
        entryDate: mapValueOfType<String>(json, r'entryDate')!,
        exitDate: mapValueOfType<String>(json, r'exitDate')!,
        regularClasses: ClassInfoDto.listFromJson(json[r'regularClasses']),
        additionalClasses: ClassInfoDto.listFromJson(json[r'additionalClasses']),
      );
    }
    return null;
  }

  static List<UserInfoDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserInfoDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserInfoDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserInfoDto> mapFromJson(dynamic json) {
    final map = <String, UserInfoDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserInfoDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserInfoDto-objects as value to a dart map
  static Map<String, List<UserInfoDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserInfoDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserInfoDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'userType',
    'idNr',
    'lastName',
    'firstName',
    'loginActive',
    'gender',
    'birthday',
    'street',
    'zip',
    'city',
    'nationality',
    'hometown',
    'phone',
    'mobile',
    'email',
    'emailPrivate',
    'profil1',
    'entryDate',
    'exitDate',
  };
}

