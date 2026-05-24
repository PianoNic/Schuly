// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_absence_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateAbsenceCommand extends CreateAbsenceCommand {
  @override
  final String? reason;
  @override
  final AbsenceType? type;
  @override
  final DateTime? from;
  @override
  final DateTime? until;
  @override
  final String? schoolUserId;

  factory _$CreateAbsenceCommand(
          [void Function(CreateAbsenceCommandBuilder)? updates]) =>
      (CreateAbsenceCommandBuilder()..update(updates))._build();

  _$CreateAbsenceCommand._(
      {this.reason, this.type, this.from, this.until, this.schoolUserId})
      : super._();
  @override
  CreateAbsenceCommand rebuild(
          void Function(CreateAbsenceCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateAbsenceCommandBuilder toBuilder() =>
      CreateAbsenceCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateAbsenceCommand &&
        reason == other.reason &&
        type == other.type &&
        from == other.from &&
        until == other.until &&
        schoolUserId == other.schoolUserId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, until.hashCode);
    _$hash = $jc(_$hash, schoolUserId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateAbsenceCommand')
          ..add('reason', reason)
          ..add('type', type)
          ..add('from', from)
          ..add('until', until)
          ..add('schoolUserId', schoolUserId))
        .toString();
  }
}

class CreateAbsenceCommandBuilder
    implements Builder<CreateAbsenceCommand, CreateAbsenceCommandBuilder> {
  _$CreateAbsenceCommand? _$v;

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

  CreateAbsenceCommandBuilder() {
    CreateAbsenceCommand._defaults(this);
  }

  CreateAbsenceCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _type = $v.type;
      _from = $v.from;
      _until = $v.until;
      _schoolUserId = $v.schoolUserId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateAbsenceCommand other) {
    _$v = other as _$CreateAbsenceCommand;
  }

  @override
  void update(void Function(CreateAbsenceCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateAbsenceCommand build() => _build();

  _$CreateAbsenceCommand _build() {
    final _$result = _$v ??
        _$CreateAbsenceCommand._(
          reason: reason,
          type: type,
          from: from,
          until: until,
          schoolUserId: schoolUserId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
