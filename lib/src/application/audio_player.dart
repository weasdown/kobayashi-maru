import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show debugPrint;

class SoundPlayer {
  const SoundPlayer();

  void play(String path) {
    debugPrint('Playing $path');

    final player = AudioPlayer();
    player.play(AssetSource(path));
  }
}
