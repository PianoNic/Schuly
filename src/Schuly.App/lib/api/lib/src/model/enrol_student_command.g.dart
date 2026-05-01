// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrol_student_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EnrolStudentCommand extends EnrolStudentCommand {
  @override
  final String? userId;
  @override
  final String? classId;

  factory _$EnrolStudentCommand(
          [void Function(EnrolStudentCommandBuilder)? updates]) =>
      (EnrolStudentCommandBuilder()..update(updates))._build();

  _$EnrolStudentCommand._({this.userId, this.classId}) : super._();
  @override
  EnrolStudentCommand rebuild(
          void Function(EnrolStudentCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EnrolStudentCommandBuilder toBuilder() =>
      EnrolStudentCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EnrolStudentCommand &&
        userId == other.userId &&
        classId == other.classId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EnrolStudentCommand')
          ..add('userId', userId)
          ..add('classId', classId))
        .toString();
  }
}

class EnrolStudentCommandBuilder
    implements Builder<EnrolStudentCommand, EnrolStudentCommandBuilder> {
  _$EnrolStudentCommand? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _classId;
  String? get classId => _$this._classId;
  set classId(String? classId) => _$this._classId = classId;

  EnrolStudentCommandBuilder() {
    EnrolStudentCommand._defaults(this);
  }

  EnrolStudentCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _classId = $v.classId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EnrolStudentCommand other) {
    _$v = other as _$EnrolStudentCommand;
  }

  @override
  void update(void Function(EnrolStudentCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EnrolStudentCommand build() => _build();

  _$EnrolStudentCommand _build() {
    final _$result = _$v ??
        _$EnrolStudentCommand._(
          userId: userId,
          classId: classId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
