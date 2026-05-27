// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PluginDto extends PluginDto {
  @override
  final String? name;
  @override
  final String? version;

  factory _$PluginDto([void Function(PluginDtoBuilder)? updates]) =>
      (PluginDtoBuilder()..update(updates))._build();

  _$PluginDto._({this.name, this.version}) : super._();
  @override
  PluginDto rebuild(void Function(PluginDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PluginDtoBuilder toBuilder() => PluginDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PluginDto && name == other.name && version == other.version;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PluginDto')
          ..add('name', name)
          ..add('version', version))
        .toString();
  }
}

class PluginDtoBuilder implements Builder<PluginDto, PluginDtoBuilder> {
  _$PluginDto? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  PluginDtoBuilder() {
    PluginDto._defaults(this);
  }

  PluginDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _version = $v.version;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PluginDto other) {
    _$v = other as _$PluginDto;
  }

  @override
  void update(void Function(PluginDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PluginDto build() => _build();

  _$PluginDto _build() {
    final _$result = _$v ?? _$PluginDto._(name: name, version: version);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
