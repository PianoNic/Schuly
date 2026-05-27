// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AbsenceType _$absence = const AbsenceType._('absence');
const AbsenceType _$delay = const AbsenceType._('delay');

AbsenceType _$valueOf(String name) {
  switch (name) {
    case 'absence':
      return _$absence;
    case 'delay':
      return _$delay;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AbsenceType> _$values = BuiltSet<AbsenceType>(
  const <AbsenceType>[_$absence, _$delay],
);

class _$AbsenceTypeMeta {
  const _$AbsenceTypeMeta();
  AbsenceType get absence => _$absence;
  AbsenceType get delay => _$delay;
  AbsenceType valueOf(String name) => _$valueOf(name);
  BuiltSet<AbsenceType> get values => _$values;
}

mixin _$AbsenceTypeMixin {
  // ignore: non_constant_identifier_names
  _$AbsenceTypeMeta get AbsenceType => const _$AbsenceTypeMeta();
}

Serializer<AbsenceType> _$absenceTypeSerializer = _$AbsenceTypeSerializer();

class _$AbsenceTypeSerializer implements PrimitiveSerializer<AbsenceType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'absence': 'Absence',
    'delay': 'Delay',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Absence': 'absence',
    'Delay': 'delay',
  };

  @override
  final Iterable<Type> types = const <Type>[AbsenceType];
  @override
  final String wireName = 'AbsenceType';

  @override
  Object serialize(
    Serializers serializers,
    AbsenceType object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AbsenceType deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AbsenceType.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
