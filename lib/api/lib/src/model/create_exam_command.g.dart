// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_exam_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateExamCommand extends CreateExamCommand {
  @override
  final String? name;
  @override
  final String? description;
  @override
  final ExamType? type;
  @override
  final String? classId;

  factory _$CreateExamCommand(
          [void Function(CreateExamCommandBuilder)? updates]) =>
      (CreateExamCommandBuilder()..update(updates))._build();

  _$CreateExamCommand._({this.name, this.description, this.type, this.classId})
      : super._();
  @override
  CreateExamCommand rebuild(void Function(CreateExamCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateExamCommandBuilder toBuilder() =>
      CreateExamCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateExamCommand &&
        name == other.name &&
        description == other.description &&
        type == other.type &&
        classId == other.classId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateExamCommand')
          ..add('name', name)
          ..add('description', description)
          ..add('type', type)
          ..add('classId', classId))
        .toString();
  }
}

class CreateExamCommandBuilder
    implements Builder<CreateExamCommand, CreateExamCommandBuilder> {
  _$CreateExamCommand? _$v;

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

  CreateExamCommandBuilder() {
    CreateExamCommand._defaults(this);
  }

  CreateExamCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _description = $v.description;
      _type = $v.type;
      _classId = $v.classId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateExamCommand other) {
    _$v = other as _$CreateExamCommand;
  }

  @override
  void update(void Function(CreateExamCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateExamCommand build() => _build();

  _$CreateExamCommand _build() {
    final _$result = _$v ??
        _$CreateExamCommand._(
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
