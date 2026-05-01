//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/roles.dart';
import 'package:schuly_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_school_user_command.g.dart';

/// CreateSchoolUserCommand
///
/// Properties:
/// * [applicationUserId] 
/// * [schoolId] 
/// * [firstName] 
/// * [lastName] 
/// * [email] 
/// * [privateEmail] 
/// * [phoneNumber] 
/// * [street] 
/// * [city] 
/// * [zip] 
/// * [birthday] 
/// * [entryDate] 
/// * [role] 
/// * [studentNumber] 
/// * [teacherCode] 
@BuiltValue()
abstract class CreateSchoolUserCommand implements Built<CreateSchoolUserCommand, CreateSchoolUserCommandBuilder> {
  @BuiltValueField(wireName: r'applicationUserId')
  String? get applicationUserId;

  @BuiltValueField(wireName: r'schoolId')
  String? get schoolId;

  @BuiltValueField(wireName: r'firstName')
  String? get firstName;

  @BuiltValueField(wireName: r'lastName')
  String? get lastName;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'privateEmail')
  String? get privateEmail;

  @BuiltValueField(wireName: r'phoneNumber')
  String? get phoneNumber;

  @BuiltValueField(wireName: r'street')
  String? get street;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'zip')
  String? get zip;

  @BuiltValueField(wireName: r'birthday')
  Date? get birthday;

  @BuiltValueField(wireName: r'entryDate')
  Date? get entryDate;

  @BuiltValueField(wireName: r'role')
  Roles? get role;
  // enum roleEnum {  Student,  Teacher,  Administrator,  };

  @BuiltValueField(wireName: r'studentNumber')
  String? get studentNumber;

  @BuiltValueField(wireName: r'teacherCode')
  String? get teacherCode;

  CreateSchoolUserCommand._();

  factory CreateSchoolUserCommand([void updates(CreateSchoolUserCommandBuilder b)]) = _$CreateSchoolUserCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateSchoolUserCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateSchoolUserCommand> get serializer => _$CreateSchoolUserCommandSerializer();
}

class _$CreateSchoolUserCommandSerializer implements PrimitiveSerializer<CreateSchoolUserCommand> {
  @override
  final Iterable<Type> types = const [CreateSchoolUserCommand, _$CreateSchoolUserCommand];

  @override
  final String wireName = r'CreateSchoolUserCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateSchoolUserCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.applicationUserId != null) {
      yield r'applicationUserId';
      yield serializers.serialize(
        object.applicationUserId,
        specifiedType: const FullType(String),
      );
    }
    if (object.schoolId != null) {
      yield r'schoolId';
      yield serializers.serialize(
        object.schoolId,
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
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.privateEmail != null) {
      yield r'privateEmail';
      yield serializers.serialize(
        object.privateEmail,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.phoneNumber != null) {
      yield r'phoneNumber';
      yield serializers.serialize(
        object.phoneNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.street != null) {
      yield r'street';
      yield serializers.serialize(
        object.street,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.city != null) {
      yield r'city';
      yield serializers.serialize(
        object.city,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.zip != null) {
      yield r'zip';
      yield serializers.serialize(
        object.zip,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.birthday != null) {
      yield r'birthday';
      yield serializers.serialize(
        object.birthday,
        specifiedType: const FullType(Date),
      );
    }
    if (object.entryDate != null) {
      yield r'entryDate';
      yield serializers.serialize(
        object.entryDate,
        specifiedType: const FullType(Date),
      );
    }
    if (object.role != null) {
      yield r'role';
      yield serializers.serialize(
        object.role,
        specifiedType: const FullType(Roles),
      );
    }
    if (object.studentNumber != null) {
      yield r'studentNumber';
      yield serializers.serialize(
        object.studentNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.teacherCode != null) {
      yield r'teacherCode';
      yield serializers.serialize(
        object.teacherCode,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateSchoolUserCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateSchoolUserCommandBuilder result,
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
        case r'schoolId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.schoolId = valueDes;
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
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        case r'privateEmail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.privateEmail = valueDes;
          break;
        case r'phoneNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.phoneNumber = valueDes;
          break;
        case r'street':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.street = valueDes;
          break;
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.city = valueDes;
          break;
        case r'zip':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.zip = valueDes;
          break;
        case r'birthday':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.birthday = valueDes;
          break;
        case r'entryDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.entryDate = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Roles),
          ) as Roles;
          result.role = valueDes;
          break;
        case r'studentNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.studentNumber = valueDes;
          break;
        case r'teacherCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.teacherCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateSchoolUserCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateSchoolUserCommandBuilder();
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

