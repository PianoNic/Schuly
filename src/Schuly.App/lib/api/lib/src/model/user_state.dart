//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_state.g.dart';

class UserState extends EnumClass {

  @BuiltValueEnumConst(wireName: r'None')
  static const UserState none = _$none;
  @BuiltValueEnumConst(wireName: r'Active')
  static const UserState active = _$active;
  @BuiltValueEnumConst(wireName: r'Inactive')
  static const UserState inactive = _$inactive;

  static Serializer<UserState> get serializer => _$userStateSerializer;

  const UserState._(String name): super(name);

  static BuiltSet<UserState> get values => _$values;
  static UserState valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class UserStateMixin = Object with _$UserStateMixin;

