import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

// import '../../../main.dart';
import '../ship.dart';
import 'ship_systems.dart';

final class Weapons extends ShipSystem {
  Weapons() : super(dataHandlerFunction: _dataHandler);

  EnemyShip? target;

  static Future<String> _dataHandler(Map<String, dynamic> data) async =>
      throw UnsupportedError(
        '_dataHandler must be implemented for each subtype of Weapons.',
      );
}

final class Phasers extends Weapons {
  Phasers();

  bool firing = false;

  void fire() {
    // TODO send message to server that firing torpedoes
    firing = true;

    // WidgetsFlutterBinding.ensureInitialized();

    // // Create the audio player.
    // AudioPlayer player = AudioPlayer();
    // player.play(AssetSource('weapons/tng_phaser_clean.mp3'));

    // HomeState.player.play(AssetSource('weapons/tng_phaser_clean.mp3'));
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

final class Disruptors extends Weapons {}

final class GalaxyClassWeapons extends Weapons {
  GalaxyClassWeapons();

  bool firingPhasers = false;

  bool firingTorpedoes = false;

  final Phasers phasers = Phasers();

  final Torpedoes torpedoes = Torpedoes(remaining: 20);

  /// Selects a particular [EnemyShip] as the target when firing [phasers] or [torpedoes].
  targetShip() {
    // TODO implement GalaxyClassWeapons.targetShip().
    throw UnimplementedError();
  }

  // TODO merge Phasers.fire() into here
  /// Fires the ship's [phasers].
  String firePhasers() {
    // TODO add targeting
    firingPhasers = true;

    WidgetsFlutterBinding.ensureInitialized();
    final player = AudioPlayer();
    player.play(AssetSource('ten_forward_doors.mp3')); // TODO use correct file

    // // AudioPlayer player = AudioPlayer();
    // // player.play();
    // player.play(AssetSource('weapons/tng_phaser_clean.mp3'));

    if (target != null) {
      target!.takePhaserDamage();
    }

    String message = 'Firing phasers, Captain!';
    firingPhasers = false;

    return message;
  }

  /// Fires the ship's [torpedoes].
  String fireTorpedoes() {
    // TODO add targeting
    firingTorpedoes = true;
    String message = 'Firing torpedoes, Captain!';
    firingTorpedoes = false;
    return message;
  }
}

final class BorgWeapons extends Weapons {
  BorgWeapons();

  final Phasers phasers = Phasers();
}

final class KlingonWeapons extends Weapons {
  KlingonWeapons();

  final Phasers phasers = Phasers();

  final Torpedoes torpedoes = Torpedoes(remaining: 30);
}

final class RomulanWeapons extends Weapons {
  RomulanWeapons();

  final Disruptors disruptors = Disruptors();
}
