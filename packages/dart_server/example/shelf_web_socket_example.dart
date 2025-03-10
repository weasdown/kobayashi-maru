/// A WebSocket python_server written in Dart.
library;

import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';

/// Example python_server, copied from: https://pub.dev/packages/shelf_web_socket
void main() {
  var handler = webSocketHandler((webSocket, _) {
    webSocket.stream.listen((message) {
      webSocket.sink.add(message);
    });
  });

  shelf_io.serve(handler, 'localhost', 8080).then((server) {
    print('Serving at ws://${server.address.host}:${server.port}');
  });
}
