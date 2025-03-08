import 'package:bridge_simulator/bridge_simulator.dart';

import '../ship.dart';

abstract class ShipSystem {
  const ShipSystem({required this.ship, required this.station});

  final BridgeStation station;

  final Ship ship;
}

final class Structure extends ShipSystem {
  const Structure({required super.ship})
    : super(station: BridgeStation.tactical);
}

final class Propulsion extends ShipSystem {
  const Propulsion({required super.ship}) : super(station: BridgeStation.conn);
}
