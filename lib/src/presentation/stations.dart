import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../main.dart' as main;
import '../application/bridge.dart';
import '../data/message.dart';
import 'views/buttons.dart';

/// A generic station, console or screen on the [Bridge].
// TODO separate the BridgeStation's logic from its UI - see Flutter architecture guide: https://docs.flutter.dev/app-architecture/guide
sealed class BridgeStation extends StatefulWidget {
  const BridgeStation._({super.key});

  /// A more human-readable name for this [BridgeStation].
  String get name => runtimeType.toString().replaceFirst('BridgeStation', '');

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

  /// Sends a message to the simulation server.
  void send(String message) => Message.send(data: message, station: this);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => name;

  @override
  State<BridgeStation> createState() => BridgeStationState();
}

class BridgeStationState extends State<BridgeStation> {
  BridgeStationState() : channel = main.channel, data = {};

  WebSocketChannel channel;

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  static const double spacing = 32;

  late List<Widget Function(Map<String, dynamic>)> tiles;

  Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> active(AsyncSnapshot snapshot) {
      debugPrint('Active');
      data = json.decode(snapshot.data.toString()) as Map<String, dynamic>;
      debugPrint('\nLatest data from WebSocket: $data');
      return data;
    }

    Map<String, dynamic> blankStationInfo = Map<String, dynamic>.from({
      'tactical': <String, dynamic>{},
      'viewscreen': <String, dynamic>{},
      'ops': <String, dynamic>{},
      // TODO add other stations
    });

    return StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        debugPrint('Rebuilding');

        debugPrint('snapshot.data: ${snapshot.data}');

        Map<String, dynamic> message = switch (snapshot.connectionState) {
          ConnectionState.waiting || ConnectionState.none => blankStationInfo,

          ConnectionState.active => active(snapshot),

          ConnectionState.done =>
            (snapshot.hasError)
                ? throw snapshot.error!
                : {'Done': snapshot.data},
        };
        // debugPrint('message: $message');

        return GridView.count(
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: 3.0,
          padding: EdgeInsets.all(spacing),
          crossAxisCount: 1,
          children: List<Widget>.from(
            tiles.map<Widget>(
              (Widget Function(Map<String, dynamic>) tile) =>
                  tile.call(message),
            ),
          ),
        );
      },
    );
  }
}

/// Displays various views to the bridge crew, often of what's in front of the ship.
final class ViewscreenBridgeStation extends BridgeStation {
  const ViewscreenBridgeStation({super.key}) : super._();
}

/// Responsible for communications, scanning and course navigation.
final class OpsBridgeStation extends BridgeStation {
  const OpsBridgeStation({super.key}) : super._();
}

/// Responsible for piloting the ship.
final class ConnBridgeStation extends BridgeStation {
  const ConnBridgeStation({super.key}) : super._();
}

/// Provides key information to the ship's Captain.
final class CaptainChairBridgeStation extends BridgeStation {
  const CaptainChairBridgeStation({super.key}) : super._();
}

/// Responsible for weapons, shields, long-range sensors and communications (supporting the [OpsBridgeStation]).
class TacticalBridgeStation extends BridgeStation {
  const TacticalBridgeStation({super.key}) : super._();

  @override
  BridgeStationState createState() => _TBSState();
}

class _TBSState extends BridgeStationState {
  // TODO get this from dart_server at startup rather than hardcoding
  int remainingTorpedoes = 20;

  Future<void> firePhasers() async {
    debugPrint('\nFiring phasers!');
    widget.send('fire_phasers');
  }

  @override
  Widget build(BuildContext context) {
    Widget firePhasersButton = SizedBox(
      height: 100,
      child: DangerButton(
        context: () => context,
        text: 'Fire Phasers',
        onPressed: firePhasers,
      ),
    );

    tiles = [
      (_) => firePhasersButton,
      (data) => FireTorpedoesButton(
        data: data.containsKey('tactical') ? data['tactical'] : {'Error': data},
        remainingTorpedoes: remainingTorpedoes,
        send: widget.send,
        setRemainingTorpedoes: (remaining) => remainingTorpedoes = remaining,
      ),
    ];

    return super.build(context);
  }
}

/// Responsible for science investigations.
final class ScienceIBridgeStation extends BridgeStation {
  const ScienceIBridgeStation({super.key}) : super._();
}

/// Responsible for science investigations.
final class ScienceIIBridgeStation extends BridgeStation {
  const ScienceIIBridgeStation({super.key}) : super._();
}

/// Enables access to data about the ship's current mission (e.g. about nearby planets).
final class MissionOpsBridgeStation extends BridgeStation {
  const MissionOpsBridgeStation({super.key}) : super._();
}

/// Responsible for controlling the life support system to maintain a habitable and comfortable environment for the crew .
final class EnvironmentBridgeStation extends BridgeStation {
  const EnvironmentBridgeStation({super.key}) : super._();
}

/// Responsible for the ship's engines, transporters and other engineering systems.
///
/// This is a backup to the consoles found in Main Engineering.
final class EngineeringBridgeStation extends BridgeStation {
  const EngineeringBridgeStation({super.key}) : super._();
}
