# schuly_api.model.SchoolUserDto

## Load the model package
```dart
import 'package:schuly_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | [optional] 
**applicationUserId** | **String** |  | [optional] 
**schoolId** | **String** |  | [optional] 
**schoolName** | **String** |  | [optional] 
**firstName** | **String** |  | 
**lastName** | **String** |  | 
**email** | **String** |  | 
**privateEmail** | **String** |  | [optional] 
**phoneNumber** | **String** |  | [optional] 
**profilePictureUrl** | **String** |  | [optional] 
**street** | **String** |  | [optional] 
**city** | **String** |  | [optional] 
**zip** | **String** |  | [optional] 
**birthday** | [**Date**](Date.md) |  | 
**entryDate** | [**Date**](Date.md) |  | 
**leaveDate** | [**Date**](Date.md) |  | [optional] 
**role** | [**Roles**](Roles.md) |  | 
**state** | [**UserState**](UserState.md) |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | [optional] 
**updatedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**absences** | [**BuiltList&lt;AbsenceDto&gt;**](AbsenceDto.md) |  | [optional] 
**grades** | [**BuiltList&lt;GradeDto&gt;**](GradeDto.md) |  | [optional] 
**classes** | [**BuiltList&lt;UserClassDto&gt;**](UserClassDto.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


