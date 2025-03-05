import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketViewer extends StatelessWidget {
  const WebsocketViewer({super.key, required this.websocketUri});

  final Uri websocketUri;

  final bool deliberateFail = false;

  @override
  Widget build(BuildContext context) {
    Widget content() {
      late final WebSocketChannel channel;

      // TODO remove tempWebsocketUri and deliberateFail
      Uri tempWebsocketUri = Uri(
        scheme: websocketUri.scheme,
        host: websocketUri.host,
        port: 1234,
      );
      channel = WebSocketChannel.connect(
        deliberateFail ? tempWebsocketUri : websocketUri,
      );

      return StreamBuilder(
        stream: channel.stream,
        initialData: 'Connecting to the WebSocket server...',
        builder: (context, snapshot) {
          String message;

          message = 'snapshot.connectionState: ${snapshot.connectionState}';
          if (snapshot.connectionState == ConnectionState.waiting) {
            message = 'Waiting for data';
          }

          if (snapshot.hasData) {
            message = snapshot.data;
          } else if (snapshot.hasError) {
            dynamic error = snapshot.error;
            if (error is WebSocketChannelException) {
              message =
                  'Connection could not be opened to WebSocket server at ${websocketUri.toString()}';
            } else {
              message = 'snapshot has an unrecognised error:\n\n$error';
            }
          } else {
            message = 'Very unexpected state!';
          }

          debugPrint(message);
          return Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('WebSocket Viewer')),
      body: ListView(
        shrinkWrap: true,
        children: [FractionallySizedBox(widthFactor: 0.75, child: content())],
      ),
    );
  }
}
