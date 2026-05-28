//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'student_document_dto.g.dart';

/// StudentDocumentDto
///
/// Properties:
/// * [id] 
/// * [schoolUserId] 
/// * [title] 
/// * [comment] 
/// * [category] 
/// * [enteredBy] 
/// * [fileName] 
/// * [fileSizeBytes] 
/// * [followUpAction] 
/// * [followUpDate] 
/// * [completedDate] 
/// * [notifiedAt] 
/// * [createdAt] 
@BuiltValue()
abstract class StudentDocumentDto implements Built<StudentDocumentDto, StudentDocumentDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'schoolUserId')
  String? get schoolUserId;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'category')
  String? get category;

  @BuiltValueField(wireName: r'enteredBy')
  String? get enteredBy;

  @BuiltValueField(wireName: r'fileName')
  String? get fileName;

  @BuiltValueField(wireName: r'fileSizeBytes')
  int? get fileSizeBytes;

  @BuiltValueField(wireName: r'followUpAction')
  String? get followUpAction;

  @BuiltValueField(wireName: r'followUpDate')
  Date? get followUpDate;

  @BuiltValueField(wireName: r'completedDate')
  Date? get completedDate;

  @BuiltValueField(wireName: r'notifiedAt')
  DateTime? get notifiedAt;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  StudentDocumentDto._();

  factory StudentDocumentDto([void updates(StudentDocumentDtoBuilder b)]) = _$StudentDocumentDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentDocumentDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentDocumentDto> get serializer => _$StudentDocumentDtoSerializer();
}

class _$StudentDocumentDtoSerializer implements PrimitiveSerializer<StudentDocumentDto> {
  @override
  final Iterable<Type> types = const [StudentDocumentDto, _$StudentDocumentDto];

  @override
  final String wireName = r'StudentDocumentDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentDocumentDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.schoolUserId != null) {
      yield r'schoolUserId';
      yield serializers.serialize(
        object.schoolUserId,
        specifiedType: const FullType(String),
      );
    }
    yield r'title';
    yield object.title == null ? null : serializers.serialize(
      object.title,
      specifiedType: const FullType.nullable(String),
    );
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.enteredBy != null) {
      yield r'enteredBy';
      yield serializers.serialize(
        object.enteredBy,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.fileName != null) {
      yield r'fileName';
      yield serializers.serialize(
        object.fileName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.fileSizeBytes != null) {
      yield r'fileSizeBytes';
      yield serializers.serialize(
        object.fileSizeBytes,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.followUpAction != null) {
      yield r'followUpAction';
      yield serializers.serialize(
        object.followUpAction,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.followUpDate != null) {
      yield r'followUpDate';
      yield serializers.serialize(
        object.followUpDate,
        specifiedType: const FullType.nullable(Date),
      );
    }
    if (object.completedDate != null) {
      yield r'completedDate';
      yield serializers.serialize(
        object.completedDate,
        specifiedType: const FullType.nullable(Date),
      );
    }
    if (object.notifiedAt != null) {
      yield r'notifiedAt';
      yield serializers.serialize(
        object.notifiedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    StudentDocumentDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StudentDocumentDtoBuilder result,
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
        case r'schoolUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.schoolUserId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.category = valueDes;
          break;
        case r'enteredBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.enteredBy = valueDes;
          break;
        case r'fileName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fileName = valueDes;
          break;
        case r'fileSizeBytes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.fileSizeBytes = valueDes;
          break;
        case r'followUpAction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.followUpAction = valueDes;
          break;
        case r'followUpDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.followUpDate = valueDes;
          break;
        case r'completedDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.completedDate = valueDes;
          break;
        case r'notifiedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.notifiedAt = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StudentDocumentDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentDocumentDtoBuilder();
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

