/// Details that the dart_server will use to instantiate itself.
library;

import 'package:universal_platform/universal_platform.dart'
    show UniversalPlatform;

// TODO switch scheme to (secure) 'wss'
const String serverScheme = 'ws';

final String localhost = 'localhost';

final String
defaultHost =
    // FIXME serve from whatever the current IP address is - likely different on other networks or interfaces
    UniversalPlatform.isLinux
        // Pi 500's IP address on Ethernet on home network.
        ? '192.168.1.236'
        // Desktop PC's IP address on Ethernet on home network.
        : '192.168.1.201';

const int defaultPort = 5678;

final Uri channelUri = Uri(
  scheme: serverScheme,
  host: defaultHost,
  port: defaultPort,
);
