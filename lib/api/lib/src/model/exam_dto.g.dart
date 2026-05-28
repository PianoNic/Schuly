// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExamDto extends ExamDto {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final ExamType? type;
  @override
  final double classAverage;
  @override
  final String? classId;
  @override
  final String? schoolId;
  @override
  final BuiltList<GradeDto>? grades;

  factory _$ExamDto([void Function(ExamDtoBuilder)? updates]) =>
      (ExamDtoBuilder()..update(updates))._build();

  _$ExamDto._({
    this.id,
    this.name,
    this.description,
    this.type,
    required this.classAverage,
    this.classId,
    this.schoolId,
    this.grades,
  }) : super._();
  @override
  ExamDto rebuild(void Function(ExamDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExamDtoBuilder toBuilder() => ExamDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExamDto &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        type == other.type &&
        classAverage == other.classAverage &&
        classId == other.classId &&
        schoolId == other.schoolId &&
        grades == other.grades;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, classAverage.hashCode);
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, grades.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExamDto')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('type', type)
          ..add('classAverage', classAverage)
          ..add('classId', classId)
          ..add('schoolId', schoolId)
          ..add('grades', grades))
        .toString();
  }
}

class ExamDtoBuilder implements Builder<ExamDto, ExamDtoBuilder> {
  _$ExamDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ExamType? _type;
  ExamType? get type => _$this._type;
  set type(ExamType? type) => _$this._type = type;

  double? _classAverage;
  double? get classAverage => _$this._classAverage;
  set classAverage(double? classAverage) => _$this._classAverage = classAverage;

  String? _classId;
  String? get classId => _$this._classId;
  set classId(String? classId) => _$this._classId = classId;

  String? _schoolId;
  String? get schoolId => _$this._schoolId;
  set schoolId(String? schoolId) => _$this._schoolId = schoolId;

  ListBuilder<GradeDto>? _grades;
  ListBuilder<GradeDto> get grades =>
      _$this._grades ??= ListBuilder<GradeDto>();
  set grades(ListBuilder<GradeDto>? grades) => _$this._grades = grades;

  ExamDtoBuilder() {
    ExamDto._defaults(this);
  }

  ExamDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _type = $v.type;
      _classAverage = $v.classAverage;
      _classId = $v.classId;
      _schoolId = $v.schoolId;
      _grades = $v.grades?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExamDto other) {
    _$v = other as _$ExamDto;
  }

  @override
  void update(void Function(ExamDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExamDto build() => _build();

  _$ExamDto _build() {
    _$ExamDto _$result;
    try {
      _$result =
          _$v ??
          _$ExamDto._(
            id: id,
            name: name,
            description: description,
            type: type,
            classAverage: BuiltValueNullFieldError.checkNotNull(
              classAverage,
              r'ExamDto',
              'classAverage',
            ),
            classId: classId,
            schoolId: schoolId,
            grades: _grades?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'grades';
        _grades?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ExamDto',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
