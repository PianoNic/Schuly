// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_application_user_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateApplicationUserCommand extends UpdateApplicationUserCommand {
  @override
  final String? applicationUserId;
  @override
  final String? displayName;
  @override
  final String? profilePictureUrl;

  factory _$UpdateApplicationUserCommand(
          [void Function(UpdateApplicationUserCommandBuilder)? updates]) =>
      (UpdateApplicationUserCommandBuilder()..update(updates))._build();

  _$UpdateApplicationUserCommand._(
      {this.applicationUserId, this.displayName, this.profilePictureUrl})
      : super._();
  @override
  UpdateApplicationUserCommand rebuild(
          void Function(UpdateApplicationUserCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateApplicationUserCommandBuilder toBuilder() =>
      UpdateApplicationUserCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateApplicationUserCommand &&
        applicationUserId == other.applicationUserId &&
        displayName == other.displayName &&
        profilePictureUrl == other.profilePictureUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, applicationUserId.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, profilePictureUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateApplicationUserCommand')
          ..add('applicationUserId', applicationUserId)
          ..add('displayName', displayName)
          ..add('profilePictureUrl', profilePictureUrl))
        .toString();
  }
}

class UpdateApplicationUserCommandBuilder
    implements
        Builder<UpdateApplicationUserCommand,
            UpdateApplicationUserCommandBuilder> {
  _$UpdateApplicationUserCommand? _$v;

  String? _applicationUserId;
  String? get applicationUserId => _$this._applicationUserId;
  set applicationUserId(String? applicationUserId) =>
      _$this._applicationUserId = applicationUserId;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _profilePictureUrl;
  String? get profilePictureUrl => _$this._profilePictureUrl;
  set profilePictureUrl(String? profilePictureUrl) =>
      _$this._profilePictureUrl = profilePictureUrl;

  UpdateApplicationUserCommandBuilder() {
    UpdateApplicationUserCommand._defaults(this);
  }

  UpdateApplicationUserCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _applicationUserId = $v.applicationUserId;
      _displayName = $v.displayName;
      _profilePictureUrl = $v.profilePictureUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateApplicationUserCommand other) {
    _$v = other as _$UpdateApplicationUserCommand;
  }

  @override
  void update(void Function(UpdateApplicationUserCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateApplicationUserCommand build() => _build();

  _$UpdateApplicationUserCommand _build() {
    final _$result = _$v ??
        _$UpdateApplicationUserCommand._(
          applicationUserId: applicationUserId,
          displayName: displayName,
          profilePictureUrl: profilePictureUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
