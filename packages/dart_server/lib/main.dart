import 'package:dart_server/dart_server.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Kobayashi Maru Server'),
        actions: [
          // TODO add restart server button
          // TODO add stop server button
        ],
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: ListView(
            children: [
              // Text(
              //   'Server',
              //   style: Theme.of(context).textTheme.headlineMedium,
              //   textAlign: TextAlign.center,
              // ),
              const Gap(30),
              toggleServerButton(),
              const Gap(50),
              Text(
                'Connections',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              // TODO add connections data from server.connections
            ],
          ),
        ),
      ),
    );
  }
}
