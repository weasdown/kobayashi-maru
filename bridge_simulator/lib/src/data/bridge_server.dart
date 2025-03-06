import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../presentation/stations.dart';

/// A client-side interface to the WebSocket connection that enables data to be shared with the simulation server.
interface class ServerInterface {
  const ServerInterface();

  /// The [WebSocketChannel] that data is sent across.
  WebSocketChannel? get channel => WebSocketChannel.connect(channelUri);

  /// Sends a [message] to the WebSocket server.
  void send(BridgeStation station, String message) {
    // TODO remove debugPrint
    debugPrint('Sending message from ${station.name}: $message');
    channel!.sink.add(transmission(station, message));
  }

  String transmission(BridgeStation station, String data) =>
      json.encode({'station': station.name, 'data': data});

  /// The [Stream] that provides data from the server.
  Stream get stream => channel!.stream;

  /// The [Uri] that's used to access the [channel].
  // TODO switch schema to (secure) 'wss'
  static final channelUri = Uri(scheme: 'ws', host: 'localhost', port: 5678);
}
