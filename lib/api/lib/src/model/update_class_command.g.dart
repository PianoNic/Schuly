// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_class_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateClassCommand extends UpdateClassCommand {
  @override
  final String? classId;
  @override
  final String? name;
  @override
  final String? description;

  factory _$UpdateClassCommand(
          [void Function(UpdateClassCommandBuilder)? updates]) =>
      (UpdateClassCommandBuilder()..update(updates))._build();

  _$UpdateClassCommand._({this.classId, this.name, this.description})
      : super._();
  @override
  UpdateClassCommand rebuild(
          void Function(UpdateClassCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateClassCommandBuilder toBuilder() =>
      UpdateClassCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateClassCommand &&
        classId == other.classId &&
        name == other.name &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateClassCommand')
          ..add('classId', classId)
          ..add('name', name)
          ..add('description', description))
        .toString();
  }
}

class UpdateClassCommandBuilder
    implements Builder<UpdateClassCommand, UpdateClassCommandBuilder> {
  _$UpdateClassCommand? _$v;

  String? _classId;
  String? get classId => _$this._classId;
  set classId(String? classId) => _$this._classId = classId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  UpdateClassCommandBuilder() {
    UpdateClassCommand._defaults(this);
  }

  UpdateClassCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _classId = $v.classId;
      _name = $v.name;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateClassCommand other) {
    _$v = other as _$UpdateClassCommand;
  }

  @override
  void update(void Function(UpdateClassCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateClassCommand build() => _build();

  _$UpdateClassCommand _build() {
    final _$result = _$v ??
        _$UpdateClassCommand._(
          classId: classId,
          name: name,
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
