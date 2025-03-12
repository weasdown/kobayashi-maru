/// Details that the dart_server will use to instantiate itself.
library;

// TODO switch scheme to (secure) 'wss'
const String serverScheme = 'ws';

final String localhost = 'localhost';
final String serverHost = '192.168.1.201';

const int serverPort = 5678;

final Uri channelUri = Uri(
  scheme: serverScheme,
  host: serverHost,
  port: serverPort,
);
