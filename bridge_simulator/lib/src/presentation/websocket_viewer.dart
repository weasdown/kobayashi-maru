import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketViewer extends StatefulWidget {
  const WebsocketViewer({super.key, required this.websocketUri});

  final Uri websocketUri;

  @override
  State<WebsocketViewer> createState() => _WebsocketViewerState();
}

class _WebsocketViewerState extends State<WebsocketViewer> {
  // TODO remove tempWebsocketUri and knownBadUri
  final bool deliberateFail = false;

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    Text text(String toDisplay) => Text(
      toDisplay,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineSmall,
    );

    Widget textWithLoadingCircle(String toDisplay) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [text(toDisplay), Gap(50), CircularProgressIndicator()],
    );

    (String, Widget) loading() => (
      'Loading...',
      textWithLoadingCircle('Getting data from channel'),
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
            'Connection could not be opened to WebSocket server at ${widget.websocketUri.toString()}';
        return (message, text(message));
      } else {
        message = 'snapshot has an unrecognised error:\n\n$error';
        return (message, ErrorWidget(error));
      }
    }

    final Uri knownBadUri = Uri(
      scheme: widget.websocketUri.scheme,
      host: widget.websocketUri.host,
      port: 1234,
    );

    final Uri serverUri = deliberateFail ? knownBadUri : widget.websocketUri;

    Future<WebSocketChannel> connectToChannel(Uri server) async =>
        WebSocketChannel.connect(serverUri);

    fbNoneOrWaiting() => textWithLoadingCircle('Connecting to channel...');

    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: Text('WebSocket Viewer'),
        actions: [IconButton(onPressed: _refresh, icon: Icon(Symbols.refresh))],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Gap(50),
          FutureBuilder(
            future: Future.wait<Object>([
              Future<bool>.delayed(Duration(milliseconds: 600), () => true),
              connectToChannel(serverUri),
            ]),
            builder: (context, fbSnapshot) {
              return switch (fbSnapshot.connectionState) {
                ConnectionState.none ||
                ConnectionState.waiting ||
                ConnectionState.active => fbNoneOrWaiting(),

                ConnectionState.done => () {
                  WebSocketChannel channel =
                      (fbSnapshot.data)![1] as WebSocketChannel;

                  return FractionallySizedBox(
                    widthFactor: 0.75,
                    child: StreamBuilder(
                      stream: channel.stream,
                      builder: (context, snapshot) {
                        late String message;
                        late Widget content;

                        (message, content) =
                            (snapshot.hasError)
                                ? error(snapshot)
                                : switch (snapshot.connectionState) {
                                  ConnectionState.waiting ||
                                  ConnectionState.none => loading(),
                                  ConnectionState.active ||
                                  ConnectionState.done =>
                                    (message, content) = activeOrDone(snapshot),
                                };

                        debugPrint(message);
                        return content;
                      },
                    ),
                  );
                }(),
              };
            },
          ),
        ],
      ),
    );
  }
}
