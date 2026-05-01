//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_grade_to_exam_command.g.dart';

/// AddGradeToExamCommand
///
/// Properties:
/// * [examId] 
/// * [studentId] 
/// * [grade] 
/// * [weight] 
@BuiltValue()
abstract class AddGradeToExamCommand implements Built<AddGradeToExamCommand, AddGradeToExamCommandBuilder> {
  @BuiltValueField(wireName: r'examId')
  String? get examId;

  @BuiltValueField(wireName: r'studentId')
  String? get studentId;

  @BuiltValueField(wireName: r'grade')
  double? get grade;

  @BuiltValueField(wireName: r'weight')
  double? get weight;

  AddGradeToExamCommand._();

  factory AddGradeToExamCommand([void updates(AddGradeToExamCommandBuilder b)]) = _$AddGradeToExamCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddGradeToExamCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddGradeToExamCommand> get serializer => _$AddGradeToExamCommandSerializer();
}

class _$AddGradeToExamCommandSerializer implements PrimitiveSerializer<AddGradeToExamCommand> {
  @override
  final Iterable<Type> types = const [AddGradeToExamCommand, _$AddGradeToExamCommand];

  @override
  final String wireName = r'AddGradeToExamCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddGradeToExamCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.examId != null) {
      yield r'examId';
      yield serializers.serialize(
        object.examId,
        specifiedType: const FullType(String),
      );
    }
    if (object.studentId != null) {
      yield r'studentId';
      yield serializers.serialize(
        object.studentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.grade != null) {
      yield r'grade';
      yield serializers.serialize(
        object.grade,
        specifiedType: const FullType(double),
      );
    }
    if (object.weight != null) {
      yield r'weight';
      yield serializers.serialize(
        object.weight,
        specifiedType: const FullType(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AddGradeToExamCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AddGradeToExamCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'examId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.examId = valueDes;
          break;
        case r'studentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.studentId = valueDes;
          break;
        case r'grade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.grade = valueDes;
          break;
        case r'weight':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.weight = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AddGradeToExamCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddGradeToExamCommandBuilder();
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

