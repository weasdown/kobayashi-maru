import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../presentation/stations.dart';

/// A client-side interface to the WebSocket connection that enables data to be shared with the simulation server.
class ServerInterface {
  ServerInterface();

  WebSocketChannel channel = openChannel();

  /// The [Uri] that's used to access the [channel].
  // TODO switch scheme to (secure) 'wss'
  static final channelUri = Uri(
    scheme: 'ws',
    host: Platform.isWindows ? 'localhost' : '192.168.1.201',
    port: 5678,
  );

  static WebSocketChannel openChannel() =>
  // TODO once connected, set initial simulation state from first stream data.
  WebSocketChannel.connect(ServerInterface.channelUri);

  void reopenChannel() {
    debugPrint('Refreshing ServerInterface');
    channel.sink.close();
    channel = openChannel();
  }

  void send(BridgeStation station, String message) {
    // TODO remove debugPrint
    message = transmission(station, message);
    debugPrint('Sending message from ${station.name}: $message');
    channel.sink.add(message);
  }

  late Stream stream = channel.stream;

  String transmission(BridgeStation station, String data) =>
      json.encode({'station': station.name, 'data': data});
}

// class ServerInterface extends StatefulWidget {
//   const ServerInterface({super.key});
//
//   /// The [Uri] that's used to access the [channel].
//   // TODO switch schema to (secure) 'wss'
//   static final channelUri = Uri(
//     scheme: 'ws',
//     host: Platform.isWindows ? 'localhost' : '192.168.1.201',
//     port: 5678,
//   );
//
//   @override
//   State<ServerInterface> createState() => ServerInterfaceWidgetState();
// }
//
// class ServerInterfaceWidgetState extends State<ServerInterface> {
//   late WebSocketChannel? channel = openChannel();
//
//   static WebSocketChannel? openChannel() =>
//       WebSocketChannel.connect(ServerInterface.channelUri);
//
//   void refresh() {
//     debugPrint('Refreshing ServerInterfaceWidgetState');
//     channel!.sink.close();
//     channel = openChannel();
//     setState(() {});
//   }
//
//   void send(BridgeStation station, String message) {
//     // TODO remove debugPrint
//     message = transmission(station, message);
//     debugPrint('Sending message from ${station.name}: $message');
//     channel!.sink.add(message);
//   }
//
//   late Stream stream = channel!.stream;
//
//   String transmission(BridgeStation station, String data) =>
//       json.encode({'station': station.name, 'data': data});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
