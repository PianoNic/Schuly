//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class MobileProxyApi {
  MobileProxyApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get Mobile Absence Notices
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> mobileAbsencenoticesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/mobile/absencenotices';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Mobile Absence Notices
  Future<List<AbsenceNoticeDto>?> mobileAbsencenotices() async {
    final response = await mobileAbsencenoticesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<AbsenceNoticeDto>') as List)
        .cast<AbsenceNoticeDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// Get Mobile Absence Notice Status
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> mobileAbsencenoticestatusWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/mobile/absencenoticestatus';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Mobile Absence Notice Status
  Future<List<AbsenceNoticeStatusDto>?> mobileAbsencenoticestatus() async {
    final response = await mobileAbsencenoticestatusWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<AbsenceNoticeStatusDto>') as List)
        .cast<AbsenceNoticeStatusDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// Get Mobile Absences
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> mobileAbsencesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/mobile/absences';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Mobile Absences
  Future<List<AbsenceDto>?> mobileAbsences() async {
    final response = await mobileAbsencesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<AbsenceDto>') as List)
        .cast<AbsenceDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// Get Mobile Events
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] minDate:
  ///
  /// * [String] maxDate:
  Future<Response> mobileAgendaWithHttpInfo({ String? minDate, String? maxDate, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/mobile/agenda';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (minDate != null) {
      queryParams.addAll(_queryParams('', 'min_date', minDate));
    }
    if (maxDate != null) {
      queryParams.addAll(_queryParams('', 'max_date', maxDate));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Mobile Events
  ///
  /// Parameters:
  ///
  /// * [String] minDate:
  ///
  /// * [String] maxDate:
  Future<List<AgendaDto>?> mobileAgenda({ String? minDate, String? maxDate, }) async {
    final response = await mobileAgendaWithHttpInfo( minDate: minDate, maxDate: maxDate, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<AgendaDto>') as List)
        .cast<AgendaDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// Get Mobile Exams
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> mobileExamsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/mobile/exams';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Mobile Exams
  Future<List<ExamDto>?> mobileExams() async {
    final response = await mobileExamsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<ExamDto>') as List)
        .cast<ExamDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// Get Mobile Grades
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> mobileGradesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/mobile/grades';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Mobile Grades
  Future<List<GradeDto>?> mobileGrades() async {
    final response = await mobileGradesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<GradeDto>') as List)
        .cast<GradeDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// Get Mobile Lateness
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> mobileLatenessWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/mobile/lateness';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Mobile Lateness
  Future<List<LatenessDto>?> mobileLateness() async {
    final response = await mobileLatenessWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<LatenessDto>') as List)
        .cast<LatenessDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// Get Mobile Notifications
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> mobileNotificationsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/mobile/notifications';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Mobile Notifications
  Future<List<Object>?> mobileNotifications() async {
    final response = await mobileNotificationsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Object>') as List)
        .cast<Object>()
        .toList(growable: false);

    }
    return null;
  }

  /// Get Mobile Settings
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> mobileSettingsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/mobile/settings';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Mobile Settings
  Future<List<SettingDto>?> mobileSettings() async {
    final response = await mobileSettingsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<SettingDto>') as List)
        .cast<SettingDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// Get Mobile Cockpit Report
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] reportId (required):
  Future<Response> mobileStudentidcardreportIdWithHttpInfo(int reportId,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/mobile/studentidcard/{report_id}'
      .replaceAll('{report_id}', reportId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Mobile Cockpit Report
  ///
  /// Parameters:
  ///
  /// * [int] reportId (required):
  Future<StudentIdCardDto?> mobileStudentidcardreportId(int reportId,) async {
    final response = await mobileStudentidcardreportIdWithHttpInfo(reportId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StudentIdCardDto',) as StudentIdCardDto;
    
    }
    return null;
  }

  /// Get Mobile Topics
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> mobileTopicsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/mobile/topics';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Mobile Topics
  Future<List<Object>?> mobileTopics() async {
    final response = await mobileTopicsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Object>') as List)
        .cast<Object>()
        .toList(growable: false);

    }
    return null;
  }

  /// Get Mobile User Info
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> mobileUserInfoWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/mobile/userInfo';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Mobile User Info
  Future<UserInfoDto?> mobileUserInfo() async {
    final response = await mobileUserInfoWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserInfoDto',) as UserInfoDto;
    
    }
    return null;
  }
}
