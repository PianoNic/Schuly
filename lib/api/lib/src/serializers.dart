//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:schuly_api/src/date_serializer.dart';
import 'package:schuly_api/src/model/date.dart';

import 'package:schuly_api/src/model/absence_dto.dart';
import 'package:schuly_api/src/model/absence_type.dart';
import 'package:schuly_api/src/model/add_grade_to_exam_command.dart';
import 'package:schuly_api/src/model/agenda_entry_dto.dart';
import 'package:schuly_api/src/model/agenda_entry_type.dart';
import 'package:schuly_api/src/model/app_dto.dart';
import 'package:schuly_api/src/model/application_user_dto.dart';
import 'package:schuly_api/src/model/class_dto.dart';
import 'package:schuly_api/src/model/connect_account_request.dart';
import 'package:schuly_api/src/model/create_absence_command.dart';
import 'package:schuly_api/src/model/create_agenda_entry_command.dart';
import 'package:schuly_api/src/model/create_application_user_command.dart';
import 'package:schuly_api/src/model/create_class_command.dart';
import 'package:schuly_api/src/model/create_exam_command.dart';
import 'package:schuly_api/src/model/create_school_command.dart';
import 'package:schuly_api/src/model/create_school_user_command.dart';
import 'package:schuly_api/src/model/create_teacher_command.dart';
import 'package:schuly_api/src/model/enrol_student_command.dart';
import 'package:schuly_api/src/model/exam_dto.dart';
import 'package:schuly_api/src/model/exam_type.dart';
import 'package:schuly_api/src/model/grade_dto.dart';
import 'package:schuly_api/src/model/my_school_dto.dart';
import 'package:schuly_api/src/model/o_auth_callback_request.dart';
import 'package:schuly_api/src/model/plugin_dto.dart';
import 'package:schuly_api/src/model/problem_details.dart';
import 'package:schuly_api/src/model/roles.dart';
import 'package:schuly_api/src/model/school_dto.dart';
import 'package:schuly_api/src/model/school_user_dto.dart';
import 'package:schuly_api/src/model/school_user_summary_dto.dart';
import 'package:schuly_api/src/model/semester_report_dto.dart';
import 'package:schuly_api/src/model/semester_subject_grade_dto.dart';
import 'package:schuly_api/src/model/student_document_dto.dart';
import 'package:schuly_api/src/model/teacher_dto.dart';
import 'package:schuly_api/src/model/update_absence_command.dart';
import 'package:schuly_api/src/model/update_agenda_entry_command.dart';
import 'package:schuly_api/src/model/update_application_user_command.dart';
import 'package:schuly_api/src/model/update_class_command.dart';
import 'package:schuly_api/src/model/update_exam_command.dart';
import 'package:schuly_api/src/model/update_school_command.dart';
import 'package:schuly_api/src/model/update_school_user_command.dart';
import 'package:schuly_api/src/model/update_teacher_command.dart';
import 'package:schuly_api/src/model/user_class_dto.dart';
import 'package:schuly_api/src/model/user_state.dart';

part 'serializers.g.dart';

@SerializersFor([
  AbsenceDto,
  AbsenceType,
  AddGradeToExamCommand,
  AgendaEntryDto,
  AgendaEntryType,
  AppDto,
  ApplicationUserDto,
  ClassDto,
  ConnectAccountRequest,
  CreateAbsenceCommand,
  CreateAgendaEntryCommand,
  CreateApplicationUserCommand,
  CreateClassCommand,
  CreateExamCommand,
  CreateSchoolCommand,
  CreateSchoolUserCommand,
  CreateTeacherCommand,
  EnrolStudentCommand,
  ExamDto,
  ExamType,
  GradeDto,
  MySchoolDto,
  OAuthCallbackRequest,
  PluginDto,
  ProblemDetails,
  Roles,
  SchoolDto,
  SchoolUserDto,
  SchoolUserSummaryDto,
  SemesterReportDto,
  SemesterSubjectGradeDto,
  StudentDocumentDto,
  TeacherDto,
  UpdateAbsenceCommand,
  UpdateAgendaEntryCommand,
  UpdateApplicationUserCommand,
  UpdateClassCommand,
  UpdateExamCommand,
  UpdateSchoolCommand,
  UpdateSchoolUserCommand,
  UpdateTeacherCommand,
  UserClassDto,
  UserState,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ExamDto)]),
        () => ListBuilder<ExamDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(PluginDto)]),
        () => ListBuilder<PluginDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(SchoolUserDto)]),
        () => ListBuilder<SchoolUserDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AbsenceDto)]),
        () => ListBuilder<AbsenceDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ApplicationUserDto)]),
        () => ListBuilder<ApplicationUserDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(SchoolDto)]),
        () => ListBuilder<SchoolDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(StudentDocumentDto)]),
        () => ListBuilder<StudentDocumentDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(MySchoolDto)]),
        () => ListBuilder<MySchoolDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(SemesterReportDto)]),
        () => ListBuilder<SemesterReportDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TeacherDto)]),
        () => ListBuilder<TeacherDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ClassDto)]),
        () => ListBuilder<ClassDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AgendaEntryDto)]),
        () => ListBuilder<AgendaEntryDto>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
