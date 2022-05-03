import 'package:flutter/foundation.dart';

class LunaPlatform {
  bool get isWeb => kIsWeb;
  bool get isMobile => isAndroid || isIOS;
  bool get isDesktop => isLinux || isMacOS || isWindows;

  bool get isAndroid {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  }

  bool get isIOS {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;
  }

  bool get isLinux {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;
  }

  bool get isMacOS {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;
  }

  bool get isWindows {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;
  }
}
