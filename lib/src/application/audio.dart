import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

// TODO remove this file.

/// Simple example of playing audio.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String fileName = 'ten_forward_doors.mp3';

  final player = AudioPlayer();

  await player.play(AssetSource(fileName));
}
