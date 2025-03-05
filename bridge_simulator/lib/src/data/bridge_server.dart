import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

final Uri webSocketServer = Uri(scheme: 'ws', host: 'localhost', port: 5678);

/// A client-side interface to the WebSocket connection that enables data to be shared with the simulation server.
interface class ServerInterface {
  const ServerInterface({required this.channel});

  /// The [WebSocketChannel] that data is sent across.
  final WebSocketChannel channel;

  /// Send a [message] to the WebSocket server.
  void send(String message) => channel.sink.add(message);

  /// The [Stream] that provides data from the server.
  Stream get stream => channel.stream;
}
