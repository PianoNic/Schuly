//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_class_dto.g.dart';

/// UserClassDto
///
/// Properties:
/// * [classId] 
/// * [className] 
@BuiltValue()
abstract class UserClassDto implements Built<UserClassDto, UserClassDtoBuilder> {
  @BuiltValueField(wireName: r'classId')
  String get classId;

  @BuiltValueField(wireName: r'className')
  String? get className;

  UserClassDto._();

  factory UserClassDto([void updates(UserClassDtoBuilder b)]) = _$UserClassDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserClassDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserClassDto> get serializer => _$UserClassDtoSerializer();
}

class _$UserClassDtoSerializer implements PrimitiveSerializer<UserClassDto> {
  @override
  final Iterable<Type> types = const [UserClassDto, _$UserClassDto];

  @override
  final String wireName = r'UserClassDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserClassDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'classId';
    yield serializers.serialize(
      object.classId,
      specifiedType: const FullType(String),
    );
    yield r'className';
    yield object.className == null ? null : serializers.serialize(
      object.className,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserClassDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserClassDtoBuilder result,
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
        case r'className':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.className = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserClassDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserClassDtoBuilder();
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

