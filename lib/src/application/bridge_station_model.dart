import '../data/message.dart';
import 'bridge.dart';

/// A model for a station/console on a [Bridge].
sealed class BridgeStationModel {
  const BridgeStationModel();

  /// A more human-readable name for this [BridgeStation].
  String get name =>
      runtimeType.toString().replaceFirst('BridgeStationModel', '');

  /// Sends a message to the simulation server.
  void send(String message) => Message.send(data: message, station: this);

  @override
  String toString() => name;
}

final class ViewscreenBridgeStationModel extends BridgeStationModel {
  const ViewscreenBridgeStationModel() : super();
}

final class OpsBridgeStationModel extends BridgeStationModel {
  const OpsBridgeStationModel() : super();
}

final class ConnBridgeStationModel extends BridgeStationModel {
  const ConnBridgeStationModel() : super();
}

final class CaptainChairBridgeStationModel extends BridgeStationModel {
  const CaptainChairBridgeStationModel() : super();
}

final class TacticalBridgeStationModel extends BridgeStationModel {
  const TacticalBridgeStationModel() : super();
}

final class ScienceIBridgeStationModel extends BridgeStationModel {
  const ScienceIBridgeStationModel() : super();
}

final class ScienceIIBridgeStationModel extends BridgeStationModel {
  const ScienceIIBridgeStationModel() : super();
}

final class MissionOpsBridgeStationModel extends BridgeStationModel {
  const MissionOpsBridgeStationModel() : super();
}

final class EnvironmentBridgeStationModel extends BridgeStationModel {
  const EnvironmentBridgeStationModel() : super();
}

final class EngineeringBridgeStationModel extends BridgeStationModel {
  const EngineeringBridgeStationModel() : super();
}
