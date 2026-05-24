//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_dto.g.dart';

/// AppDto
///
/// Properties:
/// * [authority] 
/// * [clientId] 
/// * [redirectUri] 
/// * [postLogoutRedirectUri] 
/// * [scope] 
/// * [version] 
@BuiltValue()
abstract class AppDto implements Built<AppDto, AppDtoBuilder> {
  @BuiltValueField(wireName: r'authority')
  String? get authority;

  @BuiltValueField(wireName: r'clientId')
  String? get clientId;

  @BuiltValueField(wireName: r'redirectUri')
  String? get redirectUri;

  @BuiltValueField(wireName: r'postLogoutRedirectUri')
  String? get postLogoutRedirectUri;

  @BuiltValueField(wireName: r'scope')
  String? get scope;

  @BuiltValueField(wireName: r'version')
  String? get version;

  AppDto._();

  factory AppDto([void updates(AppDtoBuilder b)]) = _$AppDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AppDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AppDto> get serializer => _$AppDtoSerializer();
}

class _$AppDtoSerializer implements PrimitiveSerializer<AppDto> {
  @override
  final Iterable<Type> types = const [AppDto, _$AppDto];

  @override
  final String wireName = r'AppDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AppDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.authority != null) {
      yield r'authority';
      yield serializers.serialize(
        object.authority,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.clientId != null) {
      yield r'clientId';
      yield serializers.serialize(
        object.clientId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.redirectUri != null) {
      yield r'redirectUri';
      yield serializers.serialize(
        object.redirectUri,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.postLogoutRedirectUri != null) {
      yield r'postLogoutRedirectUri';
      yield serializers.serialize(
        object.postLogoutRedirectUri,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.scope != null) {
      yield r'scope';
      yield serializers.serialize(
        object.scope,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.version != null) {
      yield r'version';
      yield serializers.serialize(
        object.version,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AppDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AppDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'authority':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.authority = valueDes;
          break;
        case r'clientId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.clientId = valueDes;
          break;
        case r'redirectUri':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.redirectUri = valueDes;
          break;
        case r'postLogoutRedirectUri':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.postLogoutRedirectUri = valueDes;
          break;
        case r'scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.scope = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.version = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AppDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AppDtoBuilder();
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

