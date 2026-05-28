// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AbsenceDto extends AbsenceDto {
  @override
  final String? id;
  @override
  final String? reason;
  @override
  final AbsenceType type;
  @override
  final DateTime from;
  @override
  final DateTime until;
  @override
  final String? schoolUserId;
  @override
  final String? schoolId;

  factory _$AbsenceDto([void Function(AbsenceDtoBuilder)? updates]) =>
      (AbsenceDtoBuilder()..update(updates))._build();

  _$AbsenceDto._({
    this.id,
    this.reason,
    required this.type,
    required this.from,
    required this.until,
    this.schoolUserId,
    this.schoolId,
  }) : super._();
  @override
  AbsenceDto rebuild(void Function(AbsenceDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AbsenceDtoBuilder toBuilder() => AbsenceDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AbsenceDto &&
        id == other.id &&
        reason == other.reason &&
        type == other.type &&
        from == other.from &&
        until == other.until &&
        schoolUserId == other.schoolUserId &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, until.hashCode);
    _$hash = $jc(_$hash, schoolUserId.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AbsenceDto')
          ..add('id', id)
          ..add('reason', reason)
          ..add('type', type)
          ..add('from', from)
          ..add('until', until)
          ..add('schoolUserId', schoolUserId)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class AbsenceDtoBuilder implements Builder<AbsenceDto, AbsenceDtoBuilder> {
  _$AbsenceDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  AbsenceType? _type;
  AbsenceType? get type => _$this._type;
  set type(AbsenceType? type) => _$this._type = type;

  DateTime? _from;
  DateTime? get from => _$this._from;
  set from(DateTime? from) => _$this._from = from;

  DateTime? _until;
  DateTime? get until => _$this._until;
  set until(DateTime? until) => _$this._until = until;

  String? _schoolUserId;
  String? get schoolUserId => _$this._schoolUserId;
  set schoolUserId(String? schoolUserId) => _$this._schoolUserId = schoolUserId;

  String? _schoolId;
  String? get schoolId => _$this._schoolId;
  set schoolId(String? schoolId) => _$this._schoolId = schoolId;

  AbsenceDtoBuilder() {
    AbsenceDto._defaults(this);
  }

  AbsenceDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _reason = $v.reason;
      _type = $v.type;
      _from = $v.from;
      _until = $v.until;
      _schoolUserId = $v.schoolUserId;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AbsenceDto other) {
    _$v = other as _$AbsenceDto;
  }

  @override
  void update(void Function(AbsenceDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AbsenceDto build() => _build();

  _$AbsenceDto _build() {
    final _$result =
        _$v ??
        _$AbsenceDto._(
          id: id,
          reason: reason,
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'AbsenceDto',
            'type',
          ),
          from: BuiltValueNullFieldError.checkNotNull(
            from,
            r'AbsenceDto',
            'from',
          ),
          until: BuiltValueNullFieldError.checkNotNull(
            until,
            r'AbsenceDto',
            'until',
          ),
          schoolUserId: schoolUserId,
          schoolId: schoolId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
