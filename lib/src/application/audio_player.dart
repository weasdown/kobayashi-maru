import 'package:flutter/foundation.dart' show debugPrint;
import 'package:minisound/engine.dart' as minisound;
import 'package:minisound/engine_flutter.dart';

/// Simple class to handle playing of audio, e.g. weapon sound effects.
class SoundPlayer {
  const SoundPlayer();

  void play(String path) async {
    debugPrint('Playing $path');

    final engine = minisound.Engine();

    // Engine initialization
    // You can pass `periodMs` as an argument, to change determines the latency (does not affect web). Can cause crackles if too low.
    await engine.init();

    // For web, this should be executed after the first user interaction due to browsers' autoplay policy
    await engine.start();

    // Load the sound effect into the Engine.
    final LoadedSound sound = await engine.loadSoundAsset(path);

    sound.play();
  }
}
