import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketViewer extends StatelessWidget {
  const WebsocketViewer({super.key, required this.websocketUri});

  final Uri websocketUri;

  // TODO remove tempWebsocketUri and knownBadUri
  final bool deliberateFail = false;

  @override
  Widget build(BuildContext context) {
    Text text(toDisplay) => Text(
      toDisplay,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge,
    );

    (String, Widget) loading() => (
      'Loading...',
      FractionallySizedBox(widthFactor: 0.5, child: LinearProgressIndicator()),
    );

    (String, Widget) activeOrDone(AsyncSnapshot snapshot) {
      String message =
          (snapshot.connectionState == ConnectionState.done)
              ? 'Connection to server has closed. Final data: ${snapshot.data}'
              : (snapshot.hasData)
              ? snapshot.data
              : 'Very unexpected state!';

      return (message, text(message));
    }

    (String, Widget) error(AsyncSnapshot snapshot) {
      dynamic error = snapshot.error;

      String message;

      if (error is WebSocketChannelException) {
        message =
            'Connection could not be opened to WebSocket server at ${websocketUri.toString()}';
        return (message, text(message));
      } else {
        message = 'snapshot has an unrecognised error:\n\n$error';
        return (message, ErrorWidget(error));
      }
    }

    final Uri knownBadUri = Uri(
      scheme: websocketUri.scheme,
      host: websocketUri.host,
      port: 1234,
    );

    final Uri serverUri = deliberateFail ? knownBadUri : websocketUri;

    late final WebSocketChannel channel;

    channel = WebSocketChannel.connect(serverUri);

    return Scaffold(
      appBar: AppBar(elevation: 20, title: Text('WebSocket Viewer')),
      body: ListView(
        shrinkWrap: true,
        children: [
          Gap(32),
          FractionallySizedBox(
            widthFactor: 0.75,
            child: StreamBuilder(
              stream: channel.stream,
              initialData: 'Connecting to the WebSocket server...',
              builder: (context, snapshot) {
                late String message;
                late Widget content;

                (message, content) =
                    (snapshot.hasError)
                        ? error(snapshot)
                        : switch (snapshot.connectionState) {
                          ConnectionState.waiting ||
                          ConnectionState.none => loading(),
                          ConnectionState.active || ConnectionState.done =>
                            (message, content) = activeOrDone(snapshot),
                        };

                debugPrint(message);
                return content;
              },
            ),
          ),
        ],
      ),
    );
  }
}
