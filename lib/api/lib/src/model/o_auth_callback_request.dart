//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'o_auth_callback_request.g.dart';

/// OAuthCallbackRequest
///
/// Properties:
/// * [code] 
/// * [codeVerifier] 
/// * [state] 
/// * [contextState] 
/// * [userAgent] 
@BuiltValue()
abstract class OAuthCallbackRequest implements Built<OAuthCallbackRequest, OAuthCallbackRequestBuilder> {
  @BuiltValueField(wireName: r'code')
  String? get code;

  @BuiltValueField(wireName: r'codeVerifier')
  String? get codeVerifier;

  @BuiltValueField(wireName: r'state')
  String? get state;

  @BuiltValueField(wireName: r'contextState')
  String? get contextState;

  @BuiltValueField(wireName: r'userAgent')
  String? get userAgent;

  OAuthCallbackRequest._();

  factory OAuthCallbackRequest([void updates(OAuthCallbackRequestBuilder b)]) = _$OAuthCallbackRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OAuthCallbackRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OAuthCallbackRequest> get serializer => _$OAuthCallbackRequestSerializer();
}

class _$OAuthCallbackRequestSerializer implements PrimitiveSerializer<OAuthCallbackRequest> {
  @override
  final Iterable<Type> types = const [OAuthCallbackRequest, _$OAuthCallbackRequest];

  @override
  final String wireName = r'OAuthCallbackRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OAuthCallbackRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.codeVerifier != null) {
      yield r'codeVerifier';
      yield serializers.serialize(
        object.codeVerifier,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.state != null) {
      yield r'state';
      yield serializers.serialize(
        object.state,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.contextState != null) {
      yield r'contextState';
      yield serializers.serialize(
        object.contextState,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.userAgent != null) {
      yield r'userAgent';
      yield serializers.serialize(
        object.userAgent,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OAuthCallbackRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OAuthCallbackRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.code = valueDes;
          break;
        case r'codeVerifier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.codeVerifier = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.state = valueDes;
          break;
        case r'contextState':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contextState = valueDes;
          break;
        case r'userAgent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userAgent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OAuthCallbackRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OAuthCallbackRequestBuilder();
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

