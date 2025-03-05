import 'package:bridge_simulator/bridge_simulator.dart';

final class Bridge {
  Bridge();

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
