import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for SchoolsApi
void main() {
  final instance = SchulyApi().getSchoolsApi();

  group(SchoolsApi, () {
    //Future<BuiltList<SchoolDto>> apiSchoolsGet() async
    test('test apiSchoolsGet', () async {
      // TODO
    });

    //Future apiSchoolsIdDelete(String id) async
    test('test apiSchoolsIdDelete', () async {
      // TODO
    });

    //Future<SchoolDto> apiSchoolsIdGet(String id) async
    test('test apiSchoolsIdGet', () async {
      // TODO
    });

    //Future<BuiltList<SchoolDto>> apiSchoolsMySchoolsGet() async
    test('test apiSchoolsMySchoolsGet', () async {
      // TODO
    });

    //Future<String> apiSchoolsPost({ CreateSchoolCommand createSchoolCommand }) async
    test('test apiSchoolsPost', () async {
      // TODO
    });

    //Future apiSchoolsPut({ UpdateSchoolCommand updateSchoolCommand }) async
    test('test apiSchoolsPut', () async {
      // TODO
    });

  });
}
