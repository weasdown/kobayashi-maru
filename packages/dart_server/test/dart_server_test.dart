import 'package:dart_server/dart_server.dart';
import 'package:test/test.dart';

void main() {
  group('server creation without serving', () {
    final KobayashiMaruServer server = KobayashiMaruServer();

    setUp(() {
      // Additional setup goes here.
    });

    test('default host', () {
      expect(server.host, defaultHost);
    });

    test('default port', () {
      expect(server.port, defaultPort);
    });
  });
}
