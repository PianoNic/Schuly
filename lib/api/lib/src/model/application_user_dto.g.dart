// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_user_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApplicationUserDto extends ApplicationUserDto {
  @override
  final String? id;
  @override
  final String? externalId;
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? profilePictureUrl;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final BuiltList<SchoolUserSummaryDto>? schoolUsers;

  factory _$ApplicationUserDto(
          [void Function(ApplicationUserDtoBuilder)? updates]) =>
      (ApplicationUserDtoBuilder()..update(updates))._build();

  _$ApplicationUserDto._(
      {this.id,
      this.externalId,
      this.email,
      this.displayName,
      this.profilePictureUrl,
      this.createdAt,
      this.updatedAt,
      this.schoolUsers})
      : super._();
  @override
  ApplicationUserDto rebuild(
          void Function(ApplicationUserDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApplicationUserDtoBuilder toBuilder() =>
      ApplicationUserDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApplicationUserDto &&
        id == other.id &&
        externalId == other.externalId &&
        email == other.email &&
        displayName == other.displayName &&
        profilePictureUrl == other.profilePictureUrl &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolUsers == other.schoolUsers;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, externalId.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, profilePictureUrl.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolUsers.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApplicationUserDto')
          ..add('id', id)
          ..add('externalId', externalId)
          ..add('email', email)
          ..add('displayName', displayName)
          ..add('profilePictureUrl', profilePictureUrl)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolUsers', schoolUsers))
        .toString();
  }
}

class ApplicationUserDtoBuilder
    implements Builder<ApplicationUserDto, ApplicationUserDtoBuilder> {
  _$ApplicationUserDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _externalId;
  String? get externalId => _$this._externalId;
  set externalId(String? externalId) => _$this._externalId = externalId;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _profilePictureUrl;
  String? get profilePictureUrl => _$this._profilePictureUrl;
  set profilePictureUrl(String? profilePictureUrl) =>
      _$this._profilePictureUrl = profilePictureUrl;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  ListBuilder<SchoolUserSummaryDto>? _schoolUsers;
  ListBuilder<SchoolUserSummaryDto> get schoolUsers =>
      _$this._schoolUsers ??= ListBuilder<SchoolUserSummaryDto>();
  set schoolUsers(ListBuilder<SchoolUserSummaryDto>? schoolUsers) =>
      _$this._schoolUsers = schoolUsers;

  ApplicationUserDtoBuilder() {
    ApplicationUserDto._defaults(this);
  }

  ApplicationUserDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _externalId = $v.externalId;
      _email = $v.email;
      _displayName = $v.displayName;
      _profilePictureUrl = $v.profilePictureUrl;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolUsers = $v.schoolUsers?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApplicationUserDto other) {
    _$v = other as _$ApplicationUserDto;
  }

  @override
  void update(void Function(ApplicationUserDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApplicationUserDto build() => _build();

  _$ApplicationUserDto _build() {
    _$ApplicationUserDto _$result;
    try {
      _$result = _$v ??
          _$ApplicationUserDto._(
            id: id,
            externalId: externalId,
            email: email,
            displayName: displayName,
            profilePictureUrl: profilePictureUrl,
            createdAt: createdAt,
            updatedAt: updatedAt,
            schoolUsers: _schoolUsers?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'schoolUsers';
        _schoolUsers?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ApplicationUserDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
