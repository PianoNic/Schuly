// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_teacher_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateTeacherCommand extends CreateTeacherCommand {
  @override
  final String? schoolId;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? code;
  @override
  final String? email;

  factory _$CreateTeacherCommand([
    void Function(CreateTeacherCommandBuilder)? updates,
  ]) => (CreateTeacherCommandBuilder()..update(updates))._build();

  _$CreateTeacherCommand._({
    this.schoolId,
    this.firstName,
    this.lastName,
    this.code,
    this.email,
  }) : super._();
  @override
  CreateTeacherCommand rebuild(
    void Function(CreateTeacherCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateTeacherCommandBuilder toBuilder() =>
      CreateTeacherCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateTeacherCommand &&
        schoolId == other.schoolId &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        code == other.code &&
        email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateTeacherCommand')
          ..add('schoolId', schoolId)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('code', code)
          ..add('email', email))
        .toString();
  }
}

class CreateTeacherCommandBuilder
    implements Builder<CreateTeacherCommand, CreateTeacherCommandBuilder> {
  _$CreateTeacherCommand? _$v;

  String? _schoolId;
  String? get schoolId => _$this._schoolId;
  set schoolId(String? schoolId) => _$this._schoolId = schoolId;

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

  CreateTeacherCommandBuilder() {
    CreateTeacherCommand._defaults(this);
  }

  CreateTeacherCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _schoolId = $v.schoolId;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _code = $v.code;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateTeacherCommand other) {
    _$v = other as _$CreateTeacherCommand;
  }

  @override
  void update(void Function(CreateTeacherCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateTeacherCommand build() => _build();

  _$CreateTeacherCommand _build() {
    final _$result =
        _$v ??
        _$CreateTeacherCommand._(
          schoolId: schoolId,
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
