//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/user_state.dart';
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/absence_dto.dart';
import 'package:schuly_api/src/model/roles.dart';
import 'package:schuly_api/src/model/user_class_dto.dart';
import 'package:schuly_api/src/model/date.dart';
import 'package:schuly_api/src/model/grade_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'school_user_dto.g.dart';

/// SchoolUserDto
///
/// Properties:
/// * [id] 
/// * [applicationUserId] 
/// * [schoolId] 
/// * [schoolName] 
/// * [firstName] 
/// * [lastName] 
/// * [email] 
/// * [privateEmail] 
/// * [phoneNumber] 
/// * [profilePictureUrl] 
/// * [street] 
/// * [city] 
/// * [zip] 
/// * [birthday] 
/// * [entryDate] 
/// * [leaveDate] 
/// * [role] 
/// * [state] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [absences] 
/// * [grades] 
/// * [classes] 
@BuiltValue()
abstract class SchoolUserDto implements Built<SchoolUserDto, SchoolUserDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'applicationUserId')
  String? get applicationUserId;

  @BuiltValueField(wireName: r'schoolId')
  String? get schoolId;

  @BuiltValueField(wireName: r'schoolName')
  String? get schoolName;

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

  @BuiltValueField(wireName: r'profilePictureUrl')
  String? get profilePictureUrl;

  @BuiltValueField(wireName: r'street')
  String? get street;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'zip')
  String? get zip;

  @BuiltValueField(wireName: r'birthday')
  Date get birthday;

  @BuiltValueField(wireName: r'entryDate')
  Date get entryDate;

  @BuiltValueField(wireName: r'leaveDate')
  Date? get leaveDate;

  @BuiltValueField(wireName: r'role')
  Roles get role;
  // enum roleEnum {  Student,  Teacher,  Administrator,  };

  @BuiltValueField(wireName: r'state')
  UserState? get state;
  // enum stateEnum {  None,  Active,  Inactive,  };

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updatedAt')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'absences')
  BuiltList<AbsenceDto>? get absences;

  @BuiltValueField(wireName: r'grades')
  BuiltList<GradeDto>? get grades;

  @BuiltValueField(wireName: r'classes')
  BuiltList<UserClassDto>? get classes;

  SchoolUserDto._();

  factory SchoolUserDto([void updates(SchoolUserDtoBuilder b)]) = _$SchoolUserDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SchoolUserDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SchoolUserDto> get serializer => _$SchoolUserDtoSerializer();
}

class _$SchoolUserDtoSerializer implements PrimitiveSerializer<SchoolUserDto> {
  @override
  final Iterable<Type> types = const [SchoolUserDto, _$SchoolUserDto];

  @override
  final String wireName = r'SchoolUserDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SchoolUserDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.schoolName != null) {
      yield r'schoolName';
      yield serializers.serialize(
        object.schoolName,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'firstName';
    yield object.firstName == null ? null : serializers.serialize(
      object.firstName,
      specifiedType: const FullType.nullable(String),
    );
    yield r'lastName';
    yield object.lastName == null ? null : serializers.serialize(
      object.lastName,
      specifiedType: const FullType.nullable(String),
    );
    yield r'email';
    yield object.email == null ? null : serializers.serialize(
      object.email,
      specifiedType: const FullType.nullable(String),
    );
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
    if (object.profilePictureUrl != null) {
      yield r'profilePictureUrl';
      yield serializers.serialize(
        object.profilePictureUrl,
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
    yield r'birthday';
    yield serializers.serialize(
      object.birthday,
      specifiedType: const FullType(Date),
    );
    yield r'entryDate';
    yield serializers.serialize(
      object.entryDate,
      specifiedType: const FullType(Date),
    );
    if (object.leaveDate != null) {
      yield r'leaveDate';
      yield serializers.serialize(
        object.leaveDate,
        specifiedType: const FullType.nullable(Date),
      );
    }
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(Roles),
    );
    if (object.state != null) {
      yield r'state';
      yield serializers.serialize(
        object.state,
        specifiedType: const FullType(UserState),
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
    if (object.absences != null) {
      yield r'absences';
      yield serializers.serialize(
        object.absences,
        specifiedType: const FullType.nullable(BuiltList, [FullType(AbsenceDto)]),
      );
    }
    if (object.grades != null) {
      yield r'grades';
      yield serializers.serialize(
        object.grades,
        specifiedType: const FullType.nullable(BuiltList, [FullType(GradeDto)]),
      );
    }
    if (object.classes != null) {
      yield r'classes';
      yield serializers.serialize(
        object.classes,
        specifiedType: const FullType.nullable(BuiltList, [FullType(UserClassDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SchoolUserDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SchoolUserDtoBuilder result,
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
        case r'schoolName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.schoolName = valueDes;
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
        case r'profilePictureUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.profilePictureUrl = valueDes;
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
        case r'leaveDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.leaveDate = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Roles),
          ) as Roles;
          result.role = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserState),
          ) as UserState;
          result.state = valueDes;
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
        case r'absences':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(AbsenceDto)]),
          ) as BuiltList<AbsenceDto>?;
          if (valueDes == null) continue;
          result.absences.replace(valueDes);
          break;
        case r'grades':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(GradeDto)]),
          ) as BuiltList<GradeDto>?;
          if (valueDes == null) continue;
          result.grades.replace(valueDes);
          break;
        case r'classes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(UserClassDto)]),
          ) as BuiltList<UserClassDto>?;
          if (valueDes == null) continue;
          result.classes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SchoolUserDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SchoolUserDtoBuilder();
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

