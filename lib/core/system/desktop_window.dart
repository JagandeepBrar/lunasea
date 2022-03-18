import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'platform.dart';

class LunaDesktopWindow {
  static const double _MINIMUM_WINDOW_SIZE = 400;
  static const double _INITIAL_WINDOW_SIZE = 700;

  static bool get isSupported => LunaPlatform().isDesktop;

  Future<void> initialize() async {
    if (isSupported) {
      await windowManager.ensureInitialized();
      windowManager.waitUntilReadyToShow().then((_) async {
        const Size minSize = Size(_MINIMUM_WINDOW_SIZE, _MINIMUM_WINDOW_SIZE);
        const Size size = Size(_INITIAL_WINDOW_SIZE, _INITIAL_WINDOW_SIZE);

        if (!kDebugMode) await windowManager.setSize(size);
        await windowManager.setMinimumSize(minSize);
        setWindowTitle('LunaSea');

        windowManager.show();
      });
    }
  }

  Future<void> setWindowTitle(String title) async {
    if (isSupported) {
      windowManager
          .waitUntilReadyToShow()
          .then((_) async => await windowManager.setTitle(title));
    }
  }
}
