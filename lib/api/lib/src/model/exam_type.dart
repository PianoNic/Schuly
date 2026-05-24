//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'exam_type.g.dart';

class ExamType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Classic')
  static const ExamType classic = _$classic;
  @BuiltValueEnumConst(wireName: r'FinalExam')
  static const ExamType finalExam = _$finalExam;

  static Serializer<ExamType> get serializer => _$examTypeSerializer;

  const ExamType._(String name): super(name);

  static BuiltSet<ExamType> get values => _$values;
  static ExamType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ExamTypeMixin = Object with _$ExamTypeMixin;

