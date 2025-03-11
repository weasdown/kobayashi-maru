import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show debugPrint;

class SoundPlayer {
  const SoundPlayer();

  void play(String path) {
    debugPrint('Playing $path');

    // TODO convert to just_audio package that might be more reliable - see https://suragch.medium.com/playing-short-audio-clips-in-flutter-with-just-audio-3c80eb7eb6ea
    final player = AudioPlayer();
    player.play(AssetSource(path));
  }
}
