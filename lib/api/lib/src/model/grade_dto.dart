//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'grade_dto.g.dart';

/// GradeDto
///
/// Properties:
/// * [id] 
/// * [score] 
/// * [weighting] 
/// * [examId] 
/// * [schoolUserId] 
@BuiltValue()
abstract class GradeDto implements Built<GradeDto, GradeDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'score')
  double? get score;

  @BuiltValueField(wireName: r'weighting')
  double? get weighting;

  @BuiltValueField(wireName: r'examId')
  String? get examId;

  @BuiltValueField(wireName: r'schoolUserId')
  String? get schoolUserId;

  GradeDto._();

  factory GradeDto([void updates(GradeDtoBuilder b)]) = _$GradeDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GradeDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GradeDto> get serializer => _$GradeDtoSerializer();
}

class _$GradeDtoSerializer implements PrimitiveSerializer<GradeDto> {
  @override
  final Iterable<Type> types = const [GradeDto, _$GradeDto];

  @override
  final String wireName = r'GradeDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GradeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.score != null) {
      yield r'score';
      yield serializers.serialize(
        object.score,
        specifiedType: const FullType(double),
      );
    }
    if (object.weighting != null) {
      yield r'weighting';
      yield serializers.serialize(
        object.weighting,
        specifiedType: const FullType(double),
      );
    }
    if (object.examId != null) {
      yield r'examId';
      yield serializers.serialize(
        object.examId,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    GradeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GradeDtoBuilder result,
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
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.score = valueDes;
          break;
        case r'weighting':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.weighting = valueDes;
          break;
        case r'examId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.examId = valueDes;
          break;
        case r'schoolUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  GradeDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GradeDtoBuilder();
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

