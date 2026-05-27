// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradeDto extends GradeDto {
  @override
  final String? id;
  @override
  final double? score;
  @override
  final double? weighting;
  @override
  final String? examId;
  @override
  final String? schoolUserId;

  factory _$GradeDto([void Function(GradeDtoBuilder)? updates]) =>
      (GradeDtoBuilder()..update(updates))._build();

  _$GradeDto._({
    this.id,
    this.score,
    this.weighting,
    this.examId,
    this.schoolUserId,
  }) : super._();
  @override
  GradeDto rebuild(void Function(GradeDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GradeDtoBuilder toBuilder() => GradeDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradeDto &&
        id == other.id &&
        score == other.score &&
        weighting == other.weighting &&
        examId == other.examId &&
        schoolUserId == other.schoolUserId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, weighting.hashCode);
    _$hash = $jc(_$hash, examId.hashCode);
    _$hash = $jc(_$hash, schoolUserId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GradeDto')
          ..add('id', id)
          ..add('score', score)
          ..add('weighting', weighting)
          ..add('examId', examId)
          ..add('schoolUserId', schoolUserId))
        .toString();
  }
}

class GradeDtoBuilder implements Builder<GradeDto, GradeDtoBuilder> {
  _$GradeDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  double? _score;
  double? get score => _$this._score;
  set score(double? score) => _$this._score = score;

  double? _weighting;
  double? get weighting => _$this._weighting;
  set weighting(double? weighting) => _$this._weighting = weighting;

  String? _examId;
  String? get examId => _$this._examId;
  set examId(String? examId) => _$this._examId = examId;

  String? _schoolUserId;
  String? get schoolUserId => _$this._schoolUserId;
  set schoolUserId(String? schoolUserId) => _$this._schoolUserId = schoolUserId;

  GradeDtoBuilder() {
    GradeDto._defaults(this);
  }

  GradeDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _score = $v.score;
      _weighting = $v.weighting;
      _examId = $v.examId;
      _schoolUserId = $v.schoolUserId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradeDto other) {
    _$v = other as _$GradeDto;
  }

  @override
  void update(void Function(GradeDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradeDto build() => _build();

  _$GradeDto _build() {
    final _$result =
        _$v ??
        _$GradeDto._(
          id: id,
          score: score,
          weighting: weighting,
          examId: examId,
          schoolUserId: schoolUserId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
