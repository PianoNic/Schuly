// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_oda_org_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConnectOdaOrgRequest extends ConnectOdaOrgRequest {
  @override
  final String? username;
  @override
  final String? password;
  @override
  final String? baseUrl;
  @override
  final String? displayName;

  factory _$ConnectOdaOrgRequest([
    void Function(ConnectOdaOrgRequestBuilder)? updates,
  ]) => (ConnectOdaOrgRequestBuilder()..update(updates))._build();

  _$ConnectOdaOrgRequest._({
    this.username,
    this.password,
    this.baseUrl,
    this.displayName,
  }) : super._();
  @override
  ConnectOdaOrgRequest rebuild(
    void Function(ConnectOdaOrgRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ConnectOdaOrgRequestBuilder toBuilder() =>
      ConnectOdaOrgRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConnectOdaOrgRequest &&
        username == other.username &&
        password == other.password &&
        baseUrl == other.baseUrl &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, baseUrl.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConnectOdaOrgRequest')
          ..add('username', username)
          ..add('password', password)
          ..add('baseUrl', baseUrl)
          ..add('displayName', displayName))
        .toString();
  }
}

class ConnectOdaOrgRequestBuilder
    implements Builder<ConnectOdaOrgRequest, ConnectOdaOrgRequestBuilder> {
  _$ConnectOdaOrgRequest? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _baseUrl;
  String? get baseUrl => _$this._baseUrl;
  set baseUrl(String? baseUrl) => _$this._baseUrl = baseUrl;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  ConnectOdaOrgRequestBuilder() {
    ConnectOdaOrgRequest._defaults(this);
  }

  ConnectOdaOrgRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _password = $v.password;
      _baseUrl = $v.baseUrl;
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConnectOdaOrgRequest other) {
    _$v = other as _$ConnectOdaOrgRequest;
  }

  @override
  void update(void Function(ConnectOdaOrgRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConnectOdaOrgRequest build() => _build();

  _$ConnectOdaOrgRequest _build() {
    final _$result =
        _$v ??
        _$ConnectOdaOrgRequest._(
          username: username,
          password: password,
          baseUrl: baseUrl,
          displayName: displayName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
