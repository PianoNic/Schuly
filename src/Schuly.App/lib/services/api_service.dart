import 'package:schuly/api/lib/api.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

class ApiService {
  AuthApi get _authApi => AuthApi();
  MobileProxyApi get _mobileApi => MobileProxyApi();

  // Performance monitoring helper
  Future<T> _withPerformanceMonitoring<T>({
    required String operationName,
    required String description,
    required Future<T> Function() operation,
    Map<String, dynamic>? data,
  }) async {
    final transaction = Sentry.startTransaction(
      operationName,
      'http.client',
    );

    transaction.setData('description', description);
    if (data != null) {
      data.forEach((key, value) => transaction.setData(key, value));
    }

    try {
      final result = await operation();
      transaction.status = const SpanStatus.ok();
      return result;
    } catch (e) {
      transaction.status = const SpanStatus.internalError();
      transaction.throwable = e;
      rethrow;
    } finally {
      await transaction.finish();
    }
  }

  Future<http.Response> authenticateWithResponse(String email, String password) {
    return _withPerformanceMonitoring(
      operationName: 'authenticate.non_microsoft',
      description: 'Non-Microsoft authentication',
      data: {'email': email},
      operation: () => _authApi.authenticateMobileWithHttpInfo(email, password).timeout(Duration(minutes: 1)),
    );
  }

  Future<AuthenticateMobileResponseDto?> authenticate(String email, String password) {
    return _withPerformanceMonitoring(
      operationName: 'authenticate.mobile',
      description: 'Mobile authentication',
      data: {'email': email},
      operation: () => _authApi.authenticateMobile(email, password),
    );
  }

  Future<List<AbsenceDto>?> getAbsences() {
    return _withPerformanceMonitoring(
      operationName: 'api.get_absences',
      description: 'Fetch absences',
      operation: () => _mobileApi.mobileAbsences(),
    );
  }

  Future<List<AgendaDto>?> getAgenda() {
    return _withPerformanceMonitoring(
      operationName: 'api.get_agenda',
      description: 'Fetch agenda',
      operation: () => _mobileApi.mobileAgenda(),
    );
  }

  Future<List<GradeDto>?> getGrades() {
    return _withPerformanceMonitoring(
      operationName: 'api.get_grades',
      description: 'Fetch grades',
      operation: () => _mobileApi.mobileGrades(),
    );
  }

  Future<List<ExamDto>?> getExams() {
    return _withPerformanceMonitoring(
      operationName: 'api.get_exams',
      description: 'Fetch exams',
      operation: () => _mobileApi.mobileExams(),
    );
  }

  Future<List<Object>?> getNotifications() {
    return _withPerformanceMonitoring(
      operationName: 'api.get_notifications',
      description: 'Fetch notifications',
      operation: () => _mobileApi.mobileNotifications(),
    );
  }

  Future<UserInfoDto?> getUserInfo() {
    return _withPerformanceMonitoring(
      operationName: 'api.get_user_info',
      description: 'Fetch user info',
      operation: () => _mobileApi.mobileUserInfo(),
    );
  }

  Future<StudentIdCardDto?> getStudentIdCard(int reportId) {
    return _withPerformanceMonitoring(
      operationName: 'api.get_student_id_card',
      description: 'Fetch student ID card',
      data: {'report_id': reportId},
      operation: () => _mobileApi.mobileStudentidcardreportId(reportId),
    );
  }

  Future<List<SettingDto>?> getSettings() {
    return _withPerformanceMonitoring(
      operationName: 'api.get_settings',
      description: 'Fetch settings',
      operation: () => _mobileApi.mobileSettings(),
    );
  }

  Future<List<LatenessDto>?> getLateness() {
    return _withPerformanceMonitoring(
      operationName: 'api.get_lateness',
      description: 'Fetch lateness',
      operation: () => _mobileApi.mobileLateness(),
    );
  }

  Future<List<Object>?> getAbsenceNotices() {
    return _withPerformanceMonitoring(
      operationName: 'api.get_absence_notices',
      description: 'Fetch absence notices',
      operation: () => _mobileApi.mobileAbsencenotices(),
    );
  }
}