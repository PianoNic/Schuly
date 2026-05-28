import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for SemesterReportsApi
void main() {
  final instance = SchulyApi().getSemesterReportsApi();

  group(SemesterReportsApi, () {
    //Future<BuiltList<SemesterReportDto>> apiSemesterReportsGet({ String schoolUserId }) async
    test('test apiSemesterReportsGet', () async {
      // TODO
    });

  });
}
