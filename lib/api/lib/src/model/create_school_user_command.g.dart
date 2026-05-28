// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_school_user_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateSchoolUserCommand extends CreateSchoolUserCommand {
  @override
  final String? applicationUserId;
  @override
  final String? schoolId;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final String? privateEmail;
  @override
  final String? phoneNumber;
  @override
  final String? street;
  @override
  final String? city;
  @override
  final String? zip;
  @override
  final Date? birthday;
  @override
  final Date? entryDate;
  @override
  final Roles? role;

  factory _$CreateSchoolUserCommand([
    void Function(CreateSchoolUserCommandBuilder)? updates,
  ]) => (CreateSchoolUserCommandBuilder()..update(updates))._build();

  _$CreateSchoolUserCommand._({
    this.applicationUserId,
    this.schoolId,
    this.firstName,
    this.lastName,
    this.email,
    this.privateEmail,
    this.phoneNumber,
    this.street,
    this.city,
    this.zip,
    this.birthday,
    this.entryDate,
    this.role,
  }) : super._();
  @override
  CreateSchoolUserCommand rebuild(
    void Function(CreateSchoolUserCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateSchoolUserCommandBuilder toBuilder() =>
      CreateSchoolUserCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateSchoolUserCommand &&
        applicationUserId == other.applicationUserId &&
        schoolId == other.schoolId &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        privateEmail == other.privateEmail &&
        phoneNumber == other.phoneNumber &&
        street == other.street &&
        city == other.city &&
        zip == other.zip &&
        birthday == other.birthday &&
        entryDate == other.entryDate &&
        role == other.role;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, applicationUserId.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, privateEmail.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, street.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, zip.hashCode);
    _$hash = $jc(_$hash, birthday.hashCode);
    _$hash = $jc(_$hash, entryDate.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateSchoolUserCommand')
          ..add('applicationUserId', applicationUserId)
          ..add('schoolId', schoolId)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('privateEmail', privateEmail)
          ..add('phoneNumber', phoneNumber)
          ..add('street', street)
          ..add('city', city)
          ..add('zip', zip)
          ..add('birthday', birthday)
          ..add('entryDate', entryDate)
          ..add('role', role))
        .toString();
  }
}

class CreateSchoolUserCommandBuilder
    implements
        Builder<CreateSchoolUserCommand, CreateSchoolUserCommandBuilder> {
  _$CreateSchoolUserCommand? _$v;

  String? _applicationUserId;
  String? get applicationUserId => _$this._applicationUserId;
  set applicationUserId(String? applicationUserId) =>
      _$this._applicationUserId = applicationUserId;

  String? _schoolId;
  String? get schoolId => _$this._schoolId;
  set schoolId(String? schoolId) => _$this._schoolId = schoolId;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _privateEmail;
  String? get privateEmail => _$this._privateEmail;
  set privateEmail(String? privateEmail) => _$this._privateEmail = privateEmail;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _street;
  String? get street => _$this._street;
  set street(String? street) => _$this._street = street;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _zip;
  String? get zip => _$this._zip;
  set zip(String? zip) => _$this._zip = zip;

  Date? _birthday;
  Date? get birthday => _$this._birthday;
  set birthday(Date? birthday) => _$this._birthday = birthday;

  Date? _entryDate;
  Date? get entryDate => _$this._entryDate;
  set entryDate(Date? entryDate) => _$this._entryDate = entryDate;

  Roles? _role;
  Roles? get role => _$this._role;
  set role(Roles? role) => _$this._role = role;

  CreateSchoolUserCommandBuilder() {
    CreateSchoolUserCommand._defaults(this);
  }

  CreateSchoolUserCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _applicationUserId = $v.applicationUserId;
      _schoolId = $v.schoolId;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _email = $v.email;
      _privateEmail = $v.privateEmail;
      _phoneNumber = $v.phoneNumber;
      _street = $v.street;
      _city = $v.city;
      _zip = $v.zip;
      _birthday = $v.birthday;
      _entryDate = $v.entryDate;
      _role = $v.role;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateSchoolUserCommand other) {
    _$v = other as _$CreateSchoolUserCommand;
  }

  @override
  void update(void Function(CreateSchoolUserCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateSchoolUserCommand build() => _build();

  _$CreateSchoolUserCommand _build() {
    final _$result =
        _$v ??
        _$CreateSchoolUserCommand._(
          applicationUserId: applicationUserId,
          schoolId: schoolId,
          firstName: firstName,
          lastName: lastName,
          email: email,
          privateEmail: privateEmail,
          phoneNumber: phoneNumber,
          street: street,
          city: city,
          zip: zip,
          birthday: birthday,
          entryDate: entryDate,
          role: role,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
