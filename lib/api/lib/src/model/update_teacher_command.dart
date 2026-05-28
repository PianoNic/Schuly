//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_teacher_command.g.dart';

/// UpdateTeacherCommand
///
/// Properties:
/// * [teacherId] 
/// * [firstName] 
/// * [lastName] 
/// * [code] 
/// * [email] 
@BuiltValue()
abstract class UpdateTeacherCommand implements Built<UpdateTeacherCommand, UpdateTeacherCommandBuilder> {
  @BuiltValueField(wireName: r'teacherId')
  String? get teacherId;

  @BuiltValueField(wireName: r'firstName')
  String? get firstName;

  @BuiltValueField(wireName: r'lastName')
  String? get lastName;

  @BuiltValueField(wireName: r'code')
  String? get code;

  @BuiltValueField(wireName: r'email')
  String? get email;

  UpdateTeacherCommand._();

  factory UpdateTeacherCommand([void updates(UpdateTeacherCommandBuilder b)]) = _$UpdateTeacherCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateTeacherCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateTeacherCommand> get serializer => _$UpdateTeacherCommandSerializer();
}

class _$UpdateTeacherCommandSerializer implements PrimitiveSerializer<UpdateTeacherCommand> {
  @override
  final Iterable<Type> types = const [UpdateTeacherCommand, _$UpdateTeacherCommand];

  @override
  final String wireName = r'UpdateTeacherCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateTeacherCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.teacherId != null) {
      yield r'teacherId';
      yield serializers.serialize(
        object.teacherId,
        specifiedType: const FullType(String),
      );
    }
    if (object.firstName != null) {
      yield r'firstName';
      yield serializers.serialize(
        object.firstName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.lastName != null) {
      yield r'lastName';
      yield serializers.serialize(
        object.lastName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateTeacherCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateTeacherCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'teacherId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.teacherId = valueDes;
          break;
        case r'firstName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.firstName = valueDes;
          break;
        case r'lastName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.lastName = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.code = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateTeacherCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateTeacherCommandBuilder();
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

