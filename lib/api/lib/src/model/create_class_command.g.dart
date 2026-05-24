// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_class_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateClassCommand extends CreateClassCommand {
  @override
  final String? name;
  @override
  final String? description;

  factory _$CreateClassCommand(
          [void Function(CreateClassCommandBuilder)? updates]) =>
      (CreateClassCommandBuilder()..update(updates))._build();

  _$CreateClassCommand._({this.name, this.description}) : super._();
  @override
  CreateClassCommand rebuild(
          void Function(CreateClassCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateClassCommandBuilder toBuilder() =>
      CreateClassCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateClassCommand &&
        name == other.name &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateClassCommand')
          ..add('name', name)
          ..add('description', description))
        .toString();
  }
}

class CreateClassCommandBuilder
    implements Builder<CreateClassCommand, CreateClassCommandBuilder> {
  _$CreateClassCommand? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  CreateClassCommandBuilder() {
    CreateClassCommand._defaults(this);
  }

  CreateClassCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateClassCommand other) {
    _$v = other as _$CreateClassCommand;
  }

  @override
  void update(void Function(CreateClassCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateClassCommand build() => _build();

  _$CreateClassCommand _build() {
    final _$result = _$v ??
        _$CreateClassCommand._(
          name: name,
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
