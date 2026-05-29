//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'plugin_task_status.g.dart';

/// PluginTaskStatus
///
/// Properties:
/// * [name] 
/// * [intervalSeconds] 
/// * [lastStatus] 
/// * [lastStartedAt] 
/// * [lastFinishedAt] 
/// * [lastDurationMs] 
/// * [lastError] 
/// * [nextRunAt] 
/// * [totalRuns] 
/// * [totalFailures] 
/// * [consecutiveFailures] 
@BuiltValue()
abstract class PluginTaskStatus implements Built<PluginTaskStatus, PluginTaskStatusBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'intervalSeconds')
  double? get intervalSeconds;

  @BuiltValueField(wireName: r'lastStatus')
  String? get lastStatus;

  @BuiltValueField(wireName: r'lastStartedAt')
  DateTime? get lastStartedAt;

  @BuiltValueField(wireName: r'lastFinishedAt')
  DateTime? get lastFinishedAt;

  @BuiltValueField(wireName: r'lastDurationMs')
  int? get lastDurationMs;

  @BuiltValueField(wireName: r'lastError')
  String? get lastError;

  @BuiltValueField(wireName: r'nextRunAt')
  DateTime? get nextRunAt;

  @BuiltValueField(wireName: r'totalRuns')
  int? get totalRuns;

  @BuiltValueField(wireName: r'totalFailures')
  int? get totalFailures;

  @BuiltValueField(wireName: r'consecutiveFailures')
  int? get consecutiveFailures;

  PluginTaskStatus._();

  factory PluginTaskStatus([void updates(PluginTaskStatusBuilder b)]) = _$PluginTaskStatus;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PluginTaskStatusBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PluginTaskStatus> get serializer => _$PluginTaskStatusSerializer();
}

class _$PluginTaskStatusSerializer implements PrimitiveSerializer<PluginTaskStatus> {
  @override
  final Iterable<Type> types = const [PluginTaskStatus, _$PluginTaskStatus];

  @override
  final String wireName = r'PluginTaskStatus';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PluginTaskStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.intervalSeconds != null) {
      yield r'intervalSeconds';
      yield serializers.serialize(
        object.intervalSeconds,
        specifiedType: const FullType(double),
      );
    }
    if (object.lastStatus != null) {
      yield r'lastStatus';
      yield serializers.serialize(
        object.lastStatus,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.lastStartedAt != null) {
      yield r'lastStartedAt';
      yield serializers.serialize(
        object.lastStartedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.lastFinishedAt != null) {
      yield r'lastFinishedAt';
      yield serializers.serialize(
        object.lastFinishedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.lastDurationMs != null) {
      yield r'lastDurationMs';
      yield serializers.serialize(
        object.lastDurationMs,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.lastError != null) {
      yield r'lastError';
      yield serializers.serialize(
        object.lastError,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.nextRunAt != null) {
      yield r'nextRunAt';
      yield serializers.serialize(
        object.nextRunAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.totalRuns != null) {
      yield r'totalRuns';
      yield serializers.serialize(
        object.totalRuns,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalFailures != null) {
      yield r'totalFailures';
      yield serializers.serialize(
        object.totalFailures,
        specifiedType: const FullType(int),
      );
    }
    if (object.consecutiveFailures != null) {
      yield r'consecutiveFailures';
      yield serializers.serialize(
        object.consecutiveFailures,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PluginTaskStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PluginTaskStatusBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'intervalSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.intervalSeconds = valueDes;
          break;
        case r'lastStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.lastStatus = valueDes;
          break;
        case r'lastStartedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastStartedAt = valueDes;
          break;
        case r'lastFinishedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastFinishedAt = valueDes;
          break;
        case r'lastDurationMs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.lastDurationMs = valueDes;
          break;
        case r'lastError':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.lastError = valueDes;
          break;
        case r'nextRunAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.nextRunAt = valueDes;
          break;
        case r'totalRuns':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalRuns = valueDes;
          break;
        case r'totalFailures':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalFailures = valueDes;
          break;
        case r'consecutiveFailures':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.consecutiveFailures = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PluginTaskStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PluginTaskStatusBuilder();
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

