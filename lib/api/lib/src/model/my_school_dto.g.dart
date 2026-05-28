// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_school_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MySchoolDto extends MySchoolDto {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? fullName;

  factory _$MySchoolDto([void Function(MySchoolDtoBuilder)? updates]) =>
      (MySchoolDtoBuilder()..update(updates))._build();

  _$MySchoolDto._({this.id, this.name, this.email, this.fullName}) : super._();
  @override
  MySchoolDto rebuild(void Function(MySchoolDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MySchoolDtoBuilder toBuilder() => MySchoolDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MySchoolDto &&
        id == other.id &&
        name == other.name &&
        email == other.email &&
        fullName == other.fullName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MySchoolDto')
          ..add('id', id)
          ..add('name', name)
          ..add('email', email)
          ..add('fullName', fullName))
        .toString();
  }
}

class MySchoolDtoBuilder implements Builder<MySchoolDto, MySchoolDtoBuilder> {
  _$MySchoolDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  MySchoolDtoBuilder() {
    MySchoolDto._defaults(this);
  }

  MySchoolDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _email = $v.email;
      _fullName = $v.fullName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MySchoolDto other) {
    _$v = other as _$MySchoolDto;
  }

  @override
  void update(void Function(MySchoolDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MySchoolDto build() => _build();

  _$MySchoolDto _build() {
    final _$result =
        _$v ??
        _$MySchoolDto._(id: id, name: name, email: email, fullName: fullName);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
