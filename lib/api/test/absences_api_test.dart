import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for AbsencesApi
void main() {
  final instance = SchulyApi().getAbsencesApi();

  group(AbsencesApi, () {
    //Future<BuiltList<AbsenceDto>> apiAbsencesGet() async
    test('test apiAbsencesGet', () async {
      // TODO
    });

    //Future apiAbsencesIdDelete(String id) async
    test('test apiAbsencesIdDelete', () async {
      // TODO
    });

    //Future apiAbsencesPost({ CreateAbsenceCommand createAbsenceCommand }) async
    test('test apiAbsencesPost', () async {
      // TODO
    });

    //Future apiAbsencesPut({ UpdateAbsenceCommand updateAbsenceCommand }) async
    test('test apiAbsencesPut', () async {
      // TODO
    });

    //Future<AbsenceDto> apiAbsencesSearchGet({ String absenceId }) async
    test('test apiAbsencesSearchGet', () async {
      // TODO
    });

  });
}
