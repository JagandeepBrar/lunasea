import 'package:flutter/foundation.dart';

enum LunaPlatform {
  ANDROID,
  IOS,
  LINUX,
  MACOS,
  WEB,
  WINDOWS;

  static bool get isAndroid {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  }

  static bool get isIOS {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;
  }

  static bool get isLinux {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;
  }

  static bool get isMacOS {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;
  }

  static bool get isWeb {
    return kIsWeb;
  }

  static bool get isWindows {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;
  }

  static bool get isMobile => isAndroid || isIOS;
  static bool get isDesktop => isLinux || isMacOS || isWindows;

  static LunaPlatform get current {
    if (isWeb) return LunaPlatform.WEB;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return LunaPlatform.ANDROID;
      case TargetPlatform.iOS:
        return LunaPlatform.IOS;
      case TargetPlatform.linux:
        return LunaPlatform.LINUX;
      case TargetPlatform.macOS:
        return LunaPlatform.MACOS;
      case TargetPlatform.windows:
        return LunaPlatform.WINDOWS;
      default:
        throw UnsupportedError('Platform is not supported');
    }
  }

  String get name {
    switch (this) {
      case LunaPlatform.ANDROID:
        return 'Android';
      case LunaPlatform.IOS:
        return 'iOS';
      case LunaPlatform.LINUX:
        return 'Linux';
      case LunaPlatform.MACOS:
        return 'macOS';
      case LunaPlatform.WEB:
        return 'Web';
      case LunaPlatform.WINDOWS:
        return 'Windows';
    }
  }
}
