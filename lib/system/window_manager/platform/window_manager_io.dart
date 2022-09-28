import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/system/platform.dart';
import 'package:window_manager/window_manager.dart';

// ignore: always_use_package_imports
import '../window_manager.dart';

bool isPlatformSupported() => LunaPlatform.isDesktop;
LunaWindowManager getWindowManager() {
  switch (LunaPlatform.current) {
    case LunaPlatform.LINUX:
    case LunaPlatform.MACOS:
    case LunaPlatform.WINDOWS:
      return IO();
    default:
      throw UnsupportedError('LunaWindowManager unsupported');
  }
}

class IO implements LunaWindowManager {
  @override
  Future<void> initialize() async {
    if (kDebugMode) return;

    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await setWindowSize();
      await setWindowTitle('LunaSea');
      windowManager.show();
    });
  }

  @override
  Future<void> setWindowTitle(String title) async {
    return windowManager
        .waitUntilReadyToShow()
        .then((_) async => await windowManager.setTitle(title));
  }

  Future<void> setWindowSize() async {
    const min = LunaWindowManager.MINIMUM_WINDOW_SIZE;
    const init = LunaWindowManager.INITIAL_WINDOW_SIZE;
    const minSize = Size(min, min);
    const initSize = Size(init, init);

    await windowManager.setSize(initSize);
    // Currently broken on Linux
    if (!LunaPlatform.isLinux) {
      await windowManager.setMinimumSize(minSize);
    }
  }
}
