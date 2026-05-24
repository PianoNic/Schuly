//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/exam_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/agenda_entry_dto.dart';
import 'package:schuly_api/src/model/school_user_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'class_dto.g.dart';

/// ClassDto
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [description] 
/// * [schoolId] 
/// * [schoolName] 
/// * [students] 
/// * [agenda] 
/// * [exams] 
@BuiltValue()
abstract class ClassDto implements Built<ClassDto, ClassDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'schoolId')
  String? get schoolId;

  @BuiltValueField(wireName: r'schoolName')
  String? get schoolName;

  @BuiltValueField(wireName: r'students')
  BuiltList<SchoolUserDto>? get students;

  @BuiltValueField(wireName: r'agenda')
  BuiltList<AgendaEntryDto>? get agenda;

  @BuiltValueField(wireName: r'exams')
  BuiltList<ExamDto>? get exams;

  ClassDto._();

  factory ClassDto([void updates(ClassDtoBuilder b)]) = _$ClassDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ClassDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ClassDto> get serializer => _$ClassDtoSerializer();
}

class _$ClassDtoSerializer implements PrimitiveSerializer<ClassDto> {
  @override
  final Iterable<Type> types = const [ClassDto, _$ClassDto];

  @override
  final String wireName = r'ClassDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ClassDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    yield r'name';
    yield object.name == null ? null : serializers.serialize(
      object.name,
      specifiedType: const FullType.nullable(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.schoolId != null) {
      yield r'schoolId';
      yield serializers.serialize(
        object.schoolId,
        specifiedType: const FullType(String),
      );
    }
    if (object.schoolName != null) {
      yield r'schoolName';
      yield serializers.serialize(
        object.schoolName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.students != null) {
      yield r'students';
      yield serializers.serialize(
        object.students,
        specifiedType: const FullType.nullable(BuiltList, [FullType(SchoolUserDto)]),
      );
    }
    if (object.agenda != null) {
      yield r'agenda';
      yield serializers.serialize(
        object.agenda,
        specifiedType: const FullType.nullable(BuiltList, [FullType(AgendaEntryDto)]),
      );
    }
    if (object.exams != null) {
      yield r'exams';
      yield serializers.serialize(
        object.exams,
        specifiedType: const FullType.nullable(BuiltList, [FullType(ExamDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ClassDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ClassDtoBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'schoolId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.schoolId = valueDes;
          break;
        case r'schoolName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.schoolName = valueDes;
          break;
        case r'students':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SchoolUserDto)]),
          ) as BuiltList<SchoolUserDto>?;
          if (valueDes == null) continue;
          result.students.replace(valueDes);
          break;
        case r'agenda':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(AgendaEntryDto)]),
          ) as BuiltList<AgendaEntryDto>?;
          if (valueDes == null) continue;
          result.agenda.replace(valueDes);
          break;
        case r'exams':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(ExamDto)]),
          ) as BuiltList<ExamDto>?;
          if (valueDes == null) continue;
          result.exams.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ClassDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ClassDtoBuilder();
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

