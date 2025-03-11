import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // String soundFileRoot = 'sounds/files';

  // String fileName = 'tng_phaser_clean.mp3';
  String fileName = 'ten_forward_doors.mp3';

  // AudioCache.instance = AudioCache(prefix: '');
  final player = AudioPlayer();

  // AssetSource source = AssetSource('sounds/files/weapons/$fileName');
  // source.setOnPlayer(player);

  AssetSource source2 = AssetSource(fileName);
  // source2.setOnPlayer(player);

  // await player.play(source);
  await player.play(source2);

  // print('source: ${player.source}');
  // await player.setSource(AssetSource(fileName, mimeType: 'audio/mpeg'));

  // print(AssetSource('assets').path);

  // await player.setSource(
  //   // AssetSource('$soundFileRoot/weapons/tng_phaser_clean.mp3'),
  //   AssetSource('sounds/weapons/tng_phaser_clean.mp3'),
  //
  //   // 'assets/sounds/files/weapons/tng_phaser_clean.mp3'
  // );
}
