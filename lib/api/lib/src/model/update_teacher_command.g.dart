// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_teacher_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateTeacherCommand extends UpdateTeacherCommand {
  @override
  final String? teacherId;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? code;
  @override
  final String? email;

  factory _$UpdateTeacherCommand([
    void Function(UpdateTeacherCommandBuilder)? updates,
  ]) => (UpdateTeacherCommandBuilder()..update(updates))._build();

  _$UpdateTeacherCommand._({
    this.teacherId,
    this.firstName,
    this.lastName,
    this.code,
    this.email,
  }) : super._();
  @override
  UpdateTeacherCommand rebuild(
    void Function(UpdateTeacherCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateTeacherCommandBuilder toBuilder() =>
      UpdateTeacherCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateTeacherCommand &&
        teacherId == other.teacherId &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        code == other.code &&
        email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, teacherId.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateTeacherCommand')
          ..add('teacherId', teacherId)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('code', code)
          ..add('email', email))
        .toString();
  }
}

class UpdateTeacherCommandBuilder
    implements Builder<UpdateTeacherCommand, UpdateTeacherCommandBuilder> {
  _$UpdateTeacherCommand? _$v;

  String? _teacherId;
  String? get teacherId => _$this._teacherId;
  set teacherId(String? teacherId) => _$this._teacherId = teacherId;

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

  UpdateTeacherCommandBuilder() {
    UpdateTeacherCommand._defaults(this);
  }

  UpdateTeacherCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _teacherId = $v.teacherId;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _code = $v.code;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateTeacherCommand other) {
    _$v = other as _$UpdateTeacherCommand;
  }

  @override
  void update(void Function(UpdateTeacherCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateTeacherCommand build() => _build();

  _$UpdateTeacherCommand _build() {
    final _$result =
        _$v ??
        _$UpdateTeacherCommand._(
          teacherId: teacherId,
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
