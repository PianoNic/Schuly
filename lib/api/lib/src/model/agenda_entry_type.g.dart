// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda_entry_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AgendaEntryType _$event = const AgendaEntryType._('event');
const AgendaEntryType _$lesson = const AgendaEntryType._('lesson');
const AgendaEntryType _$test = const AgendaEntryType._('test');
const AgendaEntryType _$holiday = const AgendaEntryType._('holiday');

AgendaEntryType _$valueOf(String name) {
  switch (name) {
    case 'event':
      return _$event;
    case 'lesson':
      return _$lesson;
    case 'test':
      return _$test;
    case 'holiday':
      return _$holiday;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AgendaEntryType> _$values = BuiltSet<AgendaEntryType>(
  const <AgendaEntryType>[_$event, _$lesson, _$test, _$holiday],
);

class _$AgendaEntryTypeMeta {
  const _$AgendaEntryTypeMeta();
  AgendaEntryType get event => _$event;
  AgendaEntryType get lesson => _$lesson;
  AgendaEntryType get test => _$test;
  AgendaEntryType get holiday => _$holiday;
  AgendaEntryType valueOf(String name) => _$valueOf(name);
  BuiltSet<AgendaEntryType> get values => _$values;
}

mixin _$AgendaEntryTypeMixin {
  // ignore: non_constant_identifier_names
  _$AgendaEntryTypeMeta get AgendaEntryType => const _$AgendaEntryTypeMeta();
}

Serializer<AgendaEntryType> _$agendaEntryTypeSerializer =
    _$AgendaEntryTypeSerializer();

class _$AgendaEntryTypeSerializer
    implements PrimitiveSerializer<AgendaEntryType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'event': 'Event',
    'lesson': 'Lesson',
    'test': 'Test',
    'holiday': 'Holiday',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Event': 'event',
    'Lesson': 'lesson',
    'Test': 'test',
    'Holiday': 'holiday',
  };

  @override
  final Iterable<Type> types = const <Type>[AgendaEntryType];
  @override
  final String wireName = 'AgendaEntryType';

  @override
  Object serialize(
    Serializers serializers,
    AgendaEntryType object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AgendaEntryType deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AgendaEntryType.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
