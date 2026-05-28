//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/agenda_entry_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'agenda_entry_dto.g.dart';

/// AgendaEntryDto
///
/// Properties:
/// * [id] 
/// * [entryType] 
/// * [title] 
/// * [description] 
/// * [place] 
/// * [date] 
/// * [classId] 
/// * [schoolId] 
/// * [schoolUserId] 
@BuiltValue()
abstract class AgendaEntryDto implements Built<AgendaEntryDto, AgendaEntryDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'entryType')
  AgendaEntryType get entryType;
  // enum entryTypeEnum {  Event,  Lesson,  Test,  Holiday,  };

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'place')
  String? get place;

  @BuiltValueField(wireName: r'date')
  DateTime get date;

  @BuiltValueField(wireName: r'classId')
  String? get classId;

  @BuiltValueField(wireName: r'schoolId')
  String? get schoolId;

  @BuiltValueField(wireName: r'schoolUserId')
  String? get schoolUserId;

  AgendaEntryDto._();

  factory AgendaEntryDto([void updates(AgendaEntryDtoBuilder b)]) = _$AgendaEntryDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AgendaEntryDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AgendaEntryDto> get serializer => _$AgendaEntryDtoSerializer();
}

class _$AgendaEntryDtoSerializer implements PrimitiveSerializer<AgendaEntryDto> {
  @override
  final Iterable<Type> types = const [AgendaEntryDto, _$AgendaEntryDto];

  @override
  final String wireName = r'AgendaEntryDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AgendaEntryDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    yield r'entryType';
    yield serializers.serialize(
      object.entryType,
      specifiedType: const FullType(AgendaEntryType),
    );
    yield r'title';
    yield object.title == null ? null : serializers.serialize(
      object.title,
      specifiedType: const FullType.nullable(String),
    );
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
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(DateTime),
    );
    if (object.classId != null) {
      yield r'classId';
      yield serializers.serialize(
        object.classId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.schoolId != null) {
      yield r'schoolId';
      yield serializers.serialize(
        object.schoolId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.schoolUserId != null) {
      yield r'schoolUserId';
      yield serializers.serialize(
        object.schoolUserId,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AgendaEntryDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AgendaEntryDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
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
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.classId = valueDes;
          break;
        case r'schoolId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.schoolId = valueDes;
          break;
        case r'schoolUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.schoolUserId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AgendaEntryDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AgendaEntryDtoBuilder();
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

