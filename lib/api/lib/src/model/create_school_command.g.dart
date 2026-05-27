// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_school_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateSchoolCommand extends CreateSchoolCommand {
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

  factory _$CreateSchoolCommand([
    void Function(CreateSchoolCommandBuilder)? updates,
  ]) => (CreateSchoolCommandBuilder()..update(updates))._build();

  _$CreateSchoolCommand._({
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
  }) : super._();
  @override
  CreateSchoolCommand rebuild(
    void Function(CreateSchoolCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateSchoolCommandBuilder toBuilder() =>
      CreateSchoolCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateSchoolCommand &&
        name == other.name &&
        description == other.description &&
        email == other.email &&
        phoneNumber == other.phoneNumber &&
        website == other.website &&
        street == other.street &&
        city == other.city &&
        state == other.state &&
        zip == other.zip &&
        country == other.country;
  }

  @override
  int get hashCode {
    var _$hash = 0;
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
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateSchoolCommand')
          ..add('name', name)
          ..add('description', description)
          ..add('email', email)
          ..add('phoneNumber', phoneNumber)
          ..add('website', website)
          ..add('street', street)
          ..add('city', city)
          ..add('state', state)
          ..add('zip', zip)
          ..add('country', country))
        .toString();
  }
}

class CreateSchoolCommandBuilder
    implements Builder<CreateSchoolCommand, CreateSchoolCommandBuilder> {
  _$CreateSchoolCommand? _$v;

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

  CreateSchoolCommandBuilder() {
    CreateSchoolCommand._defaults(this);
  }

  CreateSchoolCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateSchoolCommand other) {
    _$v = other as _$CreateSchoolCommand;
  }

  @override
  void update(void Function(CreateSchoolCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateSchoolCommand build() => _build();

  _$CreateSchoolCommand _build() {
    final _$result =
        _$v ??
        _$CreateSchoolCommand._(
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
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
