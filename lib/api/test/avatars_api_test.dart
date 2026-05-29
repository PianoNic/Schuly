import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for AvatarsApi
void main() {
  final instance = SchulyApi().getAvatarsApi();

  group(AvatarsApi, () {
    //Future apiAvatarsSchoolUserIdGet(String schoolUserId, { int exp, String sig }) async
    test('test apiAvatarsSchoolUserIdGet', () async {
      // TODO
    });

  });
}
