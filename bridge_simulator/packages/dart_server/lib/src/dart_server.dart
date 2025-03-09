/// A WebSocket server written in Dart.
library;

import 'dart:io';

import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';

class KobayashiMaruServer {
  KobayashiMaruServer._({this.host = 'localhost', this.port = 5678});

  // TODO refactor so server is higher-level than dart:io's HttpServer.
  Future<HttpServer> _serve() =>
      shelf_io.serve(handler, host, port).then((server) {
        print('Serving at ws://${server.address.host}:${server.port}');
        return server;
      });

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

  static final handler = webSocketHandler((webSocket, _) {
    webSocket.stream.listen((message) {
      print('Received message: $message');
      webSocket.sink.add(message);
    });
  });

  final String host;

  final int port;
}

void main() async {
  await KobayashiMaruServer.serve();
}
