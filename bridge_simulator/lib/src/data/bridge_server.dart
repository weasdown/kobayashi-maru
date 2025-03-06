import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../presentation/stations.dart';

/// A client-side interface to the WebSocket connection that enables data to be shared with the simulation server.
class ServerInterface extends StatefulWidget {
  ServerInterface({super.key})
    : channel = WebSocketChannel.connect(channelUri) {
    stream = channel!.stream;
  }

  @override
  State<ServerInterface> createState() => ServerInterfaceWidgetState();

  late final WebSocketChannel? channel;

  /// The [Uri] that's used to access the [channel].
  // TODO switch schema to (secure) 'wss'
  static final channelUri = Uri(scheme: 'ws', host: 'localhost', port: 5678);

  void send(BridgeStation station, String message) {
    // TODO remove debugPrint
    debugPrint('Sending message from ${station.name}: $message');
    channel!.sink.add(transmission(station, message));
  }

  late final Stream stream;

  String transmission(BridgeStation station, String data) =>
      json.encode({'station': station.name, 'data': data});
}

class ServerInterfaceWidgetState extends State<ServerInterface> {
  void refresh() {
    widget.channel!.sink.close();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
