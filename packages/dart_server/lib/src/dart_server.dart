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
    : host = host ?? defaultHost,
      isServing = false;

  /// Creates a server without immediately running it.
  KobayashiMaruServer({String? host, this.port = defaultPort})
    : host = host ?? defaultHost,
      isServing = false;

  /// Gets info about the number of clients currently connected to the [_server].
  HttpConnectionsInfo? get connections => _server?.connectionsInfo();

  static final Handler coreHandler = webSocketHandler(
    (webSocket, _) {
      webSocket.stream.listen((message) async {
        debugPrint('Received message: $message');

        Map<String, dynamic> messageJSON = messageFromJSON(message);
        debugPrint('Message JSON: $messageJSON');

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
    },
    // FIXME use pingInterval or similar correctly to check whether connection still open.
    pingInterval: Duration(milliseconds: 500),
  );

  static final FederationStarship enterprise = Simulator.enterpriseD;

  final String host;

  final bool internalOnly = false;

  /// Whether the server is currently serving data.
  bool isServing;

  static Map<String, dynamic> messageFromJSON(String message) {
    try {
      return jsonDecode(message);
    } on FormatException {
      throw ArgumentError('message is not a valid JSON.');
    }
  }

  final int port;

  HttpServer? _server;

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

  final Simulator simulator = Simulator();

  // FIXME refactor so server is higher-level than dart:io's HttpServer. Currently crashes when run on web because HttpServer isn't supported on web.
  Future<HttpServer> _startServe() async {
    isServing = true;
    _server = await shelf_io.serve(coreHandler, host, port).then((server) {
      print('Serving at ws://${server.address.host}:${server.port}');
      return server;
    });

    return _server!;
  }

  /// Starts serving with the current configuration.
  void start() => _startServe();

  // FIXME close all channels as well.
  /// Stops serving any data to clients.
  Future<dynamic> stop() async {
    dynamic result = await _server!.close(force: true);
    debugPrint('\nResult of closing server: ${result.toString()}');
    if (result is ServerSocket) {
      debugPrint('\t- result is a ServerSocket.');
    }

    _server = null;
    isServing = false;

    // debugPrint('Server closed'); // TODO uncomment this line once proper closing implemented.
    return result;
  }

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
