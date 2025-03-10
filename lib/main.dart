import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:window_manager/window_manager.dart';

import 'server_connection_details.dart';
import 'src/application/ship.dart';
import 'src/presentation/scaffold.dart';
import 'src/presentation/server.dart';
import 'src/presentation/stations.dart';

WebSocketChannel channel = WebSocketChannel.connect(channelUri);

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

  runApp(Home(station: BridgeStation.tactical));
}

class Home extends StatefulWidget {
  Home({super.key, required BridgeStation station})
    : isServer = false,
      onConnected = station;

  // // TODO implement usage of Home.server: if called, acts as central simulation hub, as opposed to a user-selected BridgeStation for Home().
  // Home.server({super.key, Uri? channelUri})
  //   : isServer = true,
  //     channelUri = channelUri ?? defaultChannelUri,
  //     onConnected = Server();

  final FederationStarship ship = FederationStarship(
    registry: 'NCC-1701-D',
    name: 'USS Enterprise',
  );

  // TODO remove tempWebsocketUri and knownBadUri
  final bool deliberateFail = false;

  final bool isServer;

  final Widget onConnected;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  (String, Widget) active(AsyncSnapshot snapshot) => (
    snapshot.data,
    Text(
      snapshot.data,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.headlineSmall,
    ),
  );

  late Stream stream = channel.stream;

  Widget connect() {
    if (widget.isServer) {
      return Server();
    } else {
      // TODO once connected, set initial simulation state from first stream data.
      debugPrint('\nConnecting to server at $channelUri...');
      return FutureBuilder(
        future: channel.ready,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return (snapshot.hasError)
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: text(
                    '${snapshot.error.runtimeType}: Connection could not be opened '
                    'to WebSocket server at ${channelUri.toString()}',
                  ),
                )
                : () {
                  debugPrint(
                    '\t- Connected. Returning Widget onConnected...\n',
                  );
                  return widget.onConnected;
                }();
          } else {
            return Center(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  children: [
                    text('Connecting to server...'),
                    Gap(30),
                    LinearProgressIndicator(),
                  ],
                ),
              ),
            );
          }
        },
      );
    }
  }

  // FIXME reconnect after channel close
  void refresh() {
    debugPrint('Refreshing... (_HomeState.refresh)');
    channel.sink.close(1000);
    setState(() {});
  }

  Text text(String toDisplay) => Text(
    toDisplay,
    textAlign: TextAlign.center,
    style: Theme.of(
      context,
    ).textTheme.headlineSmall!.copyWith(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kobayashi Maru',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        // Recommended by the migration guide for Slider changes in Flutter 3.29 (https://docs.flutter.dev/release/breaking-changes/updated-material-3-slider#migration-guide)
        // ignore: deprecated_member_use
        sliderTheme: const SliderThemeData(year2023: false),
      ),
      home: DefaultScaffold(onRefresh: refresh, body: connect()),
    );
  }
}
