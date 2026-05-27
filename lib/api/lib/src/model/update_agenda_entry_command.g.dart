// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_agenda_entry_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateAgendaEntryCommand extends UpdateAgendaEntryCommand {
  @override
  final String? agendaEntryId;
  @override
  final AgendaEntryType? entryType;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? place;
  @override
  final DateTime? date;
  @override
  final String? classId;

  factory _$UpdateAgendaEntryCommand([
    void Function(UpdateAgendaEntryCommandBuilder)? updates,
  ]) => (UpdateAgendaEntryCommandBuilder()..update(updates))._build();

  _$UpdateAgendaEntryCommand._({
    this.agendaEntryId,
    this.entryType,
    this.title,
    this.description,
    this.place,
    this.date,
    this.classId,
  }) : super._();
  @override
  UpdateAgendaEntryCommand rebuild(
    void Function(UpdateAgendaEntryCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateAgendaEntryCommandBuilder toBuilder() =>
      UpdateAgendaEntryCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateAgendaEntryCommand &&
        agendaEntryId == other.agendaEntryId &&
        entryType == other.entryType &&
        title == other.title &&
        description == other.description &&
        place == other.place &&
        date == other.date &&
        classId == other.classId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, agendaEntryId.hashCode);
    _$hash = $jc(_$hash, entryType.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, place.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateAgendaEntryCommand')
          ..add('agendaEntryId', agendaEntryId)
          ..add('entryType', entryType)
          ..add('title', title)
          ..add('description', description)
          ..add('place', place)
          ..add('date', date)
          ..add('classId', classId))
        .toString();
  }
}

class UpdateAgendaEntryCommandBuilder
    implements
        Builder<UpdateAgendaEntryCommand, UpdateAgendaEntryCommandBuilder> {
  _$UpdateAgendaEntryCommand? _$v;

  String? _agendaEntryId;
  String? get agendaEntryId => _$this._agendaEntryId;
  set agendaEntryId(String? agendaEntryId) =>
      _$this._agendaEntryId = agendaEntryId;

  AgendaEntryType? _entryType;
  AgendaEntryType? get entryType => _$this._entryType;
  set entryType(AgendaEntryType? entryType) => _$this._entryType = entryType;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _place;
  String? get place => _$this._place;
  set place(String? place) => _$this._place = place;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  String? _classId;
  String? get classId => _$this._classId;
  set classId(String? classId) => _$this._classId = classId;

  UpdateAgendaEntryCommandBuilder() {
    UpdateAgendaEntryCommand._defaults(this);
  }

  UpdateAgendaEntryCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agendaEntryId = $v.agendaEntryId;
      _entryType = $v.entryType;
      _title = $v.title;
      _description = $v.description;
      _place = $v.place;
      _date = $v.date;
      _classId = $v.classId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateAgendaEntryCommand other) {
    _$v = other as _$UpdateAgendaEntryCommand;
  }

  @override
  void update(void Function(UpdateAgendaEntryCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateAgendaEntryCommand build() => _build();

  _$UpdateAgendaEntryCommand _build() {
    final _$result =
        _$v ??
        _$UpdateAgendaEntryCommand._(
          agendaEntryId: agendaEntryId,
          entryType: entryType,
          title: title,
          description: description,
          place: place,
          date: date,
          classId: classId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
