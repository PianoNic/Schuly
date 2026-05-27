import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for PluginsApi
void main() {
  final instance = SchulyApi().getPluginsApi();

  group(PluginsApi, () {
    //Future<BuiltList<PluginDto>> apiPluginsGet() async
    test('test apiPluginsGet', () async {
      // TODO
    });

  });
}
