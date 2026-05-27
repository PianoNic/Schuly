// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda_entry_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AgendaEntryDto extends AgendaEntryDto {
  @override
  final String? id;
  @override
  final AgendaEntryType entryType;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? place;
  @override
  final DateTime date;
  @override
  final String? classId;

  factory _$AgendaEntryDto([void Function(AgendaEntryDtoBuilder)? updates]) =>
      (AgendaEntryDtoBuilder()..update(updates))._build();

  _$AgendaEntryDto._({
    this.id,
    required this.entryType,
    this.title,
    this.description,
    this.place,
    required this.date,
    this.classId,
  }) : super._();
  @override
  AgendaEntryDto rebuild(void Function(AgendaEntryDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AgendaEntryDtoBuilder toBuilder() => AgendaEntryDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AgendaEntryDto &&
        id == other.id &&
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
    _$hash = $jc(_$hash, id.hashCode);
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
    return (newBuiltValueToStringHelper(r'AgendaEntryDto')
          ..add('id', id)
          ..add('entryType', entryType)
          ..add('title', title)
          ..add('description', description)
          ..add('place', place)
          ..add('date', date)
          ..add('classId', classId))
        .toString();
  }
}

class AgendaEntryDtoBuilder
    implements Builder<AgendaEntryDto, AgendaEntryDtoBuilder> {
  _$AgendaEntryDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

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

  AgendaEntryDtoBuilder() {
    AgendaEntryDto._defaults(this);
  }

  AgendaEntryDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
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
  void replace(AgendaEntryDto other) {
    _$v = other as _$AgendaEntryDto;
  }

  @override
  void update(void Function(AgendaEntryDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AgendaEntryDto build() => _build();

  _$AgendaEntryDto _build() {
    final _$result =
        _$v ??
        _$AgendaEntryDto._(
          id: id,
          entryType: BuiltValueNullFieldError.checkNotNull(
            entryType,
            r'AgendaEntryDto',
            'entryType',
          ),
          title: title,
          description: description,
          place: place,
          date: BuiltValueNullFieldError.checkNotNull(
            date,
            r'AgendaEntryDto',
            'date',
          ),
          classId: classId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
