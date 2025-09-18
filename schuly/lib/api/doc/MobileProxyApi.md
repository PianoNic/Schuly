# openapi.api.MobileProxyApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**mobileAbsencenotices**](MobileProxyApi.md#mobileabsencenotices) | **GET** /api/mobile/absencenotices | Get Mobile Absence Notices
[**mobileAbsencenoticestatus**](MobileProxyApi.md#mobileabsencenoticestatus) | **GET** /api/mobile/absencenoticestatus | Get Mobile Absence Notice Status
[**mobileAbsences**](MobileProxyApi.md#mobileabsences) | **GET** /api/mobile/absences | Get Mobile Absences
[**mobileAgenda**](MobileProxyApi.md#mobileagenda) | **GET** /api/mobile/agenda | Get Mobile Events
[**mobileExams**](MobileProxyApi.md#mobileexams) | **GET** /api/mobile/exams | Get Mobile Exams
[**mobileGrades**](MobileProxyApi.md#mobilegrades) | **GET** /api/mobile/grades | Get Mobile Grades
[**mobileLateness**](MobileProxyApi.md#mobilelateness) | **GET** /api/mobile/lateness | Get Mobile Lateness
[**mobileNotifications**](MobileProxyApi.md#mobilenotifications) | **GET** /api/mobile/notifications | Get Mobile Notifications
[**mobileSettings**](MobileProxyApi.md#mobilesettings) | **GET** /api/mobile/settings | Get Mobile Settings
[**mobileStudentidcardreportId**](MobileProxyApi.md#mobilestudentidcardreportid) | **GET** /api/mobile/studentidcard/{report_id} | Get Mobile Cockpit Report
[**mobileTopics**](MobileProxyApi.md#mobiletopics) | **GET** /api/mobile/topics | Get Mobile Topics
[**mobileUserInfo**](MobileProxyApi.md#mobileuserinfo) | **GET** /api/mobile/userInfo | Get Mobile User Info


# **mobileAbsencenotices**
> List<AbsenceNoticeDto> mobileAbsencenotices()

Get Mobile Absence Notices

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = MobileProxyApi();

try {
    final result = api_instance.mobileAbsencenotices();
    print(result);
} catch (e) {
    print('Exception when calling MobileProxyApi->mobileAbsencenotices: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<AbsenceNoticeDto>**](AbsenceNoticeDto.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mobileAbsencenoticestatus**
> List<AbsenceNoticeStatusDto> mobileAbsencenoticestatus()

Get Mobile Absence Notice Status

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = MobileProxyApi();

try {
    final result = api_instance.mobileAbsencenoticestatus();
    print(result);
} catch (e) {
    print('Exception when calling MobileProxyApi->mobileAbsencenoticestatus: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<AbsenceNoticeStatusDto>**](AbsenceNoticeStatusDto.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mobileAbsences**
> List<AbsenceDto> mobileAbsences()

Get Mobile Absences

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = MobileProxyApi();

try {
    final result = api_instance.mobileAbsences();
    print(result);
} catch (e) {
    print('Exception when calling MobileProxyApi->mobileAbsences: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<AbsenceDto>**](AbsenceDto.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mobileAgenda**
> List<AgendaDto> mobileAgenda(minDate, maxDate)

Get Mobile Events

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = MobileProxyApi();
final minDate = minDate_example; // String | 
final maxDate = maxDate_example; // String | 

try {
    final result = api_instance.mobileAgenda(minDate, maxDate);
    print(result);
} catch (e) {
    print('Exception when calling MobileProxyApi->mobileAgenda: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **minDate** | **String**|  | [optional] 
 **maxDate** | **String**|  | [optional] 

### Return type

[**List<AgendaDto>**](AgendaDto.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mobileExams**
> List<ExamDto> mobileExams()

Get Mobile Exams

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = MobileProxyApi();

try {
    final result = api_instance.mobileExams();
    print(result);
} catch (e) {
    print('Exception when calling MobileProxyApi->mobileExams: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<ExamDto>**](ExamDto.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mobileGrades**
> List<GradeDto> mobileGrades()

Get Mobile Grades

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = MobileProxyApi();

try {
    final result = api_instance.mobileGrades();
    print(result);
} catch (e) {
    print('Exception when calling MobileProxyApi->mobileGrades: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<GradeDto>**](GradeDto.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mobileLateness**
> List<LatenessDto> mobileLateness()

Get Mobile Lateness

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = MobileProxyApi();

try {
    final result = api_instance.mobileLateness();
    print(result);
} catch (e) {
    print('Exception when calling MobileProxyApi->mobileLateness: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<LatenessDto>**](LatenessDto.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mobileNotifications**
> List<Object> mobileNotifications()

Get Mobile Notifications

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = MobileProxyApi();

try {
    final result = api_instance.mobileNotifications();
    print(result);
} catch (e) {
    print('Exception when calling MobileProxyApi->mobileNotifications: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<Object>**](Object.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mobileSettings**
> List<SettingDto> mobileSettings()

Get Mobile Settings

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = MobileProxyApi();

try {
    final result = api_instance.mobileSettings();
    print(result);
} catch (e) {
    print('Exception when calling MobileProxyApi->mobileSettings: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<SettingDto>**](SettingDto.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mobileStudentidcardreportId**
> StudentIdCardDto mobileStudentidcardreportId(reportId)

Get Mobile Cockpit Report

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = MobileProxyApi();
final reportId = 56; // int | 

try {
    final result = api_instance.mobileStudentidcardreportId(reportId);
    print(result);
} catch (e) {
    print('Exception when calling MobileProxyApi->mobileStudentidcardreportId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **reportId** | **int**|  | 

### Return type

[**StudentIdCardDto**](StudentIdCardDto.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mobileTopics**
> List<Object> mobileTopics()

Get Mobile Topics

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = MobileProxyApi();

try {
    final result = api_instance.mobileTopics();
    print(result);
} catch (e) {
    print('Exception when calling MobileProxyApi->mobileTopics: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<Object>**](Object.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mobileUserInfo**
> UserInfoDto mobileUserInfo()

Get Mobile User Info

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = MobileProxyApi();

try {
    final result = api_instance.mobileUserInfo();
    print(result);
} catch (e) {
    print('Exception when calling MobileProxyApi->mobileUserInfo: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UserInfoDto**](UserInfoDto.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

