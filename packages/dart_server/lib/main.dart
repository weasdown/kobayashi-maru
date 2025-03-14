import 'dart:io';

import 'package:dart_server/dart_server.dart';
import 'package:dart_server/src/sim_state/sim_state_view.dart';
import 'package:flutter/material.dart';
import 'package:minisound/engine.dart' as minisound;
import 'package:gap/gap.dart';

final minisound.Engine engine = minisound.Engine();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kobayashi Maru Server',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: KobayashiMaruServerView(),
    );
  }
}

class KobayashiMaruServerView extends StatefulWidget {
  KobayashiMaruServerView({super.key});

  final KobayashiMaruServer server = KobayashiMaruServer();

  @override
  State<KobayashiMaruServerView> createState() =>
      _KobayashiMaruServerViewState();
}

class _KobayashiMaruServerViewState extends State<KobayashiMaruServerView> {
  late final KobayashiMaruServer server = widget.server;

  void _startServer() {
    debugPrint('\nStarting server\n');
    server.start();
    setState(() {});
  }

  void _stopServer() {
    debugPrint('\nStopping server\n');
    server.stop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ElevatedButton toggleServerButton() {
      Widget textWidget(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 3.0),
        child: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.copyWith(color: Colors.white),
        ),
      );

      final ElevatedButton startServer = ElevatedButton(
        onPressed: () => _startServer(),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.green.shade600),
        ),
        child: textWidget('Start server'),
      );

      final ElevatedButton stopServer = ElevatedButton(
        onPressed: () => _stopServer(),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.red.shade600),
        ),
        child: textWidget('Stop server'),
      );

      return server.isServing ? stopServer : startServer;
    }

    debugPrint('Server is currently serving? ${server.isServing}');

    // FIXME always stuck on 0 - not showing number of devices connected to the server.
    Widget connectionsInfo() {
      HttpConnectionsInfo? connections = server.connections;

      debugPrint('No connections? ${connections == null}');

      if (connections == null) {
        return Text(
          'No connections',
          style: Theme.of(context).textTheme.bodyLarge,
        );
      }
      // The server currently has connections to clients.
      else {
        Widget text(String text) => Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
        );

        return Table(
          border: TableBorder.all(),
          columnWidths: {1: FlexColumnWidth(2)},
          children: [
            TableRow(
              children: [
                text('Active'),
                text(server.connections!.active.toString()),
              ],
            ),
            TableRow(
              children: [
                text('Idle'),
                text(server.connections!.idle.toString()),
              ],
            ),
            TableRow(
              children: [
                text('Closing'),
                text(server.connections!.closing.toString()),
              ],
            ),
          ],
        );
      }
    }

    Text text(String message) => Text(
      message,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Kobayashi Maru Server')),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Gap(30),
              Flexible(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.75,
                        child: Table(
                          children: [
                            TableRow(
                              children: [text('Host'), text(server.host)],
                            ),
                            TableRow(
                              children: [
                                text('Port'),
                                text(server.port.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Gap(30),
                      toggleServerButton(),
                      const Gap(50),
                      Text(
                        'Connections',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Gap(20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () => setState(() {}),
                          child: Text('Update info'),
                        ),
                      ),
                      const Gap(20),
                      connectionsInfo(),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SimStateView(),
                      ),
                    ),
                child: Text('Control simulation state'),
              ),
              Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}
