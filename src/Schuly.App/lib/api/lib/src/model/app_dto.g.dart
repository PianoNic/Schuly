// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppDto extends AppDto {
  @override
  final String? authority;
  @override
  final String? clientId;
  @override
  final String? redirectUri;
  @override
  final String? postLogoutRedirectUri;
  @override
  final String? scope;
  @override
  final String? version;

  factory _$AppDto([void Function(AppDtoBuilder)? updates]) =>
      (AppDtoBuilder()..update(updates))._build();

  _$AppDto._(
      {this.authority,
      this.clientId,
      this.redirectUri,
      this.postLogoutRedirectUri,
      this.scope,
      this.version})
      : super._();
  @override
  AppDto rebuild(void Function(AppDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppDtoBuilder toBuilder() => AppDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppDto &&
        authority == other.authority &&
        clientId == other.clientId &&
        redirectUri == other.redirectUri &&
        postLogoutRedirectUri == other.postLogoutRedirectUri &&
        scope == other.scope &&
        version == other.version;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, authority.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, redirectUri.hashCode);
    _$hash = $jc(_$hash, postLogoutRedirectUri.hashCode);
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppDto')
          ..add('authority', authority)
          ..add('clientId', clientId)
          ..add('redirectUri', redirectUri)
          ..add('postLogoutRedirectUri', postLogoutRedirectUri)
          ..add('scope', scope)
          ..add('version', version))
        .toString();
  }
}

class AppDtoBuilder implements Builder<AppDto, AppDtoBuilder> {
  _$AppDto? _$v;

  String? _authority;
  String? get authority => _$this._authority;
  set authority(String? authority) => _$this._authority = authority;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  String? _redirectUri;
  String? get redirectUri => _$this._redirectUri;
  set redirectUri(String? redirectUri) => _$this._redirectUri = redirectUri;

  String? _postLogoutRedirectUri;
  String? get postLogoutRedirectUri => _$this._postLogoutRedirectUri;
  set postLogoutRedirectUri(String? postLogoutRedirectUri) =>
      _$this._postLogoutRedirectUri = postLogoutRedirectUri;

  String? _scope;
  String? get scope => _$this._scope;
  set scope(String? scope) => _$this._scope = scope;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  AppDtoBuilder() {
    AppDto._defaults(this);
  }

  AppDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _authority = $v.authority;
      _clientId = $v.clientId;
      _redirectUri = $v.redirectUri;
      _postLogoutRedirectUri = $v.postLogoutRedirectUri;
      _scope = $v.scope;
      _version = $v.version;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppDto other) {
    _$v = other as _$AppDto;
  }

  @override
  void update(void Function(AppDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppDto build() => _build();

  _$AppDto _build() {
    final _$result = _$v ??
        _$AppDto._(
          authority: authority,
          clientId: clientId,
          redirectUri: redirectUri,
          postLogoutRedirectUri: postLogoutRedirectUri,
          scope: scope,
          version: version,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
