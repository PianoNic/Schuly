// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_school_user_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateSchoolUserCommand extends UpdateSchoolUserCommand {
  @override
  final String? schoolUserId;
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
  final Date? leaveDate;
  @override
  final UserState? state;

  factory _$UpdateSchoolUserCommand([
    void Function(UpdateSchoolUserCommandBuilder)? updates,
  ]) => (UpdateSchoolUserCommandBuilder()..update(updates))._build();

  _$UpdateSchoolUserCommand._({
    this.schoolUserId,
    this.firstName,
    this.lastName,
    this.email,
    this.privateEmail,
    this.phoneNumber,
    this.street,
    this.city,
    this.zip,
    this.leaveDate,
    this.state,
  }) : super._();
  @override
  UpdateSchoolUserCommand rebuild(
    void Function(UpdateSchoolUserCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateSchoolUserCommandBuilder toBuilder() =>
      UpdateSchoolUserCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateSchoolUserCommand &&
        schoolUserId == other.schoolUserId &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        privateEmail == other.privateEmail &&
        phoneNumber == other.phoneNumber &&
        street == other.street &&
        city == other.city &&
        zip == other.zip &&
        leaveDate == other.leaveDate &&
        state == other.state;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, schoolUserId.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, privateEmail.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, street.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, zip.hashCode);
    _$hash = $jc(_$hash, leaveDate.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateSchoolUserCommand')
          ..add('schoolUserId', schoolUserId)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('privateEmail', privateEmail)
          ..add('phoneNumber', phoneNumber)
          ..add('street', street)
          ..add('city', city)
          ..add('zip', zip)
          ..add('leaveDate', leaveDate)
          ..add('state', state))
        .toString();
  }
}

class UpdateSchoolUserCommandBuilder
    implements
        Builder<UpdateSchoolUserCommand, UpdateSchoolUserCommandBuilder> {
  _$UpdateSchoolUserCommand? _$v;

  String? _schoolUserId;
  String? get schoolUserId => _$this._schoolUserId;
  set schoolUserId(String? schoolUserId) => _$this._schoolUserId = schoolUserId;

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

  Date? _leaveDate;
  Date? get leaveDate => _$this._leaveDate;
  set leaveDate(Date? leaveDate) => _$this._leaveDate = leaveDate;

  UserState? _state;
  UserState? get state => _$this._state;
  set state(UserState? state) => _$this._state = state;

  UpdateSchoolUserCommandBuilder() {
    UpdateSchoolUserCommand._defaults(this);
  }

  UpdateSchoolUserCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _schoolUserId = $v.schoolUserId;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _email = $v.email;
      _privateEmail = $v.privateEmail;
      _phoneNumber = $v.phoneNumber;
      _street = $v.street;
      _city = $v.city;
      _zip = $v.zip;
      _leaveDate = $v.leaveDate;
      _state = $v.state;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateSchoolUserCommand other) {
    _$v = other as _$UpdateSchoolUserCommand;
  }

  @override
  void update(void Function(UpdateSchoolUserCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateSchoolUserCommand build() => _build();

  _$UpdateSchoolUserCommand _build() {
    final _$result =
        _$v ??
        _$UpdateSchoolUserCommand._(
          schoolUserId: schoolUserId,
          firstName: firstName,
          lastName: lastName,
          email: email,
          privateEmail: privateEmail,
          phoneNumber: phoneNumber,
          street: street,
          city: city,
          zip: zip,
          leaveDate: leaveDate,
          state: state,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
