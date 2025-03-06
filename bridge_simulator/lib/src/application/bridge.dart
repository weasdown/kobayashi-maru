import '../data/bridge_server.dart';
import '../presentation/stations.dart';
import 'ship.dart';

/// The room from where the bridge crew control the [Ship].
final class Bridge {
  const Bridge() : communicationInterface = const ServerInterface();

  static const ViewscreenBridgeStation viewscreen = BridgeStation.viewscreen;
  static const OpsBridgeStation ops = BridgeStation.ops;
  static const ConnBridgeStation conn = BridgeStation.conn;
  static const CaptainChairBridgeStation captainChair =
      BridgeStation.captainChair;
  static const TacticalBridgeStation tactical = BridgeStation.tactical;
  static const ScienceIBridgeStation scienceI = BridgeStation.scienceI;
  static const ScienceIIBridgeStation scienceII = BridgeStation.scienceII;
  static const MissionOpsBridgeStation missionOps = BridgeStation.missionOps;
  static const EnvironmentBridgeStation environment = BridgeStation.environment;
  static const EngineeringBridgeStation engineering = BridgeStation.engineering;

  final ServerInterface communicationInterface;
}
