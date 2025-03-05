final Uri webSocketServer = Uri(scheme: 'ws', host: 'localhost', port: 5678);

/// A client-side interface to the WebSocket connection that enables data to be shared with the simulation server.
interface class BridgeServer {
  BridgeServer({required this.webSocketUri});

  final Uri webSocketUri;
}
