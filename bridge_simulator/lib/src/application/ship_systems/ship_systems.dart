import '../ship.dart';

abstract class ShipSystem {
  ShipSystem();

  late final Ship ship;
}

final class Structure extends ShipSystem {
  Structure() : super();
}

final class Propulsion extends ShipSystem {
  Propulsion() : super();
}

final class Tactical extends ShipSystem {
  Tactical() : super();
}
