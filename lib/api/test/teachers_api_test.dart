import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for TeachersApi
void main() {
  final instance = SchulyApi().getTeachersApi();

  group(TeachersApi, () {
    //Future<BuiltList<TeacherDto>> apiTeachersGet() async
    test('test apiTeachersGet', () async {
      // TODO
    });

    //Future apiTeachersIdDelete(String id) async
    test('test apiTeachersIdDelete', () async {
      // TODO
    });

    //Future<TeacherDto> apiTeachersIdGet(String id) async
    test('test apiTeachersIdGet', () async {
      // TODO
    });

    //Future<String> apiTeachersPost({ CreateTeacherCommand createTeacherCommand }) async
    test('test apiTeachersPost', () async {
      // TODO
    });

    //Future apiTeachersPut({ UpdateTeacherCommand updateTeacherCommand }) async
    test('test apiTeachersPut', () async {
      // TODO
    });

  });
}
