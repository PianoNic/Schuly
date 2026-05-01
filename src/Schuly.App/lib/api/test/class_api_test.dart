import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for ClassApi
void main() {
  final instance = SchulyApi().getClassApi();

  group(ClassApi, () {
    //Future apiClassEnrolStudentPost({ EnrolStudentCommand enrolStudentCommand }) async
    test('test apiClassEnrolStudentPost', () async {
      // TODO
    });

    //Future<BuiltList<ClassDto>> apiClassGet() async
    test('test apiClassGet', () async {
      // TODO
    });

    //Future apiClassIdDelete(String id) async
    test('test apiClassIdDelete', () async {
      // TODO
    });

    //Future apiClassPost({ CreateClassCommand createClassCommand }) async
    test('test apiClassPost', () async {
      // TODO
    });

    //Future apiClassPut({ UpdateClassCommand updateClassCommand }) async
    test('test apiClassPut', () async {
      // TODO
    });

    //Future<ClassDto> apiClassSearchGet({ String classId }) async
    test('test apiClassSearchGet', () async {
      // TODO
    });

  });
}
