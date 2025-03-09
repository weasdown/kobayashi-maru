/// A WebSocket server written in Dart.
library;

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';

/// Example server, copied from: https://pub.dev/packages/shelf_web_socket
void serverExample() {
  var handler = webSocketHandler((webSocket, _) {
    webSocket.stream.listen((message) {
      webSocket.sink.add('echo $message');
    });
  });

  shelf_io.serve(handler, 'localhost', 8080).then((server) {
    debugPrint('Serving at ws://${server.address.host}:${server.port}');
  });
}
