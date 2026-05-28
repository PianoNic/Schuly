// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester_report_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SemesterReportDto extends SemesterReportDto {
  @override
  final String? id;
  @override
  final String? schoolUserId;
  @override
  final String? programCode;
  @override
  final int schoolYearStart;
  @override
  final int semesterHalf;
  @override
  final String? className;
  @override
  final String? promotionDecision;
  @override
  final double? gradeAverage;
  @override
  final int? insufficientGradeCount;
  @override
  final int? deficiencyPoints;
  @override
  final int? excusedAbsences;
  @override
  final int? unexcusedAbsences;
  @override
  final int? totalAbsences;
  @override
  final BuiltList<SemesterSubjectGradeDto>? subjects;

  factory _$SemesterReportDto([
    void Function(SemesterReportDtoBuilder)? updates,
  ]) => (SemesterReportDtoBuilder()..update(updates))._build();

  _$SemesterReportDto._({
    this.id,
    this.schoolUserId,
    this.programCode,
    required this.schoolYearStart,
    required this.semesterHalf,
    this.className,
    this.promotionDecision,
    this.gradeAverage,
    this.insufficientGradeCount,
    this.deficiencyPoints,
    this.excusedAbsences,
    this.unexcusedAbsences,
    this.totalAbsences,
    this.subjects,
  }) : super._();
  @override
  SemesterReportDto rebuild(void Function(SemesterReportDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SemesterReportDtoBuilder toBuilder() =>
      SemesterReportDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SemesterReportDto &&
        id == other.id &&
        schoolUserId == other.schoolUserId &&
        programCode == other.programCode &&
        schoolYearStart == other.schoolYearStart &&
        semesterHalf == other.semesterHalf &&
        className == other.className &&
        promotionDecision == other.promotionDecision &&
        gradeAverage == other.gradeAverage &&
        insufficientGradeCount == other.insufficientGradeCount &&
        deficiencyPoints == other.deficiencyPoints &&
        excusedAbsences == other.excusedAbsences &&
        unexcusedAbsences == other.unexcusedAbsences &&
        totalAbsences == other.totalAbsences &&
        subjects == other.subjects;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, schoolUserId.hashCode);
    _$hash = $jc(_$hash, programCode.hashCode);
    _$hash = $jc(_$hash, schoolYearStart.hashCode);
    _$hash = $jc(_$hash, semesterHalf.hashCode);
    _$hash = $jc(_$hash, className.hashCode);
    _$hash = $jc(_$hash, promotionDecision.hashCode);
    _$hash = $jc(_$hash, gradeAverage.hashCode);
    _$hash = $jc(_$hash, insufficientGradeCount.hashCode);
    _$hash = $jc(_$hash, deficiencyPoints.hashCode);
    _$hash = $jc(_$hash, excusedAbsences.hashCode);
    _$hash = $jc(_$hash, unexcusedAbsences.hashCode);
    _$hash = $jc(_$hash, totalAbsences.hashCode);
    _$hash = $jc(_$hash, subjects.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SemesterReportDto')
          ..add('id', id)
          ..add('schoolUserId', schoolUserId)
          ..add('programCode', programCode)
          ..add('schoolYearStart', schoolYearStart)
          ..add('semesterHalf', semesterHalf)
          ..add('className', className)
          ..add('promotionDecision', promotionDecision)
          ..add('gradeAverage', gradeAverage)
          ..add('insufficientGradeCount', insufficientGradeCount)
          ..add('deficiencyPoints', deficiencyPoints)
          ..add('excusedAbsences', excusedAbsences)
          ..add('unexcusedAbsences', unexcusedAbsences)
          ..add('totalAbsences', totalAbsences)
          ..add('subjects', subjects))
        .toString();
  }
}

class SemesterReportDtoBuilder
    implements Builder<SemesterReportDto, SemesterReportDtoBuilder> {
  _$SemesterReportDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _schoolUserId;
  String? get schoolUserId => _$this._schoolUserId;
  set schoolUserId(String? schoolUserId) => _$this._schoolUserId = schoolUserId;

  String? _programCode;
  String? get programCode => _$this._programCode;
  set programCode(String? programCode) => _$this._programCode = programCode;

  int? _schoolYearStart;
  int? get schoolYearStart => _$this._schoolYearStart;
  set schoolYearStart(int? schoolYearStart) =>
      _$this._schoolYearStart = schoolYearStart;

  int? _semesterHalf;
  int? get semesterHalf => _$this._semesterHalf;
  set semesterHalf(int? semesterHalf) => _$this._semesterHalf = semesterHalf;

  String? _className;
  String? get className => _$this._className;
  set className(String? className) => _$this._className = className;

  String? _promotionDecision;
  String? get promotionDecision => _$this._promotionDecision;
  set promotionDecision(String? promotionDecision) =>
      _$this._promotionDecision = promotionDecision;

  double? _gradeAverage;
  double? get gradeAverage => _$this._gradeAverage;
  set gradeAverage(double? gradeAverage) => _$this._gradeAverage = gradeAverage;

  int? _insufficientGradeCount;
  int? get insufficientGradeCount => _$this._insufficientGradeCount;
  set insufficientGradeCount(int? insufficientGradeCount) =>
      _$this._insufficientGradeCount = insufficientGradeCount;

  int? _deficiencyPoints;
  int? get deficiencyPoints => _$this._deficiencyPoints;
  set deficiencyPoints(int? deficiencyPoints) =>
      _$this._deficiencyPoints = deficiencyPoints;

  int? _excusedAbsences;
  int? get excusedAbsences => _$this._excusedAbsences;
  set excusedAbsences(int? excusedAbsences) =>
      _$this._excusedAbsences = excusedAbsences;

  int? _unexcusedAbsences;
  int? get unexcusedAbsences => _$this._unexcusedAbsences;
  set unexcusedAbsences(int? unexcusedAbsences) =>
      _$this._unexcusedAbsences = unexcusedAbsences;

  int? _totalAbsences;
  int? get totalAbsences => _$this._totalAbsences;
  set totalAbsences(int? totalAbsences) =>
      _$this._totalAbsences = totalAbsences;

  ListBuilder<SemesterSubjectGradeDto>? _subjects;
  ListBuilder<SemesterSubjectGradeDto> get subjects =>
      _$this._subjects ??= ListBuilder<SemesterSubjectGradeDto>();
  set subjects(ListBuilder<SemesterSubjectGradeDto>? subjects) =>
      _$this._subjects = subjects;

  SemesterReportDtoBuilder() {
    SemesterReportDto._defaults(this);
  }

  SemesterReportDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _schoolUserId = $v.schoolUserId;
      _programCode = $v.programCode;
      _schoolYearStart = $v.schoolYearStart;
      _semesterHalf = $v.semesterHalf;
      _className = $v.className;
      _promotionDecision = $v.promotionDecision;
      _gradeAverage = $v.gradeAverage;
      _insufficientGradeCount = $v.insufficientGradeCount;
      _deficiencyPoints = $v.deficiencyPoints;
      _excusedAbsences = $v.excusedAbsences;
      _unexcusedAbsences = $v.unexcusedAbsences;
      _totalAbsences = $v.totalAbsences;
      _subjects = $v.subjects?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SemesterReportDto other) {
    _$v = other as _$SemesterReportDto;
  }

  @override
  void update(void Function(SemesterReportDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SemesterReportDto build() => _build();

  _$SemesterReportDto _build() {
    _$SemesterReportDto _$result;
    try {
      _$result =
          _$v ??
          _$SemesterReportDto._(
            id: id,
            schoolUserId: schoolUserId,
            programCode: programCode,
            schoolYearStart: BuiltValueNullFieldError.checkNotNull(
              schoolYearStart,
              r'SemesterReportDto',
              'schoolYearStart',
            ),
            semesterHalf: BuiltValueNullFieldError.checkNotNull(
              semesterHalf,
              r'SemesterReportDto',
              'semesterHalf',
            ),
            className: className,
            promotionDecision: promotionDecision,
            gradeAverage: gradeAverage,
            insufficientGradeCount: insufficientGradeCount,
            deficiencyPoints: deficiencyPoints,
            excusedAbsences: excusedAbsences,
            unexcusedAbsences: unexcusedAbsences,
            totalAbsences: totalAbsences,
            subjects: _subjects?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'subjects';
        _subjects?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SemesterReportDto',
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
