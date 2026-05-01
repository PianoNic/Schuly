//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/absence_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_absence_command.g.dart';

/// UpdateAbsenceCommand
///
/// Properties:
/// * [absenceId] 
/// * [reason] 
/// * [type] 
/// * [from] 
/// * [until] 
/// * [schoolUserId] 
@BuiltValue()
abstract class UpdateAbsenceCommand implements Built<UpdateAbsenceCommand, UpdateAbsenceCommandBuilder> {
  @BuiltValueField(wireName: r'absenceId')
  String? get absenceId;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  @BuiltValueField(wireName: r'type')
  AbsenceType? get type;
  // enum typeEnum {  Absence,  Delay,  };

  @BuiltValueField(wireName: r'from')
  DateTime? get from;

  @BuiltValueField(wireName: r'until')
  DateTime? get until;

  @BuiltValueField(wireName: r'schoolUserId')
  String? get schoolUserId;

  UpdateAbsenceCommand._();

  factory UpdateAbsenceCommand([void updates(UpdateAbsenceCommandBuilder b)]) = _$UpdateAbsenceCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateAbsenceCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateAbsenceCommand> get serializer => _$UpdateAbsenceCommandSerializer();
}

class _$UpdateAbsenceCommandSerializer implements PrimitiveSerializer<UpdateAbsenceCommand> {
  @override
  final Iterable<Type> types = const [UpdateAbsenceCommand, _$UpdateAbsenceCommand];

  @override
  final String wireName = r'UpdateAbsenceCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateAbsenceCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.absenceId != null) {
      yield r'absenceId';
      yield serializers.serialize(
        object.absenceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(AbsenceType),
      );
    }
    if (object.from != null) {
      yield r'from';
      yield serializers.serialize(
        object.from,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.until != null) {
      yield r'until';
      yield serializers.serialize(
        object.until,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.schoolUserId != null) {
      yield r'schoolUserId';
      yield serializers.serialize(
        object.schoolUserId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateAbsenceCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateAbsenceCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'absenceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.absenceId = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AbsenceType),
          ) as AbsenceType;
          result.type = valueDes;
          break;
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.from = valueDes;
          break;
        case r'until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.until = valueDes;
          break;
        case r'schoolUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.schoolUserId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateAbsenceCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateAbsenceCommandBuilder();
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

