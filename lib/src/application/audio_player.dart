import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show debugPrint;

class SoundPlayer {
  const SoundPlayer();

  static AudioPlayer player = AudioPlayer();

  void play(String path) {
    debugPrint('Playing $path');
    player.play(AssetSource(path));
  }
}
