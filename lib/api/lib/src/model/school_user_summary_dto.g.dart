// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_user_summary_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SchoolUserSummaryDto extends SchoolUserSummaryDto {
  @override
  final String? id;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final String? role;

  factory _$SchoolUserSummaryDto([
    void Function(SchoolUserSummaryDtoBuilder)? updates,
  ]) => (SchoolUserSummaryDtoBuilder()..update(updates))._build();

  _$SchoolUserSummaryDto._({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
  }) : super._();
  @override
  SchoolUserSummaryDto rebuild(
    void Function(SchoolUserSummaryDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SchoolUserSummaryDtoBuilder toBuilder() =>
      SchoolUserSummaryDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SchoolUserSummaryDto &&
        id == other.id &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        role == other.role;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SchoolUserSummaryDto')
          ..add('id', id)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('role', role))
        .toString();
  }
}

class SchoolUserSummaryDtoBuilder
    implements Builder<SchoolUserSummaryDto, SchoolUserSummaryDtoBuilder> {
  _$SchoolUserSummaryDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  SchoolUserSummaryDtoBuilder() {
    SchoolUserSummaryDto._defaults(this);
  }

  SchoolUserSummaryDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _email = $v.email;
      _role = $v.role;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SchoolUserSummaryDto other) {
    _$v = other as _$SchoolUserSummaryDto;
  }

  @override
  void update(void Function(SchoolUserSummaryDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SchoolUserSummaryDto build() => _build();

  _$SchoolUserSummaryDto _build() {
    final _$result =
        _$v ??
        _$SchoolUserSummaryDto._(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          role: role,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
