import '../ship.dart';
import '../ship_systems/ship_systems.dart';

final class Weapons extends ShipSystem {
  Weapons() : super();

  EnemyShip? target;
}

final class Phasers extends Weapons {
  Phasers();

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
  Torpedoes({required this.remaining});

  int remaining; // TODO get from server rather than hard-coding

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
