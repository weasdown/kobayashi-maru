import '../data/bridge_server.dart';
import '../presentation/stations.dart';
import 'ship.dart';

/// The room from where the bridge crew control the [Ship].
final class Bridge {
  const Bridge() : communicationInterface = const ServerInterface();

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

  final ServerInterface communicationInterface;
}
