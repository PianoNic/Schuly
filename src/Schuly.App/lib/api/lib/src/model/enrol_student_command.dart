//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'enrol_student_command.g.dart';

/// EnrolStudentCommand
///
/// Properties:
/// * [userId] 
/// * [classId] 
@BuiltValue()
abstract class EnrolStudentCommand implements Built<EnrolStudentCommand, EnrolStudentCommandBuilder> {
  @BuiltValueField(wireName: r'userId')
  String? get userId;

  @BuiltValueField(wireName: r'classId')
  String? get classId;

  EnrolStudentCommand._();

  factory EnrolStudentCommand([void updates(EnrolStudentCommandBuilder b)]) = _$EnrolStudentCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EnrolStudentCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EnrolStudentCommand> get serializer => _$EnrolStudentCommandSerializer();
}

class _$EnrolStudentCommandSerializer implements PrimitiveSerializer<EnrolStudentCommand> {
  @override
  final Iterable<Type> types = const [EnrolStudentCommand, _$EnrolStudentCommand];

  @override
  final String wireName = r'EnrolStudentCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EnrolStudentCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
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
    EnrolStudentCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EnrolStudentCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
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
  EnrolStudentCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EnrolStudentCommandBuilder();
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

