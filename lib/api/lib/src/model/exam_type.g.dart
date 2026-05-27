// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ExamType _$classic = const ExamType._('classic');
const ExamType _$finalExam = const ExamType._('finalExam');

ExamType _$valueOf(String name) {
  switch (name) {
    case 'classic':
      return _$classic;
    case 'finalExam':
      return _$finalExam;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ExamType> _$values = BuiltSet<ExamType>(const <ExamType>[
  _$classic,
  _$finalExam,
]);

class _$ExamTypeMeta {
  const _$ExamTypeMeta();
  ExamType get classic => _$classic;
  ExamType get finalExam => _$finalExam;
  ExamType valueOf(String name) => _$valueOf(name);
  BuiltSet<ExamType> get values => _$values;
}

mixin _$ExamTypeMixin {
  // ignore: non_constant_identifier_names
  _$ExamTypeMeta get ExamType => const _$ExamTypeMeta();
}

Serializer<ExamType> _$examTypeSerializer = _$ExamTypeSerializer();

class _$ExamTypeSerializer implements PrimitiveSerializer<ExamType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'classic': 'Classic',
    'finalExam': 'FinalExam',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Classic': 'classic',
    'FinalExam': 'finalExam',
  };

  @override
  final Iterable<Type> types = const <Type>[ExamType];
  @override
  final String wireName = 'ExamType';

  @override
  Object serialize(
    Serializers serializers,
    ExamType object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ExamType deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ExamType.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
