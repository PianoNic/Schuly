//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/exam_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_exam_command.g.dart';

/// UpdateExamCommand
///
/// Properties:
/// * [examId] 
/// * [name] 
/// * [description] 
/// * [type] 
/// * [classId] 
@BuiltValue()
abstract class UpdateExamCommand implements Built<UpdateExamCommand, UpdateExamCommandBuilder> {
  @BuiltValueField(wireName: r'examId')
  String? get examId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'type')
  ExamType? get type;
  // enum typeEnum {  Classic,  FinalExam,  };

  @BuiltValueField(wireName: r'classId')
  String? get classId;

  UpdateExamCommand._();

  factory UpdateExamCommand([void updates(UpdateExamCommandBuilder b)]) = _$UpdateExamCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateExamCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateExamCommand> get serializer => _$UpdateExamCommandSerializer();
}

class _$UpdateExamCommandSerializer implements PrimitiveSerializer<UpdateExamCommand> {
  @override
  final Iterable<Type> types = const [UpdateExamCommand, _$UpdateExamCommand];

  @override
  final String wireName = r'UpdateExamCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateExamCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.examId != null) {
      yield r'examId';
      yield serializers.serialize(
        object.examId,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
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
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(ExamType),
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
    UpdateExamCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateExamCommandBuilder result,
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
  UpdateExamCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateExamCommandBuilder();
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

