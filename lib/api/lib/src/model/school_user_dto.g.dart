// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_user_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SchoolUserDto extends SchoolUserDto {
  @override
  final String? id;
  @override
  final String? applicationUserId;
  @override
  final String? schoolId;
  @override
  final String? schoolName;
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
  final Date birthday;
  @override
  final Date entryDate;
  @override
  final Date? leaveDate;
  @override
  final Roles role;
  @override
  final UserState? state;
  @override
  final String? studentNumber;
  @override
  final String? teacherCode;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final BuiltList<AbsenceDto>? absences;
  @override
  final BuiltList<GradeDto>? grades;
  @override
  final BuiltList<UserClassDto>? classes;

  factory _$SchoolUserDto([void Function(SchoolUserDtoBuilder)? updates]) =>
      (SchoolUserDtoBuilder()..update(updates))._build();

  _$SchoolUserDto._({
    this.id,
    this.applicationUserId,
    this.schoolId,
    this.schoolName,
    this.firstName,
    this.lastName,
    this.email,
    this.privateEmail,
    this.phoneNumber,
    this.street,
    this.city,
    this.zip,
    required this.birthday,
    required this.entryDate,
    this.leaveDate,
    required this.role,
    this.state,
    this.studentNumber,
    this.teacherCode,
    this.createdAt,
    this.updatedAt,
    this.absences,
    this.grades,
    this.classes,
  }) : super._();
  @override
  SchoolUserDto rebuild(void Function(SchoolUserDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SchoolUserDtoBuilder toBuilder() => SchoolUserDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SchoolUserDto &&
        id == other.id &&
        applicationUserId == other.applicationUserId &&
        schoolId == other.schoolId &&
        schoolName == other.schoolName &&
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
        leaveDate == other.leaveDate &&
        role == other.role &&
        state == other.state &&
        studentNumber == other.studentNumber &&
        teacherCode == other.teacherCode &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        absences == other.absences &&
        grades == other.grades &&
        classes == other.classes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, applicationUserId.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, schoolName.hashCode);
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
    _$hash = $jc(_$hash, leaveDate.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, studentNumber.hashCode);
    _$hash = $jc(_$hash, teacherCode.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, absences.hashCode);
    _$hash = $jc(_$hash, grades.hashCode);
    _$hash = $jc(_$hash, classes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SchoolUserDto')
          ..add('id', id)
          ..add('applicationUserId', applicationUserId)
          ..add('schoolId', schoolId)
          ..add('schoolName', schoolName)
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
          ..add('leaveDate', leaveDate)
          ..add('role', role)
          ..add('state', state)
          ..add('studentNumber', studentNumber)
          ..add('teacherCode', teacherCode)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('absences', absences)
          ..add('grades', grades)
          ..add('classes', classes))
        .toString();
  }
}

class SchoolUserDtoBuilder
    implements Builder<SchoolUserDto, SchoolUserDtoBuilder> {
  _$SchoolUserDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _applicationUserId;
  String? get applicationUserId => _$this._applicationUserId;
  set applicationUserId(String? applicationUserId) =>
      _$this._applicationUserId = applicationUserId;

  String? _schoolId;
  String? get schoolId => _$this._schoolId;
  set schoolId(String? schoolId) => _$this._schoolId = schoolId;

  String? _schoolName;
  String? get schoolName => _$this._schoolName;
  set schoolName(String? schoolName) => _$this._schoolName = schoolName;

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

  Date? _leaveDate;
  Date? get leaveDate => _$this._leaveDate;
  set leaveDate(Date? leaveDate) => _$this._leaveDate = leaveDate;

  Roles? _role;
  Roles? get role => _$this._role;
  set role(Roles? role) => _$this._role = role;

  UserState? _state;
  UserState? get state => _$this._state;
  set state(UserState? state) => _$this._state = state;

  String? _studentNumber;
  String? get studentNumber => _$this._studentNumber;
  set studentNumber(String? studentNumber) =>
      _$this._studentNumber = studentNumber;

  String? _teacherCode;
  String? get teacherCode => _$this._teacherCode;
  set teacherCode(String? teacherCode) => _$this._teacherCode = teacherCode;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  ListBuilder<AbsenceDto>? _absences;
  ListBuilder<AbsenceDto> get absences =>
      _$this._absences ??= ListBuilder<AbsenceDto>();
  set absences(ListBuilder<AbsenceDto>? absences) =>
      _$this._absences = absences;

  ListBuilder<GradeDto>? _grades;
  ListBuilder<GradeDto> get grades =>
      _$this._grades ??= ListBuilder<GradeDto>();
  set grades(ListBuilder<GradeDto>? grades) => _$this._grades = grades;

  ListBuilder<UserClassDto>? _classes;
  ListBuilder<UserClassDto> get classes =>
      _$this._classes ??= ListBuilder<UserClassDto>();
  set classes(ListBuilder<UserClassDto>? classes) => _$this._classes = classes;

  SchoolUserDtoBuilder() {
    SchoolUserDto._defaults(this);
  }

  SchoolUserDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _applicationUserId = $v.applicationUserId;
      _schoolId = $v.schoolId;
      _schoolName = $v.schoolName;
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
      _leaveDate = $v.leaveDate;
      _role = $v.role;
      _state = $v.state;
      _studentNumber = $v.studentNumber;
      _teacherCode = $v.teacherCode;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _absences = $v.absences?.toBuilder();
      _grades = $v.grades?.toBuilder();
      _classes = $v.classes?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SchoolUserDto other) {
    _$v = other as _$SchoolUserDto;
  }

  @override
  void update(void Function(SchoolUserDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SchoolUserDto build() => _build();

  _$SchoolUserDto _build() {
    _$SchoolUserDto _$result;
    try {
      _$result =
          _$v ??
          _$SchoolUserDto._(
            id: id,
            applicationUserId: applicationUserId,
            schoolId: schoolId,
            schoolName: schoolName,
            firstName: firstName,
            lastName: lastName,
            email: email,
            privateEmail: privateEmail,
            phoneNumber: phoneNumber,
            street: street,
            city: city,
            zip: zip,
            birthday: BuiltValueNullFieldError.checkNotNull(
              birthday,
              r'SchoolUserDto',
              'birthday',
            ),
            entryDate: BuiltValueNullFieldError.checkNotNull(
              entryDate,
              r'SchoolUserDto',
              'entryDate',
            ),
            leaveDate: leaveDate,
            role: BuiltValueNullFieldError.checkNotNull(
              role,
              r'SchoolUserDto',
              'role',
            ),
            state: state,
            studentNumber: studentNumber,
            teacherCode: teacherCode,
            createdAt: createdAt,
            updatedAt: updatedAt,
            absences: _absences?.build(),
            grades: _grades?.build(),
            classes: _classes?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'absences';
        _absences?.build();
        _$failedField = 'grades';
        _grades?.build();
        _$failedField = 'classes';
        _classes?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SchoolUserDto',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
