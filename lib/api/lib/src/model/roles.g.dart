// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roles.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Roles _$student = const Roles._('student');
const Roles _$teacher = const Roles._('teacher');
const Roles _$administrator = const Roles._('administrator');

Roles _$valueOf(String name) {
  switch (name) {
    case 'student':
      return _$student;
    case 'teacher':
      return _$teacher;
    case 'administrator':
      return _$administrator;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Roles> _$values = BuiltSet<Roles>(const <Roles>[
  _$student,
  _$teacher,
  _$administrator,
]);

class _$RolesMeta {
  const _$RolesMeta();
  Roles get student => _$student;
  Roles get teacher => _$teacher;
  Roles get administrator => _$administrator;
  Roles valueOf(String name) => _$valueOf(name);
  BuiltSet<Roles> get values => _$values;
}

mixin _$RolesMixin {
  // ignore: non_constant_identifier_names
  _$RolesMeta get Roles => const _$RolesMeta();
}

Serializer<Roles> _$rolesSerializer = _$RolesSerializer();

class _$RolesSerializer implements PrimitiveSerializer<Roles> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'student': 'Student',
    'teacher': 'Teacher',
    'administrator': 'Administrator',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Student': 'student',
    'Teacher': 'teacher',
    'Administrator': 'administrator',
  };

  @override
  final Iterable<Type> types = const <Type>[Roles];
  @override
  final String wireName = 'Roles';

  @override
  Object serialize(
    Serializers serializers,
    Roles object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  Roles deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => Roles.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
