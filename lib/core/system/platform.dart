import 'package:flutter/foundation.dart';

class LunaPlatform {
  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;
  bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;
  bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;

  bool get isWeb => kIsWeb;

  bool get isMobile => isAndroid || isIOS;
  bool get isDesktop => isLinux || isMacOS || isWindows;
}
