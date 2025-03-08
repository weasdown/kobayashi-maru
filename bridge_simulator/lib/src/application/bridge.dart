import '../presentation/stations.dart';
import 'ship.dart';

/// The room from where the bridge crew control the [Ship].
sealed class Bridge {
  Bridge({required this.stations});

  /// All the [BridgeStation]s on this [Bridge].
  List<BridgeStation> stations;

  void send(BridgeStation station, String message) =>
      ship.send(message: message, source: station);

  late final Ship ship;
}

final class GalaxyClassBridge extends Bridge {
  GalaxyClassBridge()
    : super(
        stations: [
          viewscreen,
          ops,
          conn,
          captainChair,
          tactical,
          scienceI,
          scienceII,
          missionOps,
          environment,
          engineering,
        ],
      );

  static final ViewscreenBridgeStation viewscreen = BridgeStation.viewscreen;
  static final OpsBridgeStation ops = BridgeStation.ops;
  static final ConnBridgeStation conn = BridgeStation.conn;
  static final CaptainChairBridgeStation captainChair =
      BridgeStation.captainChair;
  static final TacticalBridgeStation tactical = BridgeStation.tactical;
  static final ScienceIBridgeStation scienceI = BridgeStation.scienceI;
  static final ScienceIIBridgeStation scienceII = BridgeStation.scienceII;
  static final MissionOpsBridgeStation missionOps = BridgeStation.missionOps;
  static final EnvironmentBridgeStation environment = BridgeStation.environment;
  static final EngineeringBridgeStation engineering = BridgeStation.engineering;
}

final class RomulanBridge extends Bridge {
  RomulanBridge() : super(stations: []);
}

final class KlingonBridge extends Bridge {
  KlingonBridge() : super(stations: []);
}

final class BorgBridge extends Bridge {
  BorgBridge() : super(stations: []);
}
