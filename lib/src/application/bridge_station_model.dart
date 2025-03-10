import 'package:kobayashi_maru/src/application/bridge_station.dart';

import '../data/message.dart';
import 'bridge.dart';

/// A model for a station/console on a [Bridge].
sealed class BridgeStationModel {
  BridgeStationModel();

  /// Sends a message to the simulation server.
  void send(String message) => Message.send(data: message, station: station);

  late final BridgeStation station;

  @override
  String toString() => '${station.name} model';
}

final class ViewscreenBridgeStationModel extends BridgeStationModel {
  ViewscreenBridgeStationModel() : super();
}

final class OpsBridgeStationModel extends BridgeStationModel {
  OpsBridgeStationModel() : super();
}

final class ConnBridgeStationModel extends BridgeStationModel {
  ConnBridgeStationModel() : super();
}

final class CaptainChairBridgeStationModel extends BridgeStationModel {
  CaptainChairBridgeStationModel() : super();
}

final class TacticalBridgeStationModel extends BridgeStationModel {
  TacticalBridgeStationModel() : super();
}

final class ScienceIBridgeStationModel extends BridgeStationModel {
  ScienceIBridgeStationModel() : super();
}

final class ScienceIIBridgeStationModel extends BridgeStationModel {
  ScienceIIBridgeStationModel() : super();
}

final class MissionOpsBridgeStationModel extends BridgeStationModel {
  MissionOpsBridgeStationModel() : super();
}

final class EnvironmentBridgeStationModel extends BridgeStationModel {
  EnvironmentBridgeStationModel() : super();
}

final class EngineeringBridgeStationModel extends BridgeStationModel {
  EngineeringBridgeStationModel() : super();
}
