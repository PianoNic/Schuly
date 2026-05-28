// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester_subject_grade_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SemesterSubjectGradeDto extends SemesterSubjectGradeDto {
  @override
  final String? id;
  @override
  final String? semesterReportId;
  @override
  final String? subjectCode;
  @override
  final String? subjectName;
  @override
  final String? subjectTypeMarker;
  @override
  final double? grade;
  @override
  final String? marker;

  factory _$SemesterSubjectGradeDto([
    void Function(SemesterSubjectGradeDtoBuilder)? updates,
  ]) => (SemesterSubjectGradeDtoBuilder()..update(updates))._build();

  _$SemesterSubjectGradeDto._({
    this.id,
    this.semesterReportId,
    this.subjectCode,
    this.subjectName,
    this.subjectTypeMarker,
    this.grade,
    this.marker,
  }) : super._();
  @override
  SemesterSubjectGradeDto rebuild(
    void Function(SemesterSubjectGradeDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SemesterSubjectGradeDtoBuilder toBuilder() =>
      SemesterSubjectGradeDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SemesterSubjectGradeDto &&
        id == other.id &&
        semesterReportId == other.semesterReportId &&
        subjectCode == other.subjectCode &&
        subjectName == other.subjectName &&
        subjectTypeMarker == other.subjectTypeMarker &&
        grade == other.grade &&
        marker == other.marker;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, semesterReportId.hashCode);
    _$hash = $jc(_$hash, subjectCode.hashCode);
    _$hash = $jc(_$hash, subjectName.hashCode);
    _$hash = $jc(_$hash, subjectTypeMarker.hashCode);
    _$hash = $jc(_$hash, grade.hashCode);
    _$hash = $jc(_$hash, marker.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SemesterSubjectGradeDto')
          ..add('id', id)
          ..add('semesterReportId', semesterReportId)
          ..add('subjectCode', subjectCode)
          ..add('subjectName', subjectName)
          ..add('subjectTypeMarker', subjectTypeMarker)
          ..add('grade', grade)
          ..add('marker', marker))
        .toString();
  }
}

class SemesterSubjectGradeDtoBuilder
    implements
        Builder<SemesterSubjectGradeDto, SemesterSubjectGradeDtoBuilder> {
  _$SemesterSubjectGradeDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _semesterReportId;
  String? get semesterReportId => _$this._semesterReportId;
  set semesterReportId(String? semesterReportId) =>
      _$this._semesterReportId = semesterReportId;

  String? _subjectCode;
  String? get subjectCode => _$this._subjectCode;
  set subjectCode(String? subjectCode) => _$this._subjectCode = subjectCode;

  String? _subjectName;
  String? get subjectName => _$this._subjectName;
  set subjectName(String? subjectName) => _$this._subjectName = subjectName;

  String? _subjectTypeMarker;
  String? get subjectTypeMarker => _$this._subjectTypeMarker;
  set subjectTypeMarker(String? subjectTypeMarker) =>
      _$this._subjectTypeMarker = subjectTypeMarker;

  double? _grade;
  double? get grade => _$this._grade;
  set grade(double? grade) => _$this._grade = grade;

  String? _marker;
  String? get marker => _$this._marker;
  set marker(String? marker) => _$this._marker = marker;

  SemesterSubjectGradeDtoBuilder() {
    SemesterSubjectGradeDto._defaults(this);
  }

  SemesterSubjectGradeDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _semesterReportId = $v.semesterReportId;
      _subjectCode = $v.subjectCode;
      _subjectName = $v.subjectName;
      _subjectTypeMarker = $v.subjectTypeMarker;
      _grade = $v.grade;
      _marker = $v.marker;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SemesterSubjectGradeDto other) {
    _$v = other as _$SemesterSubjectGradeDto;
  }

  @override
  void update(void Function(SemesterSubjectGradeDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SemesterSubjectGradeDto build() => _build();

  _$SemesterSubjectGradeDto _build() {
    final _$result =
        _$v ??
        _$SemesterSubjectGradeDto._(
          id: id,
          semesterReportId: semesterReportId,
          subjectCode: subjectCode,
          subjectName: subjectName,
          subjectTypeMarker: subjectTypeMarker,
          grade: grade,
          marker: marker,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
