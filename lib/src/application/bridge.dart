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

/// The type of [Bride] used on a *Galaxy*-class starship (i.e. in this simulation, a [FederationStarship]).
final class GalaxyClassBridge extends Bridge {
  GalaxyClassBridge()
    : super(
        stations: [
          BridgeStation.viewscreen,
          BridgeStation.ops,
          BridgeStation.conn,
          BridgeStation.captainChair,
          BridgeStation.tactical,
          BridgeStation.scienceI,
          BridgeStation.scienceII,
          BridgeStation.missionOps,
          BridgeStation.environment,
          BridgeStation.engineering,
        ],
      );

  final ViewscreenBridgeStation viewscreen = BridgeStation.viewscreen;
  final OpsBridgeStation ops = BridgeStation.ops;
  final ConnBridgeStation conn = BridgeStation.conn;
  final CaptainChairBridgeStation captainChair = BridgeStation.captainChair;
  final TacticalBridgeStation tactical = BridgeStation.tactical;
  final ScienceIBridgeStation scienceI = BridgeStation.scienceI;
  final ScienceIIBridgeStation scienceII = BridgeStation.scienceII;
  final MissionOpsBridgeStation missionOps = BridgeStation.missionOps;
  final EnvironmentBridgeStation environment = BridgeStation.environment;
  final EngineeringBridgeStation engineering = BridgeStation.engineering;
}

/// The type of [Bride] used on a [RomulanWarbird].
final class RomulanBridge extends Bridge {
  RomulanBridge() : super(stations: []);
}

/// The type of [Bride] used on a [KlingonBirdOfPrey].
final class KlingonBridge extends Bridge {
  KlingonBridge() : super(stations: []);
}

/// The type of [Bride] used on a [BorgCube].
final class BorgBridge extends Bridge {
  BorgBridge() : super(stations: []);
}
