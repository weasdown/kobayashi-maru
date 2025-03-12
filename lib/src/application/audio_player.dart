import 'package:flutter/foundation.dart' show debugPrint;
import 'package:minisound/engine.dart' as minisound;
import 'package:minisound/engine_flutter.dart';

/// Simple class to handle playing of audio, e.g. weapon sound effects.
class SoundPlayer {
  SoundPlayer() {
    _setupEngine();
  }

  void _setupEngine() async {
    // Engine initialization
    // You can pass `periodMs` as an argument, to change determines the latency (does not affect web). Can cause crackles if too low.
    await engine.init(20);

    // For web, this should be executed after the first user interaction due to browsers' autoplay policy
    await engine.start();
  }

  final minisound.Engine engine = minisound.Engine();

  // FIXME if too many sounds are requested at once, the server crashes entirely, although it can now tolerate a lot of concurrent requests. Perhaps add the sound requests to a queue then take them from the queue once the engine has initialised.
  void play(String path) async {
    debugPrint('Loading $path');
    // Load the sound effect into the Engine.
    final LoadedSound sound = await engine.loadSoundAsset(path);

    debugPrint('Playing $path');
    sound.play();
  }
}
