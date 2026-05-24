//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'roles.g.dart';

class Roles extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Student')
  static const Roles student = _$student;
  @BuiltValueEnumConst(wireName: r'Teacher')
  static const Roles teacher = _$teacher;
  @BuiltValueEnumConst(wireName: r'Administrator')
  static const Roles administrator = _$administrator;

  static Serializer<Roles> get serializer => _$rolesSerializer;

  const Roles._(String name): super(name);

  static BuiltSet<Roles> get values => _$values;
  static Roles valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class RolesMixin = Object with _$RolesMixin;

