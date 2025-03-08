/// @nodoc
library;

import 'package:flutter/material.dart';
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
      home: const Home(isServer: false),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.isServer});

  // TODO implement usage of iServer: if true, acts as central simulation hub, else shows a user-selected BridgeStation.
  final bool isServer;

  /// The [Bridge] instance used throughout the simulation.
  static Bridge mainBridge = Bridge();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
