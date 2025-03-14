import 'dart:developer' as dev;

import 'package:dart_server/dart_server.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:window_manager/window_manager.dart';

import 'audio/audio_controller.dart';
import 'src/application/bridge_station.dart';
import 'src/application/ship.dart';
import 'src/application/simulator.dart';
import 'src/presentation/presentation.dart';
import 'src/presentation/views/server.dart';

WebSocketChannel channel = WebSocketChannel.connect(channelUri);

final Simulator simulator = Simulator();

void main() async {
  // The `flutter_soloud` package logs everything
  // (from severe warnings to fine debug messages)
  // using the standard `package:logging`.
  // You can listen to the logs as shown below.
  Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
  Logger.root.onRecord.listen((record) {
    dev.log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });

  WidgetsFlutterBinding.ensureInitialized();

  final audioController = AudioController();
  await audioController.initialize();

  if (UniversalPlatform.isWindows) {
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

  runApp(
    MyApp(audioController: audioController, station: BridgeStation.tactical),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    required this.station,
    required this.audioController,
    super.key,
  });

  final AudioController audioController;
  final BridgeStation station;

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
      home: Home(station: station, audioController: audioController),
    );
  }
}

class Home extends StatefulWidget {
  Home({
    super.key,
    required BridgeStation station,
    required this.audioController,
  }) : isServer = false,
       onConnected = station.widget;

  // // TODO implement usage of Home.server: if called, acts as central simulation hub, as opposed to a user-selected BridgeStation for Home().
  // Home.server({super.key, Uri? channelUri})
  //   : isServer = true,
  //     channelUri = channelUri ?? defaultChannelUri,
  //     onConnected = Server();

  final AudioController audioController;

  final FederationStarship ship = FederationStarship(
    registry: 'NCC-1701-D',
    name: 'USS Enterprise',
  );

  // TODO remove tempWebsocketUri and knownBadUri
  final bool deliberateFail = false;

  final bool isServer;

  final Widget onConnected;

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
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
    channel = WebSocketChannel.connect(channelUri);
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
    return DefaultScaffold(onRefresh: refresh, body: connect());
  }
}
