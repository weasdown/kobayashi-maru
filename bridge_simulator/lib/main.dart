/// @nodoc
library;

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:window_manager/window_manager.dart';

import 'src/application/bridge.dart';
import 'src/presentation/buttons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.focus();
    });
  }

  runApp(const KobayashiMaru());
}

class KobayashiMaru extends StatelessWidget {
  const KobayashiMaru({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kobayashi Maru',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Home(isServer: false),
    );
  }
}

class Home extends StatefulWidget {
  Home({super.key, required this.isServer}) : channelUri = defaultChannelUri;

  Home.server({super.key, Uri? channelUri, required this.isServer})
    : channelUri = channelUri ?? defaultChannelUri;

  final Uri channelUri;

  WebSocketChannel? connectToServer() =>
  // TODO once connected, set initial simulation state from first stream data.
  WebSocketChannel.connect(channelUri);

  // TODO switch scheme to (secure) 'wss'
  static final defaultChannelUri = Uri(
    scheme: 'ws',
    host: Platform.isWindows ? 'localhost' : '192.168.1.201',
    port: 5678,
  );

  // TODO remove tempWebsocketUri and knownBadUri
  final bool deliberateFail = false;

  // TODO implement usage of iServer: if true, acts as central simulation hub, else shows a user-selected BridgeStation.
  final bool isServer;

  /// The [Bridge] instance used throughout the simulation.
  static Bridge mainBridge = Bridge();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late WebSocketChannel channel;

  // FIXME reconnect after channel close
  void refresh() {
    channel.sink.close();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: Text('Kobayashi Maru'),
        actions: [RefreshButton(onRefresh: refresh)],
      ),
      body: Home.mainBridge.tactical,
      // WebsocketViewer(websocketUri: ServerInterface.channelUri);),
    );
  }
}
