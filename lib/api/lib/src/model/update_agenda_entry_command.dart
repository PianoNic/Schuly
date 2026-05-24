//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/agenda_entry_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_agenda_entry_command.g.dart';

/// UpdateAgendaEntryCommand
///
/// Properties:
/// * [agendaEntryId] 
/// * [entryType] 
/// * [title] 
/// * [description] 
/// * [place] 
/// * [date] 
/// * [classId] 
@BuiltValue()
abstract class UpdateAgendaEntryCommand implements Built<UpdateAgendaEntryCommand, UpdateAgendaEntryCommandBuilder> {
  @BuiltValueField(wireName: r'agendaEntryId')
  String? get agendaEntryId;

  @BuiltValueField(wireName: r'entryType')
  AgendaEntryType? get entryType;
  // enum entryTypeEnum {  Event,  Lesson,  Test,  };

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'place')
  String? get place;

  @BuiltValueField(wireName: r'date')
  DateTime? get date;

  @BuiltValueField(wireName: r'classId')
  String? get classId;

  UpdateAgendaEntryCommand._();

  factory UpdateAgendaEntryCommand([void updates(UpdateAgendaEntryCommandBuilder b)]) = _$UpdateAgendaEntryCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateAgendaEntryCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateAgendaEntryCommand> get serializer => _$UpdateAgendaEntryCommandSerializer();
}

class _$UpdateAgendaEntryCommandSerializer implements PrimitiveSerializer<UpdateAgendaEntryCommand> {
  @override
  final Iterable<Type> types = const [UpdateAgendaEntryCommand, _$UpdateAgendaEntryCommand];

  @override
  final String wireName = r'UpdateAgendaEntryCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateAgendaEntryCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.agendaEntryId != null) {
      yield r'agendaEntryId';
      yield serializers.serialize(
        object.agendaEntryId,
        specifiedType: const FullType(String),
      );
    }
    if (object.entryType != null) {
      yield r'entryType';
      yield serializers.serialize(
        object.entryType,
        specifiedType: const FullType(AgendaEntryType),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.place != null) {
      yield r'place';
      yield serializers.serialize(
        object.place,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.date != null) {
      yield r'date';
      yield serializers.serialize(
        object.date,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.classId != null) {
      yield r'classId';
      yield serializers.serialize(
        object.classId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateAgendaEntryCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateAgendaEntryCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'agendaEntryId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.agendaEntryId = valueDes;
          break;
        case r'entryType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AgendaEntryType),
          ) as AgendaEntryType;
          result.entryType = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'place':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.place = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.date = valueDes;
          break;
        case r'classId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.classId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateAgendaEntryCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateAgendaEntryCommandBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

