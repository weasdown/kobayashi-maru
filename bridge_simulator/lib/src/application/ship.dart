import 'package:web_socket_channel/web_socket_channel.dart';

import '../presentation/stations.dart';
import 'bridge.dart';
import 'ship_systems/ship_systems.dart';
import 'ship_systems/weapons.dart';
import 'species.dart';

/// Model of a ship as a whole.
sealed class Ship {
  Ship({required this.bridge, required this.weapons});

  late final WebSocketChannel channel;

  final Bridge bridge;

  final Weapons weapons;

  void send({required String message, required BridgeStation source}) {
    // TODO implement send() - pass message to communications system for sending.
    throw UnimplementedError();
  }

  // TODO move take[weapon type]Damage() to Structure ShipSystem.
  void takeDisruptorDamage();

  void takePhaserDamage();

  void takeTorpedoDamage();
}

final class FederationStarship extends Ship {
  FederationStarship({required this.registry, required this.name})
    : super(bridge: GalaxyClassBridge(), weapons: GalaxyClassWeapons());

  @override
  GalaxyClassBridge get bridge => super.bridge as GalaxyClassBridge;

  /// E.g. "*USS Enterprise*"
  final String name;

  /// E.g. "NCC-1701-D" for the [*Galaxy*-class Enterprise-D](https://memory-alpha.fandom.com/wiki/USS_Enterprise_(NCC-1701-D)).
  final String registry;

  /// The Starship's Tactical system, controlling weapons, shields, communications and long-range sensors.
  final Tactical tactical = Tactical();
  // TODO add other ShipSystems

  @override
  String toString() => '$name, $registry';

  @override
  void takeDisruptorDamage() {
    // TODO: implement takeDisruptorDamage
    throw UnimplementedError();
  }

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

/// The USS Enterprise-D, NCC-1701-D.
final FederationStarship enterpriseD = FederationStarship(
  registry: 'NCC-1701-D',
  name: 'USS Enterprise',
);

sealed class EnemyShip extends Ship {
  EnemyShip._({
    required this.species,
    required super.bridge,
    required super.weapons,
  });

  final Species species;

  factory EnemyShip.borgCube() = BorgCube;

  factory EnemyShip.klingonBirdOfPrey() = KlingonBirdOfPrey;

  factory EnemyShip.romulanWarbird() = RomulanWarbird;
}

final class BorgCube extends EnemyShip {
  BorgCube()
    : super._(
        species: Species.borg,
        bridge: BorgBridge(),
        weapons: BorgWeapons(),
      );

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

  @override
  void takeDisruptorDamage() {
    // TODO: implement takeDisruptorDamage
    throw UnimplementedError();
  }
}

final class KlingonBirdOfPrey extends EnemyShip {
  KlingonBirdOfPrey()
    : super._(
        species: Species.klingon,
        bridge: KlingonBridge(),
        weapons: KlingonWeapons(),
      );

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

  @override
  void takeDisruptorDamage() {
    // TODO: implement takeDisruptorDamage
    throw UnimplementedError();
  }
}

final class RomulanWarbird extends EnemyShip {
  RomulanWarbird()
    : super._(
        species: Species.romulan,
        bridge: RomulanBridge(),
        weapons: RomulanWeapons(),
      );

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

  @override
  void takeDisruptorDamage() {
    // TODO: implement takeDisruptorDamage
    throw UnimplementedError();
  }
}
