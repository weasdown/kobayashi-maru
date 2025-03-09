/// Details that the server will use to instantiate itself.
library;

// TODO switch scheme to (secure) 'wss'
import 'dart:io';

String serverScheme = 'ws';

String serverHost = Platform.isWindows ? 'localhost' : '192.168.1.201';

int serverPort = 5678;

final Uri channelUri = Uri(
  scheme: serverScheme,
  host: serverHost,
  port: serverPort,
);
