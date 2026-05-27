// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserState _$none = const UserState._('none');
const UserState _$active = const UserState._('active');
const UserState _$inactive = const UserState._('inactive');

UserState _$valueOf(String name) {
  switch (name) {
    case 'none':
      return _$none;
    case 'active':
      return _$active;
    case 'inactive':
      return _$inactive;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserState> _$values = BuiltSet<UserState>(const <UserState>[
  _$none,
  _$active,
  _$inactive,
]);

class _$UserStateMeta {
  const _$UserStateMeta();
  UserState get none => _$none;
  UserState get active => _$active;
  UserState get inactive => _$inactive;
  UserState valueOf(String name) => _$valueOf(name);
  BuiltSet<UserState> get values => _$values;
}

mixin _$UserStateMixin {
  // ignore: non_constant_identifier_names
  _$UserStateMeta get UserState => const _$UserStateMeta();
}

Serializer<UserState> _$userStateSerializer = _$UserStateSerializer();

class _$UserStateSerializer implements PrimitiveSerializer<UserState> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'none': 'None',
    'active': 'Active',
    'inactive': 'Inactive',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'None': 'none',
    'Active': 'active',
    'Inactive': 'inactive',
  };

  @override
  final Iterable<Type> types = const <Type>[UserState];
  @override
  final String wireName = 'UserState';

  @override
  Object serialize(
    Serializers serializers,
    UserState object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UserState deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UserState.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
