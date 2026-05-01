// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_exam_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateExamCommand extends UpdateExamCommand {
  @override
  final String? examId;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final ExamType? type;
  @override
  final String? classId;

  factory _$UpdateExamCommand(
          [void Function(UpdateExamCommandBuilder)? updates]) =>
      (UpdateExamCommandBuilder()..update(updates))._build();

  _$UpdateExamCommand._(
      {this.examId, this.name, this.description, this.type, this.classId})
      : super._();
  @override
  UpdateExamCommand rebuild(void Function(UpdateExamCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateExamCommandBuilder toBuilder() =>
      UpdateExamCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateExamCommand &&
        examId == other.examId &&
        name == other.name &&
        description == other.description &&
        type == other.type &&
        classId == other.classId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, examId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateExamCommand')
          ..add('examId', examId)
          ..add('name', name)
          ..add('description', description)
          ..add('type', type)
          ..add('classId', classId))
        .toString();
  }
}

class UpdateExamCommandBuilder
    implements Builder<UpdateExamCommand, UpdateExamCommandBuilder> {
  _$UpdateExamCommand? _$v;

  String? _examId;
  String? get examId => _$this._examId;
  set examId(String? examId) => _$this._examId = examId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ExamType? _type;
  ExamType? get type => _$this._type;
  set type(ExamType? type) => _$this._type = type;

  String? _classId;
  String? get classId => _$this._classId;
  set classId(String? classId) => _$this._classId = classId;

  UpdateExamCommandBuilder() {
    UpdateExamCommand._defaults(this);
  }

  UpdateExamCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _examId = $v.examId;
      _name = $v.name;
      _description = $v.description;
      _type = $v.type;
      _classId = $v.classId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateExamCommand other) {
    _$v = other as _$UpdateExamCommand;
  }

  @override
  void update(void Function(UpdateExamCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateExamCommand build() => _build();

  _$UpdateExamCommand _build() {
    final _$result = _$v ??
        _$UpdateExamCommand._(
          examId: examId,
          name: name,
          description: description,
          type: type,
          classId: classId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
