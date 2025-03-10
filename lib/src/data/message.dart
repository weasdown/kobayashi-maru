import 'dart:convert';

import '../../main.dart';
import '../presentation/stations.dart';

/// A message sent to the WebSocket server.
final class Message {
  Message({required this.data, required this.station});

  Message.send({required this.data, required this.station}) {
    send();
  }

  final String data;

  final BridgeStation station;

  late Response response;

  String get transmission =>
      json.encode({'station': station.name, 'data': data});

  void send() {
    channel.sink.add(transmission);
  }
}

/// Information received back from the WebSocket server after sending it a [Message].
final class Response {}
