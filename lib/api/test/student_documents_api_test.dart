import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for StudentDocumentsApi
void main() {
  final instance = SchulyApi().getStudentDocumentsApi();

  group(StudentDocumentsApi, () {
    //Future apiDocumentsDocumentIdGet(String documentId) async
    test('test apiDocumentsDocumentIdGet', () async {
      // TODO
    });

    //Future apiStudentsSchoolUserIdDocumentsPost(String schoolUserId, { MultipartFile file, String title, String comment, String category, String enteredBy, String followUpAction, Date followUpDate }) async
    test('test apiStudentsSchoolUserIdDocumentsPost', () async {
      // TODO
    });

  });
}
