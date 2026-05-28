// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_agenda_entry_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateAgendaEntryCommand extends CreateAgendaEntryCommand {
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
  @override
  final String? schoolId;
  @override
  final String? schoolUserId;

  factory _$CreateAgendaEntryCommand([
    void Function(CreateAgendaEntryCommandBuilder)? updates,
  ]) => (CreateAgendaEntryCommandBuilder()..update(updates))._build();

  _$CreateAgendaEntryCommand._({
    this.entryType,
    this.title,
    this.description,
    this.place,
    this.date,
    this.classId,
    this.schoolId,
    this.schoolUserId,
  }) : super._();
  @override
  CreateAgendaEntryCommand rebuild(
    void Function(CreateAgendaEntryCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateAgendaEntryCommandBuilder toBuilder() =>
      CreateAgendaEntryCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateAgendaEntryCommand &&
        entryType == other.entryType &&
        title == other.title &&
        description == other.description &&
        place == other.place &&
        date == other.date &&
        classId == other.classId &&
        schoolId == other.schoolId &&
        schoolUserId == other.schoolUserId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, entryType.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, place.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, schoolUserId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateAgendaEntryCommand')
          ..add('entryType', entryType)
          ..add('title', title)
          ..add('description', description)
          ..add('place', place)
          ..add('date', date)
          ..add('classId', classId)
          ..add('schoolId', schoolId)
          ..add('schoolUserId', schoolUserId))
        .toString();
  }
}

class CreateAgendaEntryCommandBuilder
    implements
        Builder<CreateAgendaEntryCommand, CreateAgendaEntryCommandBuilder> {
  _$CreateAgendaEntryCommand? _$v;

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

  String? _schoolId;
  String? get schoolId => _$this._schoolId;
  set schoolId(String? schoolId) => _$this._schoolId = schoolId;

  String? _schoolUserId;
  String? get schoolUserId => _$this._schoolUserId;
  set schoolUserId(String? schoolUserId) => _$this._schoolUserId = schoolUserId;

  CreateAgendaEntryCommandBuilder() {
    CreateAgendaEntryCommand._defaults(this);
  }

  CreateAgendaEntryCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _entryType = $v.entryType;
      _title = $v.title;
      _description = $v.description;
      _place = $v.place;
      _date = $v.date;
      _classId = $v.classId;
      _schoolId = $v.schoolId;
      _schoolUserId = $v.schoolUserId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateAgendaEntryCommand other) {
    _$v = other as _$CreateAgendaEntryCommand;
  }

  @override
  void update(void Function(CreateAgendaEntryCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateAgendaEntryCommand build() => _build();

  _$CreateAgendaEntryCommand _build() {
    final _$result =
        _$v ??
        _$CreateAgendaEntryCommand._(
          entryType: entryType,
          title: title,
          description: description,
          place: place,
          date: date,
          classId: classId,
          schoolId: schoolId,
          schoolUserId: schoolUserId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
