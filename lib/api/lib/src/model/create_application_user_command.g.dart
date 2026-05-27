// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_application_user_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateApplicationUserCommand extends CreateApplicationUserCommand {
  @override
  final String? externalId;
  @override
  final String? email;
  @override
  final String? displayName;

  factory _$CreateApplicationUserCommand([
    void Function(CreateApplicationUserCommandBuilder)? updates,
  ]) => (CreateApplicationUserCommandBuilder()..update(updates))._build();

  _$CreateApplicationUserCommand._({
    this.externalId,
    this.email,
    this.displayName,
  }) : super._();
  @override
  CreateApplicationUserCommand rebuild(
    void Function(CreateApplicationUserCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateApplicationUserCommandBuilder toBuilder() =>
      CreateApplicationUserCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateApplicationUserCommand &&
        externalId == other.externalId &&
        email == other.email &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, externalId.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateApplicationUserCommand')
          ..add('externalId', externalId)
          ..add('email', email)
          ..add('displayName', displayName))
        .toString();
  }
}

class CreateApplicationUserCommandBuilder
    implements
        Builder<
          CreateApplicationUserCommand,
          CreateApplicationUserCommandBuilder
        > {
  _$CreateApplicationUserCommand? _$v;

  String? _externalId;
  String? get externalId => _$this._externalId;
  set externalId(String? externalId) => _$this._externalId = externalId;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  CreateApplicationUserCommandBuilder() {
    CreateApplicationUserCommand._defaults(this);
  }

  CreateApplicationUserCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _externalId = $v.externalId;
      _email = $v.email;
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateApplicationUserCommand other) {
    _$v = other as _$CreateApplicationUserCommand;
  }

  @override
  void update(void Function(CreateApplicationUserCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateApplicationUserCommand build() => _build();

  _$CreateApplicationUserCommand _build() {
    final _$result =
        _$v ??
        _$CreateApplicationUserCommand._(
          externalId: externalId,
          email: email,
          displayName: displayName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
