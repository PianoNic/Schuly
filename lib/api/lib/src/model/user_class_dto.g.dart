// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_class_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserClassDto extends UserClassDto {
  @override
  final String classId;
  @override
  final String? className;

  factory _$UserClassDto([void Function(UserClassDtoBuilder)? updates]) =>
      (UserClassDtoBuilder()..update(updates))._build();

  _$UserClassDto._({required this.classId, this.className}) : super._();
  @override
  UserClassDto rebuild(void Function(UserClassDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserClassDtoBuilder toBuilder() => UserClassDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserClassDto &&
        classId == other.classId &&
        className == other.className;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jc(_$hash, className.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserClassDto')
          ..add('classId', classId)
          ..add('className', className))
        .toString();
  }
}

class UserClassDtoBuilder
    implements Builder<UserClassDto, UserClassDtoBuilder> {
  _$UserClassDto? _$v;

  String? _classId;
  String? get classId => _$this._classId;
  set classId(String? classId) => _$this._classId = classId;

  String? _className;
  String? get className => _$this._className;
  set className(String? className) => _$this._className = className;

  UserClassDtoBuilder() {
    UserClassDto._defaults(this);
  }

  UserClassDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _classId = $v.classId;
      _className = $v.className;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserClassDto other) {
    _$v = other as _$UserClassDto;
  }

  @override
  void update(void Function(UserClassDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserClassDto build() => _build();

  _$UserClassDto _build() {
    final _$result =
        _$v ??
        _$UserClassDto._(
          classId: BuiltValueNullFieldError.checkNotNull(
            classId,
            r'UserClassDto',
            'classId',
          ),
          className: className,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
