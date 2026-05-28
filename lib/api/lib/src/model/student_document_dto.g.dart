// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_document_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentDocumentDto extends StudentDocumentDto {
  @override
  final String? id;
  @override
  final String? schoolUserId;
  @override
  final String? title;
  @override
  final String? comment;
  @override
  final String? category;
  @override
  final String? enteredBy;
  @override
  final String? fileName;
  @override
  final int? fileSizeBytes;
  @override
  final String? followUpAction;
  @override
  final Date? followUpDate;
  @override
  final Date? completedDate;
  @override
  final DateTime? notifiedAt;
  @override
  final DateTime? createdAt;

  factory _$StudentDocumentDto([
    void Function(StudentDocumentDtoBuilder)? updates,
  ]) => (StudentDocumentDtoBuilder()..update(updates))._build();

  _$StudentDocumentDto._({
    this.id,
    this.schoolUserId,
    this.title,
    this.comment,
    this.category,
    this.enteredBy,
    this.fileName,
    this.fileSizeBytes,
    this.followUpAction,
    this.followUpDate,
    this.completedDate,
    this.notifiedAt,
    this.createdAt,
  }) : super._();
  @override
  StudentDocumentDto rebuild(
    void Function(StudentDocumentDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StudentDocumentDtoBuilder toBuilder() =>
      StudentDocumentDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentDocumentDto &&
        id == other.id &&
        schoolUserId == other.schoolUserId &&
        title == other.title &&
        comment == other.comment &&
        category == other.category &&
        enteredBy == other.enteredBy &&
        fileName == other.fileName &&
        fileSizeBytes == other.fileSizeBytes &&
        followUpAction == other.followUpAction &&
        followUpDate == other.followUpDate &&
        completedDate == other.completedDate &&
        notifiedAt == other.notifiedAt &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, schoolUserId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, enteredBy.hashCode);
    _$hash = $jc(_$hash, fileName.hashCode);
    _$hash = $jc(_$hash, fileSizeBytes.hashCode);
    _$hash = $jc(_$hash, followUpAction.hashCode);
    _$hash = $jc(_$hash, followUpDate.hashCode);
    _$hash = $jc(_$hash, completedDate.hashCode);
    _$hash = $jc(_$hash, notifiedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentDocumentDto')
          ..add('id', id)
          ..add('schoolUserId', schoolUserId)
          ..add('title', title)
          ..add('comment', comment)
          ..add('category', category)
          ..add('enteredBy', enteredBy)
          ..add('fileName', fileName)
          ..add('fileSizeBytes', fileSizeBytes)
          ..add('followUpAction', followUpAction)
          ..add('followUpDate', followUpDate)
          ..add('completedDate', completedDate)
          ..add('notifiedAt', notifiedAt)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class StudentDocumentDtoBuilder
    implements Builder<StudentDocumentDto, StudentDocumentDtoBuilder> {
  _$StudentDocumentDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _schoolUserId;
  String? get schoolUserId => _$this._schoolUserId;
  set schoolUserId(String? schoolUserId) => _$this._schoolUserId = schoolUserId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _enteredBy;
  String? get enteredBy => _$this._enteredBy;
  set enteredBy(String? enteredBy) => _$this._enteredBy = enteredBy;

  String? _fileName;
  String? get fileName => _$this._fileName;
  set fileName(String? fileName) => _$this._fileName = fileName;

  int? _fileSizeBytes;
  int? get fileSizeBytes => _$this._fileSizeBytes;
  set fileSizeBytes(int? fileSizeBytes) =>
      _$this._fileSizeBytes = fileSizeBytes;

  String? _followUpAction;
  String? get followUpAction => _$this._followUpAction;
  set followUpAction(String? followUpAction) =>
      _$this._followUpAction = followUpAction;

  Date? _followUpDate;
  Date? get followUpDate => _$this._followUpDate;
  set followUpDate(Date? followUpDate) => _$this._followUpDate = followUpDate;

  Date? _completedDate;
  Date? get completedDate => _$this._completedDate;
  set completedDate(Date? completedDate) =>
      _$this._completedDate = completedDate;

  DateTime? _notifiedAt;
  DateTime? get notifiedAt => _$this._notifiedAt;
  set notifiedAt(DateTime? notifiedAt) => _$this._notifiedAt = notifiedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  StudentDocumentDtoBuilder() {
    StudentDocumentDto._defaults(this);
  }

  StudentDocumentDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _schoolUserId = $v.schoolUserId;
      _title = $v.title;
      _comment = $v.comment;
      _category = $v.category;
      _enteredBy = $v.enteredBy;
      _fileName = $v.fileName;
      _fileSizeBytes = $v.fileSizeBytes;
      _followUpAction = $v.followUpAction;
      _followUpDate = $v.followUpDate;
      _completedDate = $v.completedDate;
      _notifiedAt = $v.notifiedAt;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentDocumentDto other) {
    _$v = other as _$StudentDocumentDto;
  }

  @override
  void update(void Function(StudentDocumentDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StudentDocumentDto build() => _build();

  _$StudentDocumentDto _build() {
    final _$result =
        _$v ??
        _$StudentDocumentDto._(
          id: id,
          schoolUserId: schoolUserId,
          title: title,
          comment: comment,
          category: category,
          enteredBy: enteredBy,
          fileName: fileName,
          fileSizeBytes: fileSizeBytes,
          followUpAction: followUpAction,
          followUpDate: followUpDate,
          completedDate: completedDate,
          notifiedAt: notifiedAt,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
