//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_class_command.g.dart';

/// UpdateClassCommand
///
/// Properties:
/// * [classId] 
/// * [name] 
/// * [description] 
@BuiltValue()
abstract class UpdateClassCommand implements Built<UpdateClassCommand, UpdateClassCommandBuilder> {
  @BuiltValueField(wireName: r'classId')
  String? get classId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  UpdateClassCommand._();

  factory UpdateClassCommand([void updates(UpdateClassCommandBuilder b)]) = _$UpdateClassCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateClassCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateClassCommand> get serializer => _$UpdateClassCommandSerializer();
}

class _$UpdateClassCommandSerializer implements PrimitiveSerializer<UpdateClassCommand> {
  @override
  final Iterable<Type> types = const [UpdateClassCommand, _$UpdateClassCommand];

  @override
  final String wireName = r'UpdateClassCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateClassCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.classId != null) {
      yield r'classId';
      yield serializers.serialize(
        object.classId,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateClassCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateClassCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'classId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.classId = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateClassCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateClassCommandBuilder();
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

