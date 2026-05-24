// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ClassDto extends ClassDto {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? schoolId;
  @override
  final String? schoolName;
  @override
  final BuiltList<SchoolUserDto>? students;
  @override
  final BuiltList<AgendaEntryDto>? agenda;
  @override
  final BuiltList<ExamDto>? exams;

  factory _$ClassDto([void Function(ClassDtoBuilder)? updates]) =>
      (ClassDtoBuilder()..update(updates))._build();

  _$ClassDto._(
      {this.id,
      this.name,
      this.description,
      this.schoolId,
      this.schoolName,
      this.students,
      this.agenda,
      this.exams})
      : super._();
  @override
  ClassDto rebuild(void Function(ClassDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClassDtoBuilder toBuilder() => ClassDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClassDto &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        schoolId == other.schoolId &&
        schoolName == other.schoolName &&
        students == other.students &&
        agenda == other.agenda &&
        exams == other.exams;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, schoolName.hashCode);
    _$hash = $jc(_$hash, students.hashCode);
    _$hash = $jc(_$hash, agenda.hashCode);
    _$hash = $jc(_$hash, exams.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClassDto')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('schoolId', schoolId)
          ..add('schoolName', schoolName)
          ..add('students', students)
          ..add('agenda', agenda)
          ..add('exams', exams))
        .toString();
  }
}

class ClassDtoBuilder implements Builder<ClassDto, ClassDtoBuilder> {
  _$ClassDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _schoolId;
  String? get schoolId => _$this._schoolId;
  set schoolId(String? schoolId) => _$this._schoolId = schoolId;

  String? _schoolName;
  String? get schoolName => _$this._schoolName;
  set schoolName(String? schoolName) => _$this._schoolName = schoolName;

  ListBuilder<SchoolUserDto>? _students;
  ListBuilder<SchoolUserDto> get students =>
      _$this._students ??= ListBuilder<SchoolUserDto>();
  set students(ListBuilder<SchoolUserDto>? students) =>
      _$this._students = students;

  ListBuilder<AgendaEntryDto>? _agenda;
  ListBuilder<AgendaEntryDto> get agenda =>
      _$this._agenda ??= ListBuilder<AgendaEntryDto>();
  set agenda(ListBuilder<AgendaEntryDto>? agenda) => _$this._agenda = agenda;

  ListBuilder<ExamDto>? _exams;
  ListBuilder<ExamDto> get exams => _$this._exams ??= ListBuilder<ExamDto>();
  set exams(ListBuilder<ExamDto>? exams) => _$this._exams = exams;

  ClassDtoBuilder() {
    ClassDto._defaults(this);
  }

  ClassDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _schoolId = $v.schoolId;
      _schoolName = $v.schoolName;
      _students = $v.students?.toBuilder();
      _agenda = $v.agenda?.toBuilder();
      _exams = $v.exams?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClassDto other) {
    _$v = other as _$ClassDto;
  }

  @override
  void update(void Function(ClassDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClassDto build() => _build();

  _$ClassDto _build() {
    _$ClassDto _$result;
    try {
      _$result = _$v ??
          _$ClassDto._(
            id: id,
            name: name,
            description: description,
            schoolId: schoolId,
            schoolName: schoolName,
            students: _students?.build(),
            agenda: _agenda?.build(),
            exams: _exams?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'students';
        _students?.build();
        _$failedField = 'agenda';
        _agenda?.build();
        _$failedField = 'exams';
        _exams?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ClassDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
