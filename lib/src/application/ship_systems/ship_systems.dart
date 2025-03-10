import 'package:bridge_simulator/src/application/ship_systems/weapons.dart';
import 'package:dart_server/dart_server.dart';

import '../ship.dart';

abstract class ShipSystem {
  ShipSystem({
    required Future<String> Function(Map<String, dynamic> data)
    dataHandlerFunction,
  }) : dataHandler = DataHandler(function: dataHandlerFunction);

  late final Ship ship;

  final DataHandler dataHandler;
}

final class Structure extends ShipSystem {
  Structure() : super(dataHandlerFunction: _dataHandler);

  static Future<String> _dataHandler(Map<String, dynamic> data) {
    throw UnimplementedError();
  }
}

final class Propulsion extends ShipSystem {
  Propulsion() : super(dataHandlerFunction: _dataHandler);

  static Future<String> _dataHandler(Map<String, dynamic> data) {
    throw UnimplementedError();
  }
}

final class Tactical extends ShipSystem {
  Tactical() : super(dataHandlerFunction: _dataHandler);

  static final GalaxyClassWeapons weapons = GalaxyClassWeapons();

  static Future<String> _dataHandler(Map<String, dynamic> data) {
    String tacticalData = data['data'];

    if (tacticalData.startsWith('fire_')) {
      return switch (tacticalData) {
        'fire_phasers' => () {
          return Future(() => weapons.firePhasers());
        }(),
        'fire_torpedoes' => Future(() => weapons.fireTorpedoes()),
        _ => throw ArgumentError(''),
      };
    } else {
      throw UnimplementedError();
    }
  }
}
