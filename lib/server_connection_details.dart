/// Details that the dart_server will use to instantiate itself.
library;

import 'package:universal_platform/universal_platform.dart';

// TODO switch scheme to (secure) 'wss'
const String serverScheme = 'ws';

final String serverHost =
    UniversalPlatform.isDesktopOrWeb ? 'localhost' : '192.168.1.201';

const int serverPort = 5678;

final Uri channelUri = Uri(
  scheme: serverScheme,
  host: serverHost,
  port: serverPort,
);
