import 'package:flutter/foundation.dart';

import '../filesystem.dart';
import 'platform_desktop.dart';
import 'platform_mobile.dart';

bool isPlatformSupported() {
  switch (defaultTargetPlatform) {
    // Mobile
    case TargetPlatform.android:
    case TargetPlatform.iOS:
    // Desktop
    case TargetPlatform.linux:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
      return true;
    default:
      return false;
  }
}

LunaFileSystem getFileSystem() {
  switch (defaultTargetPlatform) {
    // Mobile
    case TargetPlatform.android:
    case TargetPlatform.iOS:
      return Mobile();
    // Desktop
    case TargetPlatform.linux:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
      return Desktop();
    default:
      throw UnsupportedError('LunaFileSystem unsupported');
  }
}
