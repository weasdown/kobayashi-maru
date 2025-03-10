/// Details that the dart_server will use to instantiate itself.
library;

// TODO switch scheme to (secure) 'wss'
import 'dart:io';

const String serverScheme = 'ws';

final String serverHost = Platform.isWindows ? 'localhost' : '192.168.1.201';

const int serverPort = 5678;

final Uri channelUri = Uri(
  scheme: serverScheme,
  host: serverHost,
  port: serverPort,
);
