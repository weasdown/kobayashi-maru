import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../main.dart' as main;
import '../application/bridge.dart';
import '../application/bridge_station.dart';
import '../data/message.dart';
import 'views/buttons.dart';

/// A generic station, console or screen on the [Bridge].
// TODO separate the BridgeStation's logic from its UI - see Flutter architecture guide: https://docs.flutter.dev/app-architecture/guide
sealed class BridgeStationView extends StatefulWidget {
  const BridgeStationView._({super.key});

  /// The container for the [BridgeStationView]'s logic.
  BridgeStation get station;

  static ViewscreenBridgeStationView viewscreen = ViewscreenBridgeStationView();

  // TODO move Federation-specific bridge station static attributes to a new GalaxyClassBridgeStationView class.
  static OpsBridgeStationView ops = OpsBridgeStationView();

  static ConnBridgeStationView conn = ConnBridgeStationView();

  static CaptainChairBridgeStationView captainChair =
      CaptainChairBridgeStationView();

  static TacticalBridgeStationView tactical = TacticalBridgeStationView();

  static ScienceIBridgeStationView scienceI = ScienceIBridgeStationView();

  static ScienceIIBridgeStationView scienceII = ScienceIIBridgeStationView();

  static MissionOpsBridgeStationView missionOps = MissionOpsBridgeStationView();

  static EnvironmentBridgeStationView environment =
      EnvironmentBridgeStationView();

  static EngineeringBridgeStationView engineering =
      EngineeringBridgeStationView();

  /// Sends a message to the simulation server.
  void send(String message) => Message.send(data: message, station: station);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) =>
      '${station.name} view';

  @override
  State<BridgeStationView> createState() => BridgeStationViewState();
}

class BridgeStationViewState extends State<BridgeStationView> {
  BridgeStationViewState() : channel = main.channel, data = {};

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
final class ViewscreenBridgeStationView extends BridgeStationView {
  const ViewscreenBridgeStationView({super.key}) : super._();

  @override
  ViewscreenBridgeStation get station => ViewscreenBridgeStation();
}

/// Responsible for communications, scanning and course navigation.
final class OpsBridgeStationView extends BridgeStationView {
  const OpsBridgeStationView({super.key}) : super._();

  @override
  OpsBridgeStation get station => OpsBridgeStation();
}

/// Responsible for piloting the ship.
final class ConnBridgeStationView extends BridgeStationView {
  const ConnBridgeStationView({super.key}) : super._();

  @override
  ConnBridgeStation get station => ConnBridgeStation();
}

/// Provides key information to the ship's Captain.
final class CaptainChairBridgeStationView extends BridgeStationView {
  const CaptainChairBridgeStationView({super.key}) : super._();

  @override
  CaptainChairBridgeStation get station => CaptainChairBridgeStation();
}

/// Responsible for weapons, shields, long-range sensors and communications (supporting the [OpsBridgeStation]).
class TacticalBridgeStationView extends BridgeStationView {
  const TacticalBridgeStationView({super.key}) : super._();

  @override
  BridgeStationViewState createState() => _TBSState();

  @override
  TacticalBridgeStation get station => TacticalBridgeStation();
}

class _TBSState extends BridgeStationViewState {
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
final class ScienceIBridgeStationView extends BridgeStationView {
  const ScienceIBridgeStationView({super.key}) : super._();

  @override
  ScienceIBridgeStation get station => ScienceIBridgeStation();
}

/// Responsible for science investigations.
final class ScienceIIBridgeStationView extends BridgeStationView {
  const ScienceIIBridgeStationView({super.key}) : super._();

  @override
  ScienceIIBridgeStation get station => ScienceIIBridgeStation();
}

/// Enables access to data about the ship's current mission (e.g. about nearby planets).
final class MissionOpsBridgeStationView extends BridgeStationView {
  const MissionOpsBridgeStationView({super.key}) : super._();

  @override
  MissionOpsBridgeStation get station => MissionOpsBridgeStation();
}

/// Responsible for controlling the life support system to maintain a habitable and comfortable environment for the crew .
final class EnvironmentBridgeStationView extends BridgeStationView {
  const EnvironmentBridgeStationView({super.key}) : super._();

  @override
  EnvironmentBridgeStation get station => EnvironmentBridgeStation();
}

/// Responsible for the ship's engines, transporters and other engineering systems.
///
/// This is a backup to the consoles found in Main Engineering.
final class EngineeringBridgeStationView extends BridgeStationView {
  const EngineeringBridgeStationView({super.key}) : super._();

  @override
  EngineeringBridgeStation get station => EngineeringBridgeStation();
}
