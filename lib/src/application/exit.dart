import 'dart:io';

import 'package:flutter/foundation.dart' show debugPrint;

/// Exits the app with a standard exit code.
void exitCleanly() {
  debugPrint('Exiting cleanly');
  exit(0);
}
