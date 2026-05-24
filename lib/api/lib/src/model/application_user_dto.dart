//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/school_user_summary_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'application_user_dto.g.dart';

/// ApplicationUserDto
///
/// Properties:
/// * [id] 
/// * [externalId] 
/// * [email] 
/// * [displayName] 
/// * [profilePictureUrl] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolUsers] 
@BuiltValue()
abstract class ApplicationUserDto implements Built<ApplicationUserDto, ApplicationUserDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'externalId')
  String? get externalId;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'displayName')
  String? get displayName;

  @BuiltValueField(wireName: r'profilePictureUrl')
  String? get profilePictureUrl;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updatedAt')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'schoolUsers')
  BuiltList<SchoolUserSummaryDto>? get schoolUsers;

  ApplicationUserDto._();

  factory ApplicationUserDto([void updates(ApplicationUserDtoBuilder b)]) = _$ApplicationUserDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApplicationUserDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApplicationUserDto> get serializer => _$ApplicationUserDtoSerializer();
}

class _$ApplicationUserDtoSerializer implements PrimitiveSerializer<ApplicationUserDto> {
  @override
  final Iterable<Type> types = const [ApplicationUserDto, _$ApplicationUserDto];

  @override
  final String wireName = r'ApplicationUserDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApplicationUserDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    yield r'externalId';
    yield object.externalId == null ? null : serializers.serialize(
      object.externalId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'email';
    yield object.email == null ? null : serializers.serialize(
      object.email,
      specifiedType: const FullType.nullable(String),
    );
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
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.updatedAt != null) {
      yield r'updatedAt';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.schoolUsers != null) {
      yield r'schoolUsers';
      yield serializers.serialize(
        object.schoolUsers,
        specifiedType: const FullType.nullable(BuiltList, [FullType(SchoolUserSummaryDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApplicationUserDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApplicationUserDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'externalId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.externalId = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
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
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        case r'schoolUsers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SchoolUserSummaryDto)]),
          ) as BuiltList<SchoolUserSummaryDto>?;
          if (valueDes == null) continue;
          result.schoolUsers.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApplicationUserDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApplicationUserDtoBuilder();
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

