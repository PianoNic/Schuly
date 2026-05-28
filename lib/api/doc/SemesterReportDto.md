# schuly_api.model.SemesterReportDto

## Load the model package
```dart
import 'package:schuly_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | [optional] 
**schoolUserId** | **String** |  | [optional] 
**programCode** | **String** |  | 
**schoolYearStart** | **int** |  | 
**semesterHalf** | **int** |  | 
**className** | **String** |  | 
**promotionDecision** | **String** |  | [optional] 
**gradeAverage** | **double** |  | [optional] 
**insufficientGradeCount** | **int** |  | [optional] 
**deficiencyPoints** | **int** |  | [optional] 
**excusedAbsences** | **int** |  | [optional] 
**unexcusedAbsences** | **int** |  | [optional] 
**totalAbsences** | **int** |  | [optional] 
**subjects** | [**BuiltList&lt;SemesterSubjectGradeDto&gt;**](SemesterSubjectGradeDto.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


