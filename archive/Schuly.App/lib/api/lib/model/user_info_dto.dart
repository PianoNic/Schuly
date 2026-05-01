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
    this.id,
    this.userType,
    this.idNr,
    this.lastName,
    this.firstName,
    this.loginActive,
    this.gender,
    this.birthday,
    this.street,
    this.addressLine2,
    this.postOfficeBox,
    this.zip,
    this.city,
    this.nationality,
    this.hometown,
    this.phone,
    this.mobile,
    this.email,
    this.emailPrivate,
    this.profil1,
    this.profil2,
    this.entryDate,
    this.exitDate,
    this.regularClasses = const [],
    this.additionalClasses = const [],
  });

  String? id;

  String? userType;

  String? idNr;

  String? lastName;

  String? firstName;

  bool? loginActive;

  String? gender;

  String? birthday;

  String? street;

  String? addressLine2;

  String? postOfficeBox;

  String? zip;

  String? city;

  String? nationality;

  String? hometown;

  String? phone;

  String? mobile;

  String? email;

  String? emailPrivate;

  String? profil1;

  String? profil2;

  String? entryDate;

  String? exitDate;

  List<ClassInfoDto>? regularClasses;

  List<ClassInfoDto>? additionalClasses;

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
    (id == null ? 0 : id!.hashCode) +
    (userType == null ? 0 : userType!.hashCode) +
    (idNr == null ? 0 : idNr!.hashCode) +
    (lastName == null ? 0 : lastName!.hashCode) +
    (firstName == null ? 0 : firstName!.hashCode) +
    (loginActive == null ? 0 : loginActive!.hashCode) +
    (gender == null ? 0 : gender!.hashCode) +
    (birthday == null ? 0 : birthday!.hashCode) +
    (street == null ? 0 : street!.hashCode) +
    (addressLine2 == null ? 0 : addressLine2!.hashCode) +
    (postOfficeBox == null ? 0 : postOfficeBox!.hashCode) +
    (zip == null ? 0 : zip!.hashCode) +
    (city == null ? 0 : city!.hashCode) +
    (nationality == null ? 0 : nationality!.hashCode) +
    (hometown == null ? 0 : hometown!.hashCode) +
    (phone == null ? 0 : phone!.hashCode) +
    (mobile == null ? 0 : mobile!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (emailPrivate == null ? 0 : emailPrivate!.hashCode) +
    (profil1 == null ? 0 : profil1!.hashCode) +
    (profil2 == null ? 0 : profil2!.hashCode) +
    (entryDate == null ? 0 : entryDate!.hashCode) +
    (exitDate == null ? 0 : exitDate!.hashCode) +
    (regularClasses == null ? 0 : regularClasses!.hashCode) +
    (additionalClasses == null ? 0 : additionalClasses!.hashCode);

  @override
  String toString() => 'UserInfoDto[id=$id, userType=$userType, idNr=$idNr, lastName=$lastName, firstName=$firstName, loginActive=$loginActive, gender=$gender, birthday=$birthday, street=$street, addressLine2=$addressLine2, postOfficeBox=$postOfficeBox, zip=$zip, city=$city, nationality=$nationality, hometown=$hometown, phone=$phone, mobile=$mobile, email=$email, emailPrivate=$emailPrivate, profil1=$profil1, profil2=$profil2, entryDate=$entryDate, exitDate=$exitDate, regularClasses=$regularClasses, additionalClasses=$additionalClasses]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.userType != null) {
      json[r'userType'] = this.userType;
    } else {
      json[r'userType'] = null;
    }
    if (this.idNr != null) {
      json[r'idNr'] = this.idNr;
    } else {
      json[r'idNr'] = null;
    }
    if (this.lastName != null) {
      json[r'lastName'] = this.lastName;
    } else {
      json[r'lastName'] = null;
    }
    if (this.firstName != null) {
      json[r'firstName'] = this.firstName;
    } else {
      json[r'firstName'] = null;
    }
    if (this.loginActive != null) {
      json[r'loginActive'] = this.loginActive;
    } else {
      json[r'loginActive'] = null;
    }
    if (this.gender != null) {
      json[r'gender'] = this.gender;
    } else {
      json[r'gender'] = null;
    }
    if (this.birthday != null) {
      json[r'birthday'] = this.birthday;
    } else {
      json[r'birthday'] = null;
    }
    if (this.street != null) {
      json[r'street'] = this.street;
    } else {
      json[r'street'] = null;
    }
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
    if (this.zip != null) {
      json[r'zip'] = this.zip;
    } else {
      json[r'zip'] = null;
    }
    if (this.city != null) {
      json[r'city'] = this.city;
    } else {
      json[r'city'] = null;
    }
    if (this.nationality != null) {
      json[r'nationality'] = this.nationality;
    } else {
      json[r'nationality'] = null;
    }
    if (this.hometown != null) {
      json[r'hometown'] = this.hometown;
    } else {
      json[r'hometown'] = null;
    }
    if (this.phone != null) {
      json[r'phone'] = this.phone;
    } else {
      json[r'phone'] = null;
    }
    if (this.mobile != null) {
      json[r'mobile'] = this.mobile;
    } else {
      json[r'mobile'] = null;
    }
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.emailPrivate != null) {
      json[r'emailPrivate'] = this.emailPrivate;
    } else {
      json[r'emailPrivate'] = null;
    }
    if (this.profil1 != null) {
      json[r'profil1'] = this.profil1;
    } else {
      json[r'profil1'] = null;
    }
    if (this.profil2 != null) {
      json[r'profil2'] = this.profil2;
    } else {
      json[r'profil2'] = null;
    }
    if (this.entryDate != null) {
      json[r'entryDate'] = this.entryDate;
    } else {
      json[r'entryDate'] = null;
    }
    if (this.exitDate != null) {
      json[r'exitDate'] = this.exitDate;
    } else {
      json[r'exitDate'] = null;
    }
    if (this.regularClasses != null) {
      json[r'regularClasses'] = this.regularClasses;
    } else {
      json[r'regularClasses'] = null;
    }
    if (this.additionalClasses != null) {
      json[r'additionalClasses'] = this.additionalClasses;
    } else {
      json[r'additionalClasses'] = null;
    }
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
        id: mapValueOfType<String>(json, r'id'),
        userType: mapValueOfType<String>(json, r'userType'),
        idNr: mapValueOfType<String>(json, r'idNr'),
        lastName: mapValueOfType<String>(json, r'lastName'),
        firstName: mapValueOfType<String>(json, r'firstName'),
        loginActive: mapValueOfType<bool>(json, r'loginActive'),
        gender: mapValueOfType<String>(json, r'gender'),
        birthday: mapValueOfType<String>(json, r'birthday'),
        street: mapValueOfType<String>(json, r'street'),
        addressLine2: mapValueOfType<String>(json, r'addressLine2'),
        postOfficeBox: mapValueOfType<String>(json, r'postOfficeBox'),
        zip: mapValueOfType<String>(json, r'zip'),
        city: mapValueOfType<String>(json, r'city'),
        nationality: mapValueOfType<String>(json, r'nationality'),
        hometown: mapValueOfType<String>(json, r'hometown'),
        phone: mapValueOfType<String>(json, r'phone'),
        mobile: mapValueOfType<String>(json, r'mobile'),
        email: mapValueOfType<String>(json, r'email'),
        emailPrivate: mapValueOfType<String>(json, r'emailPrivate'),
        profil1: mapValueOfType<String>(json, r'profil1'),
        profil2: mapValueOfType<String>(json, r'profil2'),
        entryDate: mapValueOfType<String>(json, r'entryDate'),
        exitDate: mapValueOfType<String>(json, r'exitDate'),
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
  };
}

