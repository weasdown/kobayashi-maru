import '../presentation/stations.dart';
import 'ship.dart';

/// The room from where the bridge crew control the [Ship].
sealed class Bridge {
  Bridge({required this.stations});

  /// All the [BridgeStation]s on this [Bridge].
  List<BridgeStation> stations;

  void send(BridgeStation station, String message) =>
      ship.send(message: message, source: station);

  late final Ship ship;
}
}
