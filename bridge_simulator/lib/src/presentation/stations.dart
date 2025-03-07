import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../main.dart';
import '../application/bridge.dart';
import '../presentation/scaffold.dart';
import 'buttons.dart';

/// A generic station, console or screen on the [Bridge].
// sealed class BridgeStation extends StatelessWidget {
//   const BridgeStation._({super.key});
//
//   /// The [Bridge] used throughout the simulation.
//   Bridge get bridge => Home.mainBridge;
//
//   /// A more human-readable name for this [BridgeStation].
//   String get name => runtimeType.toString().replaceFirst('BridgeStation', '');
//
//   /// Sends a message to the simulation server via the [Bridge].
//   void send(String data) => bridge.send(this, data);
//
//   static const ViewscreenBridgeStation viewscreen = ViewscreenBridgeStation();
//
//   static const OpsBridgeStation ops = OpsBridgeStation();
//
//   static const ConnBridgeStation conn = ConnBridgeStation();
//
//   static const CaptainChairBridgeStation captainChair =
//       CaptainChairBridgeStation();
//
//   static const TacticalBridgeStation tactical = TacticalBridgeStation();
//
//   static const ScienceIBridgeStation scienceI = ScienceIBridgeStation();
//
//   static const ScienceIIBridgeStation scienceII = ScienceIIBridgeStation();
//
//   static const MissionOpsBridgeStation missionOps = MissionOpsBridgeStation();
//
//   static const EnvironmentBridgeStation environment =
//       EnvironmentBridgeStation();
//
//   static const EngineeringBridgeStation engineering =
//       EngineeringBridgeStation();
//
//   // TODO remove placeholderBuildMethod() once all subtypes have implemented build()
//   Widget placeholderBuildMethod(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text(name, style: Theme.of(context).textTheme.headlineMedium),
//       ),
//     );
//   }
//
//   @override
//   String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => name;
// }

sealed class BridgeStation extends StatefulWidget {
  const BridgeStation._({super.key});

  /// The [Bridge] used throughout the simulation.
  Bridge get bridge => Home.mainBridge;

  /// A more human-readable name for this [BridgeStation].
  String get name => runtimeType.toString().replaceFirst('BridgeStation', '');

  // /// Sends a message to the simulation server via the [Bridge].
  // void send(String data) => bridge.send(this, data);

  static const ViewscreenBridgeStation viewscreen = ViewscreenBridgeStation();

  static const OpsBridgeStation ops = OpsBridgeStation();

  static const ConnBridgeStation conn = ConnBridgeStation();

  static const CaptainChairBridgeStation captainChair =
      CaptainChairBridgeStation();

  static const TacticalBridgeStation tactical = TacticalBridgeStation();

  static const ScienceIBridgeStation scienceI = ScienceIBridgeStation();

  static const ScienceIIBridgeStation scienceII = ScienceIIBridgeStation();

  static const MissionOpsBridgeStation missionOps = MissionOpsBridgeStation();

  static const EnvironmentBridgeStation environment =
      EnvironmentBridgeStation();

  static const EngineeringBridgeStation engineering =
      EngineeringBridgeStation();

  // TODO remove placeholderBuildMethod() once all subtypes have implemented build()
  Widget placeholderBuildMethod(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(name, style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => name;

  @override
  State<BridgeStation> createState() => BridgeStationState();
}

class BridgeStationState extends State<BridgeStation> {
  BridgeStationState();

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  late final WebSocketChannel _channel = bridge.communicationInterface.channel!;

  Bridge get bridge => widget.bridge;

  static const double spacing = 32;

  late Stream stream = bridge.communicationInterface.stream;

  void refresh() {
    setState(() {});
  }

  /// Sends a message to the simulation server via the [Bridge].
  void send(String data) => bridge.send(widget, data);

  late List<Widget> tiles;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: super.widget.bridge.communicationInterface.stream,
      builder: (context, snapshot) {
        debugPrint('\nLatest data from WebSocket: ${snapshot.data}');
        debugPrint('Rebuilding');

        String message =
            (snapshot.hasError)
                ? snapshot.error.toString()
                : switch (snapshot.connectionState) {
                  ConnectionState.waiting || ConnectionState.none => 'Loading',
                  ConnectionState.active => 'Data: ${snapshot.data}',

                  ConnectionState.done => 'Final data: ${snapshot.data}',
                };
        debugPrint('message: $message');

        return DefaultScaffold(
          body: GridView.count(
            crossAxisSpacing: spacing,
            padding: EdgeInsets.all(spacing),
            crossAxisCount: 3,
            children: tiles,
          ),
        );
      },
    );
  }
}

/// Displays various views to the bridge crew, often of what's in front of the ship.
final class ViewscreenBridgeStation extends BridgeStation {
  const ViewscreenBridgeStation({super.key}) : super._();

  // @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return placeholderBuildMethod(context);
  }
}

/// Responsible for communications, scanning and course navigation.
final class OpsBridgeStation extends BridgeStation {
  const OpsBridgeStation({super.key}) : super._();

  // @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

/// Responsible for piloting the ship.
final class ConnBridgeStation extends BridgeStation {
  const ConnBridgeStation({super.key}) : super._();

  // @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

/// Provides key information to the ship's Captain.
final class CaptainChairBridgeStation extends BridgeStation {
  const CaptainChairBridgeStation({super.key}) : super._();

  // @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

/// Responsible for weapons, shields, long-range sensors and communications (supporting the [OpsBridgeStation]).
class TacticalBridgeStation extends BridgeStation {
  const TacticalBridgeStation({super.key}) : super._();

  @override
  BridgeStationState createState() => _TBSState();
}

class _TBSState extends BridgeStationState {
  Future<void> firePhasers() async {
    debugPrint('\nFiring phasers!');
    send('firePhasers');
  }

  void firePhotonTorpedoes() {
    debugPrint('\nFiring photon torpedoes!');
    send('firePhotonTorpedoes');
  }

  @override
  Widget build(BuildContext context) {
    Widget firePhasersButton = DangerButton(
      context: () => context,
      text: 'Fire Phasers',
      onPressed: firePhasers,
    );

    Widget firePhotonTorpedoesButton = DangerButton(
      context: () => context,
      text: 'Fire Photon Torpedoes',
      onPressed: firePhotonTorpedoes,
    );

    tiles = [firePhasersButton, firePhotonTorpedoesButton];

    return super.build(context);
  }
}

/// Responsible for science investigations.
final class ScienceIBridgeStation extends BridgeStation {
  const ScienceIBridgeStation({super.key}) : super._();

  // @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

/// Responsible for science investigations.
final class ScienceIIBridgeStation extends BridgeStation {
  const ScienceIIBridgeStation({super.key}) : super._();

  // @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

/// Enables access to data about the ship's current mission (e.g. about nearby planets).
final class MissionOpsBridgeStation extends BridgeStation {
  const MissionOpsBridgeStation({super.key}) : super._();

  // @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

/// Responsible for controlling the life support system to maintain a habitable and comfortable environment for the crew .
final class EnvironmentBridgeStation extends BridgeStation {
  const EnvironmentBridgeStation({super.key}) : super._();

  // @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

/// Responsible for the ship's engines, transporters and other engineering systems.
///
/// This is a backup to the consoles found in Main Engineering.
final class EngineeringBridgeStation extends BridgeStation {
  const EngineeringBridgeStation({super.key}) : super._();

  // @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}
