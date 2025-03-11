import 'package:kobayashi_maru/src/application/ship.dart';

import 'audio_player.dart';

/// The core simulator for the whole broader program.
final class Simulator {
  Simulator();

  final SoundPlayer player = SoundPlayer();

  /// The USS Enterprise-D, NCC-1701-D.
  static final FederationStarship enterpriseD = FederationStarship(
    registry: 'NCC-1701-D',
    name: 'USS Enterprise',
  );
}
