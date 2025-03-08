import 'package:bridge_simulator/bridge_simulator.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'ship_systems.dart';

// TODO complete data send/receive via subspaceTransceiver
final class Communications extends ShipSystem {
  Communications({required super.ship}) : super(station: BridgeStation.ops);

  WebSocketChannel? channel;

  final ServerInterface subspaceTransceiver = ServerInterface();

  void send({required String message, required ShipSystem source}) =>
      subspaceTransceiver.send(source.station, message);
}
