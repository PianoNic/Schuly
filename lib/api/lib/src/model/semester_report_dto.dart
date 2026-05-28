//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/semester_subject_grade_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'semester_report_dto.g.dart';

/// SemesterReportDto
///
/// Properties:
/// * [id] 
/// * [schoolUserId] 
/// * [programCode] 
/// * [schoolYearStart] 
/// * [semesterHalf] 
/// * [className] 
/// * [promotionDecision] 
/// * [gradeAverage] 
/// * [insufficientGradeCount] 
/// * [deficiencyPoints] 
/// * [excusedAbsences] 
/// * [unexcusedAbsences] 
/// * [totalAbsences] 
/// * [subjects] 
@BuiltValue()
abstract class SemesterReportDto implements Built<SemesterReportDto, SemesterReportDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'schoolUserId')
  String? get schoolUserId;

  @BuiltValueField(wireName: r'programCode')
  String? get programCode;

  @BuiltValueField(wireName: r'schoolYearStart')
  int get schoolYearStart;

  @BuiltValueField(wireName: r'semesterHalf')
  int get semesterHalf;

  @BuiltValueField(wireName: r'className')
  String? get className;

  @BuiltValueField(wireName: r'promotionDecision')
  String? get promotionDecision;

  @BuiltValueField(wireName: r'gradeAverage')
  double? get gradeAverage;

  @BuiltValueField(wireName: r'insufficientGradeCount')
  int? get insufficientGradeCount;

  @BuiltValueField(wireName: r'deficiencyPoints')
  int? get deficiencyPoints;

  @BuiltValueField(wireName: r'excusedAbsences')
  int? get excusedAbsences;

  @BuiltValueField(wireName: r'unexcusedAbsences')
  int? get unexcusedAbsences;

  @BuiltValueField(wireName: r'totalAbsences')
  int? get totalAbsences;

  @BuiltValueField(wireName: r'subjects')
  BuiltList<SemesterSubjectGradeDto>? get subjects;

  SemesterReportDto._();

  factory SemesterReportDto([void updates(SemesterReportDtoBuilder b)]) = _$SemesterReportDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SemesterReportDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SemesterReportDto> get serializer => _$SemesterReportDtoSerializer();
}

class _$SemesterReportDtoSerializer implements PrimitiveSerializer<SemesterReportDto> {
  @override
  final Iterable<Type> types = const [SemesterReportDto, _$SemesterReportDto];

  @override
  final String wireName = r'SemesterReportDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SemesterReportDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.schoolUserId != null) {
      yield r'schoolUserId';
      yield serializers.serialize(
        object.schoolUserId,
        specifiedType: const FullType(String),
      );
    }
    yield r'programCode';
    yield object.programCode == null ? null : serializers.serialize(
      object.programCode,
      specifiedType: const FullType.nullable(String),
    );
    yield r'schoolYearStart';
    yield serializers.serialize(
      object.schoolYearStart,
      specifiedType: const FullType(int),
    );
    yield r'semesterHalf';
    yield serializers.serialize(
      object.semesterHalf,
      specifiedType: const FullType(int),
    );
    yield r'className';
    yield object.className == null ? null : serializers.serialize(
      object.className,
      specifiedType: const FullType.nullable(String),
    );
    if (object.promotionDecision != null) {
      yield r'promotionDecision';
      yield serializers.serialize(
        object.promotionDecision,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.gradeAverage != null) {
      yield r'gradeAverage';
      yield serializers.serialize(
        object.gradeAverage,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.insufficientGradeCount != null) {
      yield r'insufficientGradeCount';
      yield serializers.serialize(
        object.insufficientGradeCount,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.deficiencyPoints != null) {
      yield r'deficiencyPoints';
      yield serializers.serialize(
        object.deficiencyPoints,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.excusedAbsences != null) {
      yield r'excusedAbsences';
      yield serializers.serialize(
        object.excusedAbsences,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.unexcusedAbsences != null) {
      yield r'unexcusedAbsences';
      yield serializers.serialize(
        object.unexcusedAbsences,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.totalAbsences != null) {
      yield r'totalAbsences';
      yield serializers.serialize(
        object.totalAbsences,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.subjects != null) {
      yield r'subjects';
      yield serializers.serialize(
        object.subjects,
        specifiedType: const FullType.nullable(BuiltList, [FullType(SemesterSubjectGradeDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SemesterReportDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SemesterReportDtoBuilder result,
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
        case r'schoolUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.schoolUserId = valueDes;
          break;
        case r'programCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.programCode = valueDes;
          break;
        case r'schoolYearStart':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolYearStart = valueDes;
          break;
        case r'semesterHalf':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.semesterHalf = valueDes;
          break;
        case r'className':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.className = valueDes;
          break;
        case r'promotionDecision':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.promotionDecision = valueDes;
          break;
        case r'gradeAverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.gradeAverage = valueDes;
          break;
        case r'insufficientGradeCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.insufficientGradeCount = valueDes;
          break;
        case r'deficiencyPoints':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.deficiencyPoints = valueDes;
          break;
        case r'excusedAbsences':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.excusedAbsences = valueDes;
          break;
        case r'unexcusedAbsences':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.unexcusedAbsences = valueDes;
          break;
        case r'totalAbsences':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.totalAbsences = valueDes;
          break;
        case r'subjects':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SemesterSubjectGradeDto)]),
          ) as BuiltList<SemesterSubjectGradeDto>?;
          if (valueDes == null) continue;
          result.subjects.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SemesterReportDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SemesterReportDtoBuilder();
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

