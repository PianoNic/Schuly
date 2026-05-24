//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_application_user_command.g.dart';

/// UpdateApplicationUserCommand
///
/// Properties:
/// * [applicationUserId] 
/// * [displayName] 
/// * [profilePictureUrl] 
@BuiltValue()
abstract class UpdateApplicationUserCommand implements Built<UpdateApplicationUserCommand, UpdateApplicationUserCommandBuilder> {
  @BuiltValueField(wireName: r'applicationUserId')
  String? get applicationUserId;

  @BuiltValueField(wireName: r'displayName')
  String? get displayName;

  @BuiltValueField(wireName: r'profilePictureUrl')
  String? get profilePictureUrl;

  UpdateApplicationUserCommand._();

  factory UpdateApplicationUserCommand([void updates(UpdateApplicationUserCommandBuilder b)]) = _$UpdateApplicationUserCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateApplicationUserCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateApplicationUserCommand> get serializer => _$UpdateApplicationUserCommandSerializer();
}

class _$UpdateApplicationUserCommandSerializer implements PrimitiveSerializer<UpdateApplicationUserCommand> {
  @override
  final Iterable<Type> types = const [UpdateApplicationUserCommand, _$UpdateApplicationUserCommand];

  @override
  final String wireName = r'UpdateApplicationUserCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateApplicationUserCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.applicationUserId != null) {
      yield r'applicationUserId';
      yield serializers.serialize(
        object.applicationUserId,
        specifiedType: const FullType(String),
      );
    }
    if (object.displayName != null) {
      yield r'displayName';
      yield serializers.serialize(
        object.displayName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.profilePictureUrl != null) {
      yield r'profilePictureUrl';
      yield serializers.serialize(
        object.profilePictureUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateApplicationUserCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateApplicationUserCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'applicationUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.applicationUserId = valueDes;
          break;
        case r'displayName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.displayName = valueDes;
          break;
        case r'profilePictureUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.profilePictureUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateApplicationUserCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateApplicationUserCommandBuilder();
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

