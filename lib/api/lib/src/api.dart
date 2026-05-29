//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';
import 'package:schuly_api/src/serializers.dart';
import 'package:schuly_api/src/auth/api_key_auth.dart';
import 'package:schuly_api/src/auth/basic_auth.dart';
import 'package:schuly_api/src/auth/bearer_auth.dart';
import 'package:schuly_api/src/auth/oauth.dart';
import 'package:schuly_api/src/api/absences_api.dart';
import 'package:schuly_api/src/api/accounts_api.dart';
import 'package:schuly_api/src/api/agendas_api.dart';
import 'package:schuly_api/src/api/app_api.dart';
import 'package:schuly_api/src/api/application_users_api.dart';
import 'package:schuly_api/src/api/auth_api.dart';
import 'package:schuly_api/src/api/avatars_api.dart';
import 'package:schuly_api/src/api/class_api.dart';
import 'package:schuly_api/src/api/exams_api.dart';
import 'package:schuly_api/src/api/o_auth_api.dart';
import 'package:schuly_api/src/api/plugins_api.dart';
import 'package:schuly_api/src/api/school_users_api.dart';
import 'package:schuly_api/src/api/schools_api.dart';
import 'package:schuly_api/src/api/semester_reports_api.dart';
import 'package:schuly_api/src/api/status_api.dart';
import 'package:schuly_api/src/api/student_documents_api.dart';
import 'package:schuly_api/src/api/sync_api.dart';
import 'package:schuly_api/src/api/teachers_api.dart';

class SchulyApi {
  static const String basePath = r'http://localhost';

  final Dio dio;
  final Serializers serializers;

  SchulyApi({
    Dio? dio,
    Serializers? serializers,
    String? basePathOverride,
    List<Interceptor>? interceptors,
  })  : this.serializers = serializers ?? standardSerializers,
        this.dio = dio ??
            Dio(BaseOptions(
              baseUrl: basePathOverride ?? basePath,
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            )) {
    if (interceptors == null) {
      this.dio.interceptors.addAll([
        OAuthInterceptor(),
        BasicAuthInterceptor(),
        BearerAuthInterceptor(),
        ApiKeyAuthInterceptor(),
      ]);
    } else {
      this.dio.interceptors.addAll(interceptors);
    }
  }

  void setOAuthToken(String name, String token) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is OAuthInterceptor) as OAuthInterceptor).tokens[name] = token;
    }
  }

  void setBearerAuth(String name, String token) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BearerAuthInterceptor) as BearerAuthInterceptor).tokens[name] = token;
    }
  }

  void setBasicAuth(String name, String username, String password) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BasicAuthInterceptor) as BasicAuthInterceptor).authInfo[name] = BasicAuthInfo(username, password);
    }
  }

  void setApiKey(String name, String apiKey) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((element) => element is ApiKeyAuthInterceptor) as ApiKeyAuthInterceptor).apiKeys[name] = apiKey;
    }
  }

  /// Get AbsencesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AbsencesApi getAbsencesApi() {
    return AbsencesApi(dio, serializers);
  }

  /// Get AccountsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AccountsApi getAccountsApi() {
    return AccountsApi(dio, serializers);
  }

  /// Get AgendasApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AgendasApi getAgendasApi() {
    return AgendasApi(dio, serializers);
  }

  /// Get AppApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AppApi getAppApi() {
    return AppApi(dio, serializers);
  }

  /// Get ApplicationUsersApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ApplicationUsersApi getApplicationUsersApi() {
    return ApplicationUsersApi(dio, serializers);
  }

  /// Get AuthApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AuthApi getAuthApi() {
    return AuthApi(dio, serializers);
  }

  /// Get AvatarsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AvatarsApi getAvatarsApi() {
    return AvatarsApi(dio, serializers);
  }

  /// Get ClassApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ClassApi getClassApi() {
    return ClassApi(dio, serializers);
  }

  /// Get ExamsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ExamsApi getExamsApi() {
    return ExamsApi(dio, serializers);
  }

  /// Get OAuthApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  OAuthApi getOAuthApi() {
    return OAuthApi(dio, serializers);
  }

  /// Get PluginsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PluginsApi getPluginsApi() {
    return PluginsApi(dio, serializers);
  }

  /// Get SchoolUsersApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SchoolUsersApi getSchoolUsersApi() {
    return SchoolUsersApi(dio, serializers);
  }

  /// Get SchoolsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SchoolsApi getSchoolsApi() {
    return SchoolsApi(dio, serializers);
  }

  /// Get SemesterReportsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SemesterReportsApi getSemesterReportsApi() {
    return SemesterReportsApi(dio, serializers);
  }

  /// Get StatusApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  StatusApi getStatusApi() {
    return StatusApi(dio, serializers);
  }

  /// Get StudentDocumentsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  StudentDocumentsApi getStudentDocumentsApi() {
    return StudentDocumentsApi(dio, serializers);
  }

  /// Get SyncApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SyncApi getSyncApi() {
    return SyncApi(dio, serializers);
  }

  /// Get TeachersApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TeachersApi getTeachersApi() {
    return TeachersApi(dio, serializers);
  }
}
