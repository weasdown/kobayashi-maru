import '../../presentation/stations.dart';
import '../ship.dart';
import '../ship_systems/ship_systems.dart';

final class Weapons extends ShipSystem {
  Weapons({required super.ship}) : super(station: BridgeStation.tactical);

  EnemyShip? target;

  late final Phasers phasers = Phasers(ship: ship);

  late final Torpedoes torpedoes = Torpedoes(ship: ship);
}

final class Phasers extends Weapons {
  Phasers({required super.ship});

  bool firing = false;

  void fire() {
    // TODO send message to server that firing torpedoes
    firing = true;
    if (target != null) {
      target!.takePhaserDamage();
    }
    firing = false;
  }
}

final class Torpedoes extends Weapons {
  Torpedoes({required super.ship});

  int remaining = 20; // TODO get from server rather than hard-coding

  bool firing = false;

  void fire() {
    // TODO send message to server that firing torpedoes
    firing = true;
    remaining -= 1;
    if (target != null) {
      target!.takePhaserDamage();
    }
    firing = false;
  }
}
