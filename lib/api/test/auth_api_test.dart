import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for AuthApi
void main() {
  final instance = SchulyApi().getAuthApi();

  group(AuthApi, () {
    //Future<ApplicationUserDto> apiAuthMeGet() async
    test('test apiAuthMeGet', () async {
      // TODO
    });

    //Future apiAuthSyncGet() async
    test('test apiAuthSyncGet', () async {
      // TODO
    });

  });
}
