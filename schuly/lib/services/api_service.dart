import 'package:schuly/api/lib/api.dart';
import 'package:http/http.dart' as http;

class ApiService {
  AuthApi get _authApi => AuthApi();
  MobileProxyApi get _mobileApi => MobileProxyApi();

  Future<http.Response> authenticateWithResponse(String email, String password) {
    return _authApi.authenticateMobileWithHttpInfo(email, password);
  }

  Future<Object?> authenticate(String email, String password) {
    return _authApi.authenticateMobile(email, password);
  }

  Future<List<AbsenceDto>?> getAbsences() {
    return _mobileApi.mobileAbsences();
  }

  Future<List<AgendaDto>?> getAgenda() {
    return _mobileApi.mobileAgenda();
  }

  Future<List<GradeDto>?> getGrades() {
    return _mobileApi.mobileGrades();
  }

  Future<List<Object>?> getNotifications() {
    return _mobileApi.mobileNotifications();
  }

  Future<UserInfoDto?> getUserInfo() {
    return _mobileApi.mobileUserInfo();
  }

  Future<StudentIdCardDto?> getStudentIdCard(int reportId) {
    return _mobileApi.mobileStudentidcardreportId(reportId);
  }

  Future<List<SettingDto>?> getSettings() {
    return _mobileApi.mobileSettings();
  }
}