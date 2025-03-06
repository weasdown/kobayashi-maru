import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

/// A client-side interface to the WebSocket connection that enables data to be shared with the simulation server.
interface class ServerInterface {
  const ServerInterface();

  /// The [WebSocketChannel] that data is sent across.
  WebSocketChannel? get channel => WebSocketChannel.connect(channelUri);

  /// Send a [message] to the WebSocket server.
  void send(String message) => channel!.sink.add(message);

  /// The [Stream] that provides data from the server.
  Stream get stream => channel!.stream;

  /// The [Uri] that's used to access the [channel].
  // TODO switch schema to (secure) 'wss'
  static final channelUri = Uri(scheme: 'ws', host: 'localhost', port: 5678);
}
