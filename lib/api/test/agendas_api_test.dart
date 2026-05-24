import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for AgendasApi
void main() {
  final instance = SchulyApi().getAgendasApi();

  group(AgendasApi, () {
    //Future<BuiltList<AgendaEntryDto>> apiAgendasGet() async
    test('test apiAgendasGet', () async {
      // TODO
    });

    //Future apiAgendasIdDelete(String id) async
    test('test apiAgendasIdDelete', () async {
      // TODO
    });

    //Future apiAgendasPost({ CreateAgendaEntryCommand createAgendaEntryCommand }) async
    test('test apiAgendasPost', () async {
      // TODO
    });

    //Future apiAgendasPut({ UpdateAgendaEntryCommand updateAgendaEntryCommand }) async
    test('test apiAgendasPut', () async {
      // TODO
    });

    //Future<AgendaEntryDto> apiAgendasSearchGet({ String agendaEntryId }) async
    test('test apiAgendasSearchGet', () async {
      // TODO
    });

  });
}
