import '../ship.dart';

abstract class ShipSystem {
  ShipSystem();

  late final Ship ship;

  dataHandler(Map<String, dynamic> data);
}

final class Structure extends ShipSystem {
  Structure() : super();

  @override
  dataHandler(Map<String, dynamic> data) {
    throw UnimplementedError();
  }
}

final class Propulsion extends ShipSystem {
  Propulsion() : super();

  @override
  dataHandler(Map<String, dynamic> data) {
    throw UnimplementedError();
  }
}

final class Tactical extends ShipSystem {
  Tactical() : super();

  @override
  dataHandler(Map<String, dynamic> data) {
    throw UnimplementedError();
  }
}
