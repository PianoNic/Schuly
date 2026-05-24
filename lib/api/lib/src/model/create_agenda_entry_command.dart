//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/agenda_entry_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_agenda_entry_command.g.dart';

/// CreateAgendaEntryCommand
///
/// Properties:
/// * [entryType] 
/// * [title] 
/// * [description] 
/// * [place] 
/// * [date] 
/// * [classId] 
@BuiltValue()
abstract class CreateAgendaEntryCommand implements Built<CreateAgendaEntryCommand, CreateAgendaEntryCommandBuilder> {
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

  CreateAgendaEntryCommand._();

  factory CreateAgendaEntryCommand([void updates(CreateAgendaEntryCommandBuilder b)]) = _$CreateAgendaEntryCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateAgendaEntryCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateAgendaEntryCommand> get serializer => _$CreateAgendaEntryCommandSerializer();
}

class _$CreateAgendaEntryCommandSerializer implements PrimitiveSerializer<CreateAgendaEntryCommand> {
  @override
  final Iterable<Type> types = const [CreateAgendaEntryCommand, _$CreateAgendaEntryCommand];

  @override
  final String wireName = r'CreateAgendaEntryCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateAgendaEntryCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    CreateAgendaEntryCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateAgendaEntryCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  CreateAgendaEntryCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateAgendaEntryCommandBuilder();
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

