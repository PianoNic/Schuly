//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'semester_subject_grade_dto.g.dart';

/// SemesterSubjectGradeDto
///
/// Properties:
/// * [id] 
/// * [semesterReportId] 
/// * [subjectCode] 
/// * [subjectName] 
/// * [subjectTypeMarker] 
/// * [grade] 
/// * [marker] 
@BuiltValue()
abstract class SemesterSubjectGradeDto implements Built<SemesterSubjectGradeDto, SemesterSubjectGradeDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'semesterReportId')
  String? get semesterReportId;

  @BuiltValueField(wireName: r'subjectCode')
  String? get subjectCode;

  @BuiltValueField(wireName: r'subjectName')
  String? get subjectName;

  @BuiltValueField(wireName: r'subjectTypeMarker')
  String? get subjectTypeMarker;

  @BuiltValueField(wireName: r'grade')
  double? get grade;

  @BuiltValueField(wireName: r'marker')
  String? get marker;

  SemesterSubjectGradeDto._();

  factory SemesterSubjectGradeDto([void updates(SemesterSubjectGradeDtoBuilder b)]) = _$SemesterSubjectGradeDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SemesterSubjectGradeDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SemesterSubjectGradeDto> get serializer => _$SemesterSubjectGradeDtoSerializer();
}

class _$SemesterSubjectGradeDtoSerializer implements PrimitiveSerializer<SemesterSubjectGradeDto> {
  @override
  final Iterable<Type> types = const [SemesterSubjectGradeDto, _$SemesterSubjectGradeDto];

  @override
  final String wireName = r'SemesterSubjectGradeDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SemesterSubjectGradeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.semesterReportId != null) {
      yield r'semesterReportId';
      yield serializers.serialize(
        object.semesterReportId,
        specifiedType: const FullType(String),
      );
    }
    yield r'subjectCode';
    yield object.subjectCode == null ? null : serializers.serialize(
      object.subjectCode,
      specifiedType: const FullType.nullable(String),
    );
    yield r'subjectName';
    yield object.subjectName == null ? null : serializers.serialize(
      object.subjectName,
      specifiedType: const FullType.nullable(String),
    );
    if (object.subjectTypeMarker != null) {
      yield r'subjectTypeMarker';
      yield serializers.serialize(
        object.subjectTypeMarker,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.grade != null) {
      yield r'grade';
      yield serializers.serialize(
        object.grade,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.marker != null) {
      yield r'marker';
      yield serializers.serialize(
        object.marker,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SemesterSubjectGradeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SemesterSubjectGradeDtoBuilder result,
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
        case r'semesterReportId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.semesterReportId = valueDes;
          break;
        case r'subjectCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.subjectCode = valueDes;
          break;
        case r'subjectName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.subjectName = valueDes;
          break;
        case r'subjectTypeMarker':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.subjectTypeMarker = valueDes;
          break;
        case r'grade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.grade = valueDes;
          break;
        case r'marker':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.marker = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SemesterSubjectGradeDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SemesterSubjectGradeDtoBuilder();
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

