// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_grade_to_exam_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddGradeToExamCommand extends AddGradeToExamCommand {
  @override
  final String? examId;
  @override
  final String? studentId;
  @override
  final double? grade;
  @override
  final double? weight;

  factory _$AddGradeToExamCommand([
    void Function(AddGradeToExamCommandBuilder)? updates,
  ]) => (AddGradeToExamCommandBuilder()..update(updates))._build();

  _$AddGradeToExamCommand._({
    this.examId,
    this.studentId,
    this.grade,
    this.weight,
  }) : super._();
  @override
  AddGradeToExamCommand rebuild(
    void Function(AddGradeToExamCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AddGradeToExamCommandBuilder toBuilder() =>
      AddGradeToExamCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddGradeToExamCommand &&
        examId == other.examId &&
        studentId == other.studentId &&
        grade == other.grade &&
        weight == other.weight;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, examId.hashCode);
    _$hash = $jc(_$hash, studentId.hashCode);
    _$hash = $jc(_$hash, grade.hashCode);
    _$hash = $jc(_$hash, weight.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddGradeToExamCommand')
          ..add('examId', examId)
          ..add('studentId', studentId)
          ..add('grade', grade)
          ..add('weight', weight))
        .toString();
  }
}

class AddGradeToExamCommandBuilder
    implements Builder<AddGradeToExamCommand, AddGradeToExamCommandBuilder> {
  _$AddGradeToExamCommand? _$v;

  String? _examId;
  String? get examId => _$this._examId;
  set examId(String? examId) => _$this._examId = examId;

  String? _studentId;
  String? get studentId => _$this._studentId;
  set studentId(String? studentId) => _$this._studentId = studentId;

  double? _grade;
  double? get grade => _$this._grade;
  set grade(double? grade) => _$this._grade = grade;

  double? _weight;
  double? get weight => _$this._weight;
  set weight(double? weight) => _$this._weight = weight;

  AddGradeToExamCommandBuilder() {
    AddGradeToExamCommand._defaults(this);
  }

  AddGradeToExamCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _examId = $v.examId;
      _studentId = $v.studentId;
      _grade = $v.grade;
      _weight = $v.weight;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddGradeToExamCommand other) {
    _$v = other as _$AddGradeToExamCommand;
  }

  @override
  void update(void Function(AddGradeToExamCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddGradeToExamCommand build() => _build();

  _$AddGradeToExamCommand _build() {
    final _$result =
        _$v ??
        _$AddGradeToExamCommand._(
          examId: examId,
          studentId: studentId,
          grade: grade,
          weight: weight,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
