import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for AppApi
void main() {
  final instance = SchulyApi().getAppApi();

  group(AppApi, () {
    //Future<AppDto> apiAppGet() async
    test('test apiAppGet', () async {
      // TODO
    });

    //Future testEndpointWithAuth() async
    test('test testEndpointWithAuth', () async {
      // TODO
    });

  });
}
