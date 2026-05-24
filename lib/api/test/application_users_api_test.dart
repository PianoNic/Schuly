import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for ApplicationUsersApi
void main() {
  final instance = SchulyApi().getApplicationUsersApi();

  group(ApplicationUsersApi, () {
    //Future<BuiltList<ApplicationUserDto>> apiApplicationUsersGet() async
    test('test apiApplicationUsersGet', () async {
      // TODO
    });

    //Future apiApplicationUsersIdDelete(String id) async
    test('test apiApplicationUsersIdDelete', () async {
      // TODO
    });

    //Future<ApplicationUserDto> apiApplicationUsersIdGet(String id) async
    test('test apiApplicationUsersIdGet', () async {
      // TODO
    });

    //Future<String> apiApplicationUsersPost({ CreateApplicationUserCommand createApplicationUserCommand }) async
    test('test apiApplicationUsersPost', () async {
      // TODO
    });

    //Future apiApplicationUsersPut({ UpdateApplicationUserCommand updateApplicationUserCommand }) async
    test('test apiApplicationUsersPut', () async {
      // TODO
    });

  });
}
