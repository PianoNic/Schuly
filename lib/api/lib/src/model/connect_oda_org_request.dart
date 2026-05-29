//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'connect_oda_org_request.g.dart';

/// ConnectOdaOrgRequest
///
/// Properties:
/// * [username] 
/// * [password] 
/// * [baseUrl] 
/// * [displayName] 
@BuiltValue()
abstract class ConnectOdaOrgRequest implements Built<ConnectOdaOrgRequest, ConnectOdaOrgRequestBuilder> {
  @BuiltValueField(wireName: r'username')
  String? get username;

  @BuiltValueField(wireName: r'password')
  String? get password;

  @BuiltValueField(wireName: r'baseUrl')
  String? get baseUrl;

  @BuiltValueField(wireName: r'displayName')
  String? get displayName;

  ConnectOdaOrgRequest._();

  factory ConnectOdaOrgRequest([void updates(ConnectOdaOrgRequestBuilder b)]) = _$ConnectOdaOrgRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConnectOdaOrgRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConnectOdaOrgRequest> get serializer => _$ConnectOdaOrgRequestSerializer();
}

class _$ConnectOdaOrgRequestSerializer implements PrimitiveSerializer<ConnectOdaOrgRequest> {
  @override
  final Iterable<Type> types = const [ConnectOdaOrgRequest, _$ConnectOdaOrgRequest];

  @override
  final String wireName = r'ConnectOdaOrgRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConnectOdaOrgRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.username != null) {
      yield r'username';
      yield serializers.serialize(
        object.username,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.password != null) {
      yield r'password';
      yield serializers.serialize(
        object.password,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.baseUrl != null) {
      yield r'baseUrl';
      yield serializers.serialize(
        object.baseUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.displayName != null) {
      yield r'displayName';
      yield serializers.serialize(
        object.displayName,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ConnectOdaOrgRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ConnectOdaOrgRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.username = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.password = valueDes;
          break;
        case r'baseUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.baseUrl = valueDes;
          break;
        case r'displayName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.displayName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ConnectOdaOrgRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConnectOdaOrgRequestBuilder();
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

