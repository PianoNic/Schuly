// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_account_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConnectAccountRequest extends ConnectAccountRequest {
  @override
  final String? schulnetzBaseUrl;
  @override
  final String? schulwareApiBaseUrl;
  @override
  final String? displayName;
  @override
  final String? schoolUserId;

  factory _$ConnectAccountRequest([
    void Function(ConnectAccountRequestBuilder)? updates,
  ]) => (ConnectAccountRequestBuilder()..update(updates))._build();

  _$ConnectAccountRequest._({
    this.schulnetzBaseUrl,
    this.schulwareApiBaseUrl,
    this.displayName,
    this.schoolUserId,
  }) : super._();
  @override
  ConnectAccountRequest rebuild(
    void Function(ConnectAccountRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ConnectAccountRequestBuilder toBuilder() =>
      ConnectAccountRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConnectAccountRequest &&
        schulnetzBaseUrl == other.schulnetzBaseUrl &&
        schulwareApiBaseUrl == other.schulwareApiBaseUrl &&
        displayName == other.displayName &&
        schoolUserId == other.schoolUserId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, schulnetzBaseUrl.hashCode);
    _$hash = $jc(_$hash, schulwareApiBaseUrl.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, schoolUserId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConnectAccountRequest')
          ..add('schulnetzBaseUrl', schulnetzBaseUrl)
          ..add('schulwareApiBaseUrl', schulwareApiBaseUrl)
          ..add('displayName', displayName)
          ..add('schoolUserId', schoolUserId))
        .toString();
  }
}

class ConnectAccountRequestBuilder
    implements Builder<ConnectAccountRequest, ConnectAccountRequestBuilder> {
  _$ConnectAccountRequest? _$v;

  String? _schulnetzBaseUrl;
  String? get schulnetzBaseUrl => _$this._schulnetzBaseUrl;
  set schulnetzBaseUrl(String? schulnetzBaseUrl) =>
      _$this._schulnetzBaseUrl = schulnetzBaseUrl;

  String? _schulwareApiBaseUrl;
  String? get schulwareApiBaseUrl => _$this._schulwareApiBaseUrl;
  set schulwareApiBaseUrl(String? schulwareApiBaseUrl) =>
      _$this._schulwareApiBaseUrl = schulwareApiBaseUrl;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _schoolUserId;
  String? get schoolUserId => _$this._schoolUserId;
  set schoolUserId(String? schoolUserId) => _$this._schoolUserId = schoolUserId;

  ConnectAccountRequestBuilder() {
    ConnectAccountRequest._defaults(this);
  }

  ConnectAccountRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _schulnetzBaseUrl = $v.schulnetzBaseUrl;
      _schulwareApiBaseUrl = $v.schulwareApiBaseUrl;
      _displayName = $v.displayName;
      _schoolUserId = $v.schoolUserId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConnectAccountRequest other) {
    _$v = other as _$ConnectAccountRequest;
  }

  @override
  void update(void Function(ConnectAccountRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConnectAccountRequest build() => _build();

  _$ConnectAccountRequest _build() {
    final _$result =
        _$v ??
        _$ConnectAccountRequest._(
          schulnetzBaseUrl: schulnetzBaseUrl,
          schulwareApiBaseUrl: schulwareApiBaseUrl,
          displayName: displayName,
          schoolUserId: schoolUserId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
