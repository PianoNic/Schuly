import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for ExamsApi
void main() {
  final instance = SchulyApi().getExamsApi();

  group(ExamsApi, () {
    //Future<BuiltList<ExamDto>> apiExamsGet() async
    test('test apiExamsGet', () async {
      // TODO
    });

    //Future apiExamsGradePost({ AddGradeToExamCommand addGradeToExamCommand }) async
    test('test apiExamsGradePost', () async {
      // TODO
    });

    //Future apiExamsIdDelete(String id) async
    test('test apiExamsIdDelete', () async {
      // TODO
    });

    //Future apiExamsPost({ CreateExamCommand createExamCommand }) async
    test('test apiExamsPost', () async {
      // TODO
    });

    //Future apiExamsPut({ UpdateExamCommand updateExamCommand }) async
    test('test apiExamsPut', () async {
      // TODO
    });

    //Future<ExamDto> apiExamsSearchGet({ String examId }) async
    test('test apiExamsSearchGet', () async {
      // TODO
    });

  });
}
