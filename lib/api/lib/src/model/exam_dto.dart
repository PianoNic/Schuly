//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/exam_type.dart';
import 'package:schuly_api/src/model/grade_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'exam_dto.g.dart';

/// ExamDto
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [description] 
/// * [type] 
/// * [classAverage] 
/// * [classId] 
/// * [schoolId] 
/// * [grades] 
@BuiltValue()
abstract class ExamDto implements Built<ExamDto, ExamDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'type')
  ExamType? get type;
  // enum typeEnum {  Classic,  FinalExam,  };

  @BuiltValueField(wireName: r'classAverage')
  double get classAverage;

  @BuiltValueField(wireName: r'classId')
  String? get classId;

  @BuiltValueField(wireName: r'schoolId')
  String? get schoolId;

  @BuiltValueField(wireName: r'grades')
  BuiltList<GradeDto>? get grades;

  ExamDto._();

  factory ExamDto([void updates(ExamDtoBuilder b)]) = _$ExamDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExamDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExamDto> get serializer => _$ExamDtoSerializer();
}

class _$ExamDtoSerializer implements PrimitiveSerializer<ExamDto> {
  @override
  final Iterable<Type> types = const [ExamDto, _$ExamDto];

  @override
  final String wireName = r'ExamDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExamDto object, {
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
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(ExamType),
      );
    }
    yield r'classAverage';
    yield serializers.serialize(
      object.classAverage,
      specifiedType: const FullType(double),
    );
    if (object.classId != null) {
      yield r'classId';
      yield serializers.serialize(
        object.classId,
        specifiedType: const FullType(String),
      );
    }
    if (object.schoolId != null) {
      yield r'schoolId';
      yield serializers.serialize(
        object.schoolId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.grades != null) {
      yield r'grades';
      yield serializers.serialize(
        object.grades,
        specifiedType: const FullType.nullable(BuiltList, [FullType(GradeDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ExamDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExamDtoBuilder result,
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
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ExamType),
          ) as ExamType;
          result.type = valueDes;
          break;
        case r'classAverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.classAverage = valueDes;
          break;
        case r'classId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
        case r'grades':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(GradeDto)]),
          ) as BuiltList<GradeDto>?;
          if (valueDes == null) continue;
          result.grades.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExamDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExamDtoBuilder();
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

