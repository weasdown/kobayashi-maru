import 'dart:async';

import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:logging/logging.dart';

class AudioController {
  static final Logger _log = Logger('AudioController');

  SoLoud? _soloud;

  SoundHandle? _musicHandle;

  final String _soundAssetRoot = 'assets/sounds/files';

  Future<void> initialize() async {
    try {
      _soloud = SoLoud.instance;
      await _soloud!.init();
    } catch (e) {
      // TODO handle any thrown errors
      rethrow;
    }

    phaserSound = await _loadAsset(
      '$_soundAssetRoot/weapons/tng_phaser_clean.mp3',
    );
    torpedoSound = await _loadAsset(
      '$_soundAssetRoot/weapons/tng_torpedo_clean.mp3',
    );
  }

  void dispose() {
    _soloud?.deinit();
  }

  static late AudioSource phaserSound;
  static late AudioSource torpedoSound;

  Future<AudioSource> _loadAsset(String assetKey) async =>
  // TODO implement error handling, including for null check
  await _soloud!.loadAsset(assetKey);

  Future<void> play(AudioSource source) async => await _soloud!.play(source);

  Future<void> playSound(String assetKey) async {
    try {
      final source = await _soloud!.loadAsset(assetKey);
      await _soloud!.play(source);
    } on SoLoudException catch (e) {
      _log.severe("Cannot play sound '$assetKey'. Ignoring.", e);
    }
  }

  Future<void> startMusic() async {
    if (_musicHandle != null) {
      if (_soloud!.getIsValidVoiceHandle(_musicHandle!)) {
        _log.info('Music is already playing. Stopping first.');
        await _soloud!.stop(_musicHandle!);
      }
    }
    final musicSource = await _soloud!.loadAsset(
      'assets/music/looped-song.ogg',
      mode: LoadMode.disk,
    );
    _musicHandle = await _soloud!.play(musicSource);
  }

  void fadeOutMusic() {
    _log.warning('fadeOutMusic not implemented yet.');
  }

  void applyFilter() {
    // TODO
  }

  void removeFilter() {
    // TODO
  }
}
