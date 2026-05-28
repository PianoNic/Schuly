// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherDto extends TeacherDto {
  @override
  final String? id;
  @override
  final String? schoolId;
  @override
  final String? schoolName;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? code;
  @override
  final String? email;

  factory _$TeacherDto([void Function(TeacherDtoBuilder)? updates]) =>
      (TeacherDtoBuilder()..update(updates))._build();

  _$TeacherDto._({
    this.id,
    this.schoolId,
    this.schoolName,
    this.firstName,
    this.lastName,
    this.code,
    this.email,
  }) : super._();
  @override
  TeacherDto rebuild(void Function(TeacherDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TeacherDtoBuilder toBuilder() => TeacherDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherDto &&
        id == other.id &&
        schoolId == other.schoolId &&
        schoolName == other.schoolName &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        code == other.code &&
        email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, schoolName.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherDto')
          ..add('id', id)
          ..add('schoolId', schoolId)
          ..add('schoolName', schoolName)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('code', code)
          ..add('email', email))
        .toString();
  }
}

class TeacherDtoBuilder implements Builder<TeacherDto, TeacherDtoBuilder> {
  _$TeacherDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

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

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  TeacherDtoBuilder() {
    TeacherDto._defaults(this);
  }

  TeacherDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _schoolId = $v.schoolId;
      _schoolName = $v.schoolName;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _code = $v.code;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherDto other) {
    _$v = other as _$TeacherDto;
  }

  @override
  void update(void Function(TeacherDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherDto build() => _build();

  _$TeacherDto _build() {
    final _$result =
        _$v ??
        _$TeacherDto._(
          id: id,
          schoolId: schoolId,
          schoolName: schoolName,
          firstName: firstName,
          lastName: lastName,
          code: code,
          email: email,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
