// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_school_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateSchoolCommand extends UpdateSchoolCommand {
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

  factory _$UpdateSchoolCommand(
          [void Function(UpdateSchoolCommandBuilder)? updates]) =>
      (UpdateSchoolCommandBuilder()..update(updates))._build();

  _$UpdateSchoolCommand._(
      {this.id,
      this.name,
      this.description,
      this.email,
      this.phoneNumber,
      this.website,
      this.street,
      this.city,
      this.state,
      this.zip,
      this.country})
      : super._();
  @override
  UpdateSchoolCommand rebuild(
          void Function(UpdateSchoolCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateSchoolCommandBuilder toBuilder() =>
      UpdateSchoolCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateSchoolCommand &&
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
        country == other.country;
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
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateSchoolCommand')
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
          ..add('country', country))
        .toString();
  }
}

class UpdateSchoolCommandBuilder
    implements Builder<UpdateSchoolCommand, UpdateSchoolCommandBuilder> {
  _$UpdateSchoolCommand? _$v;

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

  UpdateSchoolCommandBuilder() {
    UpdateSchoolCommand._defaults(this);
  }

  UpdateSchoolCommandBuilder get _$this {
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
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateSchoolCommand other) {
    _$v = other as _$UpdateSchoolCommand;
  }

  @override
  void update(void Function(UpdateSchoolCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateSchoolCommand build() => _build();

  _$UpdateSchoolCommand _build() {
    final _$result = _$v ??
        _$UpdateSchoolCommand._(
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
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
