import 'ship_systems/communications.dart';
import 'ship_systems/ship_systems.dart';
import 'ship_systems/weapons.dart';
import 'species.dart';

/// Model of a ship as a whole.
sealed class Ship {
  Ship();

  late final Structure structure = Structure(ship: this);

  late final Propulsion propulsion = Propulsion(ship: this);

  late final Weapons weapons = Weapons(ship: this);

  late final Communications communications = Communications(ship: this);

  // TODO add other systems

  void send({required String message, required ShipSystem source}) {
    // TODO implement send() - pass message to communications system for sending.
    throw UnimplementedError();
  }
}

final class FederationStarship extends Ship {
  FederationStarship({required this.registry, required this.name}) : super();

  /// E.g. "*USS Enterprise*"
  final String name;

  /// E.g. "NCC-1701-D" for the [*Galaxy*-class Enterprise-D](https://memory-alpha.fandom.com/wiki/USS_Enterprise_(NCC-1701-D)).
  final String registry;
}

sealed class EnemyShip extends Ship {
  EnemyShip._({required this.species});

  final Species species;

  factory EnemyShip.borgCube() = BorgCube;

  factory EnemyShip.klingonBirdOfPrey() = KlingonBirdOfPrey;

  factory EnemyShip.romulanWarbird() = RomulanWarbird;

  void takePhaserDamage();

  void takeTorpedoDamage();
}

final class BorgCube extends EnemyShip {
  BorgCube() : super._(species: Species.borg);

  @override
  void takePhaserDamage() {
    // TODO: implement takePhaserDamage
    throw UnimplementedError();
  }

  @override
  void takeTorpedoDamage() {
    // TODO: implement takeTorpedoDamage
    throw UnimplementedError();
  }
}

final class KlingonBirdOfPrey extends EnemyShip {
  KlingonBirdOfPrey() : super._(species: Species.klingon);

  @override
  void takePhaserDamage() {
    // TODO: implement takePhaserDamage
    throw UnimplementedError();
  }

  @override
  void takeTorpedoDamage() {
    // TODO: implement takeTorpedoDamage
    throw UnimplementedError();
  }
}

final class RomulanWarbird extends EnemyShip {
  RomulanWarbird() : super._(species: Species.romulan);

  @override
  void takePhaserDamage() {
    // TODO: implement takePhaserDamage
    throw UnimplementedError();
  }

  @override
  void takeTorpedoDamage() {
    // TODO: implement takeTorpedoDamage
    throw UnimplementedError();
  }
}
