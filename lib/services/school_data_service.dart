import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:schuly_api/schuly_api.dart';

import 'active_account_service.dart';
import 'api_client.dart';

/// Loads and caches the per-school data the UI renders: the signed-in user's
/// SchoolUser record (with nested grades/absences/classes), plus the school's
/// exams and agenda. Everything is filtered to [ActiveAccountService.active].
///
/// The backend scopes responses to the authenticated user but doesn't filter
/// by school, so we filter by `schoolId` client-side.
class SchoolDataService extends ChangeNotifier {
  SchoolDataService._();
  static final SchoolDataService instance = SchoolDataService._();

  SchoolUserDto? _me;
  List<ExamDto> _exams = const [];
  List<AgendaEntryDto> _agenda = const [];
  List<AbsenceDto> _absences = const [];
  List<ClassDto> _classes = const [];
  bool _loading = false;
  Object? _error;

  SchoolUserDto? get me => _me;
  List<ExamDto> get exams => _exams;
  List<AgendaEntryDto> get agenda => _agenda;
  List<AbsenceDto> get absences => _absences;
  List<ClassDto> get classes => _classes;
  bool get loading => _loading;
  Object? get error => _error;

  /// Friendly class name by class id, from the full ClassDto.
  Map<String, String> get classNameById {
    final out = <String, String>{};
    for (final c in _classes) {
      if (c.id != null && (c.name?.isNotEmpty ?? false)) out[c.id!] = c.name!;
    }
    return out;
  }

  SchulyApi get _api => ApiClient.instance.api;

  /// My grades for the active school, keyed by examId.
  Map<String, GradeDto> get myGradesByExam {
    final out = <String, GradeDto>{};
    final grades = _me?.grades;
    if (grades != null) {
      for (final g in grades) {
        if (g.examId != null) out[g.examId!] = g;
      }
    }
    return out;
  }

  Future<void> refresh() async {
    final schoolId = ActiveAccountService.instance.active?.id;
    if (schoolId == null) {
      _me = null;
      _exams = const [];
      _agenda = const [];
      _absences = const [];
      notifyListeners();
      return;
    }

    _loading = true;
    _error = null;
    notifyListeners();
    try {
      // Who am I → my SchoolUser for this school (carries nested grades etc.).
      final me = await _api.getAuthApi().apiAuthMeGet();
      final appUserId = me.data?.id;
      if (appUserId != null) {
        final users = await _api
            .getSchoolUsersApi()
            .apiSchoolUsersGet(applicationUserId: appUserId);
        _me = (users.data ?? BuiltList<SchoolUserDto>())
            .where((u) => u.schoolId == schoolId)
            .cast<SchoolUserDto?>()
            .firstWhere((_) => true, orElse: () => null);
      }

      final exams = await _api.getExamsApi().apiExamsGet();
      _exams = (exams.data ?? BuiltList<ExamDto>())
          .where((e) => e.schoolId == schoolId)
          .toList(growable: false);

      final agenda = await _api.getAgendasApi().apiAgendasGet();
      _agenda = (agenda.data ?? BuiltList<AgendaEntryDto>())
          .where((a) => a.schoolId == schoolId)
          .toList(growable: false);

      final absences = await _api.getAbsencesApi().apiAbsencesGet();
      _absences = (absences.data ?? BuiltList<AbsenceDto>())
          .where((a) => a.schoolId == schoolId)
          .toList(growable: false);

      final classes = await _api.getClassApi().apiClassGet();
      _classes = (classes.data ?? BuiltList<ClassDto>())
          .where((c) => c.schoolId == schoolId)
          .toList(growable: false);
    } catch (e) {
      _error = e;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void clear() {
    _me = null;
    _exams = const [];
    _agenda = const [];
    _absences = const [];
    _classes = const [];
    _error = null;
    notifyListeners();
  }
}
