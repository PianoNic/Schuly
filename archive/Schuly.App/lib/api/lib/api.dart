//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/app_api.dart';
part 'api/auth_api.dart';
part 'api/mobile_proxy_api.dart';
part 'api/web_api_api.dart';

part 'model/absence_dto.dart';
part 'model/absence_notice_dto.dart';
part 'model/absence_notice_status_dto.dart';
part 'model/agenda_dto.dart';
part 'model/app_info_dto.dart';
part 'model/authenticate_mobile_response_dto.dart';
part 'model/authenticate_request_dto.dart';
part 'model/class_info_dto.dart';
part 'model/exam_dto.dart';
part 'model/examination_groups_dto.dart';
part 'model/grade_dto.dart';
part 'model/http_validation_error.dart';
part 'model/lateness_dto.dart';
part 'model/mobile_callback_request_dto.dart';
part 'model/mobile_callback_response_dto.dart';
part 'model/mobile_o_auth_url_response_dto.dart';
part 'model/setting_dto.dart';
part 'model/student_id_card_dto.dart';
part 'model/user_info_dto.dart';
part 'model/validation_error.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
