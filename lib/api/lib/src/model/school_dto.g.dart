// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SchoolDto extends SchoolDto {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? email;
  @override
  final String? phoneNumber;
  @override
  final String? website;
  @override
  final String? street;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? zip;
  @override
  final String? country;
  @override
  final String? logoUrl;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  factory _$SchoolDto([void Function(SchoolDtoBuilder)? updates]) =>
      (SchoolDtoBuilder()..update(updates))._build();

  _$SchoolDto._({
    this.id,
    this.name,
    this.description,
    this.email,
    this.phoneNumber,
    this.website,
    this.street,
    this.city,
    this.state,
    this.zip,
    this.country,
    this.logoUrl,
    this.createdAt,
    this.updatedAt,
  }) : super._();
  @override
  SchoolDto rebuild(void Function(SchoolDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SchoolDtoBuilder toBuilder() => SchoolDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SchoolDto &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        email == other.email &&
        phoneNumber == other.phoneNumber &&
        website == other.website &&
        street == other.street &&
        city == other.city &&
        state == other.state &&
        zip == other.zip &&
        country == other.country &&
        logoUrl == other.logoUrl &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, website.hashCode);
    _$hash = $jc(_$hash, street.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, zip.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, logoUrl.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SchoolDto')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('email', email)
          ..add('phoneNumber', phoneNumber)
          ..add('website', website)
          ..add('street', street)
          ..add('city', city)
          ..add('state', state)
          ..add('zip', zip)
          ..add('country', country)
          ..add('logoUrl', logoUrl)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class SchoolDtoBuilder implements Builder<SchoolDto, SchoolDtoBuilder> {
  _$SchoolDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _website;
  String? get website => _$this._website;
  set website(String? website) => _$this._website = website;

  String? _street;
  String? get street => _$this._street;
  set street(String? street) => _$this._street = street;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  String? _zip;
  String? get zip => _$this._zip;
  set zip(String? zip) => _$this._zip = zip;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  String? _logoUrl;
  String? get logoUrl => _$this._logoUrl;
  set logoUrl(String? logoUrl) => _$this._logoUrl = logoUrl;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  SchoolDtoBuilder() {
    SchoolDto._defaults(this);
  }

  SchoolDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _email = $v.email;
      _phoneNumber = $v.phoneNumber;
      _website = $v.website;
      _street = $v.street;
      _city = $v.city;
      _state = $v.state;
      _zip = $v.zip;
      _country = $v.country;
      _logoUrl = $v.logoUrl;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SchoolDto other) {
    _$v = other as _$SchoolDto;
  }

  @override
  void update(void Function(SchoolDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SchoolDto build() => _build();

  _$SchoolDto _build() {
    final _$result =
        _$v ??
        _$SchoolDto._(
          id: id,
          name: name,
          description: description,
          email: email,
          phoneNumber: phoneNumber,
          website: website,
          street: street,
          city: city,
          state: state,
          zip: zip,
          country: country,
          logoUrl: logoUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
