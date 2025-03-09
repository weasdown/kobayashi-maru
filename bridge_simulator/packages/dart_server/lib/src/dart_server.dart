/// A WebSocket server written in Dart.
library;

import 'dart:io';

import 'package:bridge_simulator/bridge_simulator.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';

class KobayashiMaruServer {
  KobayashiMaruServer._({String? host, this.port = serverPort})
    : host = host ?? serverHost;

  // TODO refactor so server is higher-level than dart:io's HttpServer.
  Future<HttpServer> _serve() =>
      shelf_io.serve(handler, host, port).then((server) {
        print('Serving at ws://${server.address.host}:${server.port}');
        return server;
      });

  static final FederationStarship enterprise = enterpriseD;

  static Future<KobayashiMaruServer> serve({
    String host = 'localhost',
    int port = 5678,
  }) async {
    KobayashiMaruServer kmServer = KobayashiMaruServer._(
      host: host,
      port: port,
    );

    await kmServer._serve();

    return kmServer;
  }

  static final Handler handler = webSocketHandler((webSocket, _) {
    webSocket.stream.listen((message) {
      print('Received message: $message');
      webSocket.sink.add(message);
    });
  });

  static Map<String, dynamic> messageFromJSON(String message) {
    try {
      return jsonDecode(message);
    } on FormatException {
      rethrow;
    }
  }

  final String host;

  final int port;
}

/// A function that processes data received from a client.
final class DataHandler {
  DataHandler({required this.function});

  /// Runs the [DataHandler] on some [data].
  Future<String> call(Map<String, dynamic> data) async {
    if (!data.containsKey('data')) {
      throw ArgumentError(
        'data JSON does not contain the required "data" key.',
      );
    }
    return await function(data);
  }

  Future<String> Function(Map<String, dynamic>) function;
}

void main() async {
  await KobayashiMaruServer.serve();
}
