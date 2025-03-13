import 'dart:convert';
import 'dart:io';

import 'package:dart_server/dart_server.dart' show defaultHost, defaultPort;
import 'package:flutter/material.dart';
import 'package:kobayashi_maru/kobayashi_maru.dart'
    show FederationStarship, Simulator;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';

/// A WebSocket server that serves the simulation data for the Kobayashi Maru simulator.
class KobayashiMaruServer {
  KobayashiMaruServer._({String? host, this.port = defaultPort})
    : host = host ?? defaultHost;

  /// Creates a server without immediately running it.
  KobayashiMaruServer({String? host, int? port})
    : host = host ?? defaultHost,
      port = port ?? defaultPort;

  static final Handler coreHandler = webSocketHandler((webSocket, _) {
    webSocket.stream.listen((message) async {
      print('Received message: $message');

      Map<String, dynamic> messageJSON = messageFromJSON(message);
      print('Message JSON: $messageJSON');

      if (!messageJSON.containsKey('station')) {
        throw ArgumentError('All messages must contain a "station" key');
      }

      String station = messageJSON['station'];
      String response = switch (station.toLowerCase()) {
        'tactical' => await enterprise.tactical.dataHandler(messageJSON),
        // TODO: Handle this case.
        _ =>
          throw UnimplementedError(
            'Handling of data for station "$station" is not yet implemented',
          ),
      };

      // Send the response back to the sender.
      webSocket.sink.add(json.encode({'response': response}));
    });
  });

  static final FederationStarship enterprise = Simulator.enterpriseD;

  final String host;

  final bool internalOnly = false;

  static Map<String, dynamic> messageFromJSON(String message) {
    try {
      return jsonDecode(message);
    } on FormatException {
      throw ArgumentError('message is not a valid JSON.');
    }
  }

  final int port;

  /// Creates a server and immediately starts serving from it.
  static Future<KobayashiMaruServer> serve({
    String host = 'localhost',
    int port = 5678,
  }) async {
    KobayashiMaruServer kmServer = KobayashiMaruServer._(
      host: host,
      port: port,
    );

    await kmServer._startServe();

    return kmServer;
  }

  /// Whether the server is currently serving data.
  bool serving = false;

  // FIXME refactor so server is higher-level than dart:io's HttpServer. Currently crashes when run on web because HttpServer isn't supported on web.
  Future<HttpServer> _startServe() {
    serving = true;
    return shelf_io.serve(coreHandler, host, port).then((server) {
      print('Serving at ws://${server.address.host}:${server.port}');
      return server;
    });
  }

  /// Starts serving with the current configuration.
  void start() => _startServe();

  // TODO add override of toString()
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
  WidgetsFlutterBinding.ensureInitialized();

  await KobayashiMaruServer.serve(host: defaultHost);
}
