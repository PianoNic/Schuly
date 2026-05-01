//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'agenda_entry_type.g.dart';

class AgendaEntryType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Event')
  static const AgendaEntryType event = _$event;
  @BuiltValueEnumConst(wireName: r'Lesson')
  static const AgendaEntryType lesson = _$lesson;
  @BuiltValueEnumConst(wireName: r'Test')
  static const AgendaEntryType test = _$test;

  static Serializer<AgendaEntryType> get serializer => _$agendaEntryTypeSerializer;

  const AgendaEntryType._(String name): super(name);

  static BuiltSet<AgendaEntryType> get values => _$values;
  static AgendaEntryType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class AgendaEntryTypeMixin = Object with _$AgendaEntryTypeMixin;

