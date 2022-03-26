import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../../platform.dart';
import '../window_manager.dart';

bool isPlatformSupported() => LunaPlatform().isDesktop;
LunaWindowManager getWindowManager() {
  switch (defaultTargetPlatform) {
    case TargetPlatform.linux:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
      return IO();
    default:
      throw UnsupportedError('LunaWindowManager unsupported');
  }
}

class IO implements LunaWindowManager {
  @override
  Future<void> initialize() async {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      const Size minSize = Size(
        LunaWindowManager.MINIMUM_WINDOW_SIZE,
        LunaWindowManager.MINIMUM_WINDOW_SIZE,
      );

      await windowManager.setMinimumSize(minSize);
      setWindowTitle('LunaSea');

      windowManager.show();
    });
  }

  @override
  Future<void> setWindowTitle(String title) async {
    return windowManager
        .waitUntilReadyToShow()
        .then((_) async => await windowManager.setTitle(title));
  }
}
