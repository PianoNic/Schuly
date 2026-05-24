import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for SchoolUsersApi
void main() {
  final instance = SchulyApi().getSchoolUsersApi();

  group(SchoolUsersApi, () {
    //Future<BuiltList<SchoolUserDto>> apiSchoolUsersGet({ String applicationUserId }) async
    test('test apiSchoolUsersGet', () async {
      // TODO
    });

    //Future apiSchoolUsersIdDelete(String id) async
    test('test apiSchoolUsersIdDelete', () async {
      // TODO
    });

    //Future<SchoolUserDto> apiSchoolUsersIdGet(String id) async
    test('test apiSchoolUsersIdGet', () async {
      // TODO
    });

    //Future<String> apiSchoolUsersPost({ CreateSchoolUserCommand createSchoolUserCommand }) async
    test('test apiSchoolUsersPost', () async {
      // TODO
    });

    //Future apiSchoolUsersPut({ UpdateSchoolUserCommand updateSchoolUserCommand }) async
    test('test apiSchoolUsersPut', () async {
      // TODO
    });

  });
}
