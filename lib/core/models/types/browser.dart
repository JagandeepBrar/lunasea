import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'browser.g.dart';

@HiveType(typeId: 11, adapterName: 'LunaBrowserAdapter')
enum LunaBrowser {
  @HiveField(0)
  APPLE_SAFARI,
  @HiveField(1)
  BRAVE_BROWSER,
  @HiveField(2)
  GOOGLE_CHROME,
  @HiveField(3)
  MICROSOFT_EDGE,
  @HiveField(4)
  MOZILLA_FIREFOX,
}

extension LunaBrowserExtension on LunaBrowser {
  String get name {
    switch (this) {
      case LunaBrowser.APPLE_SAFARI:
        return 'Apple Safari';
      case LunaBrowser.BRAVE_BROWSER:
        return 'Brave Browser';
      case LunaBrowser.GOOGLE_CHROME:
        return 'Google Chrome';
      case LunaBrowser.MICROSOFT_EDGE:
        return 'Microsoft Edge';
      case LunaBrowser.MOZILLA_FIREFOX:
        return 'Mozilla Firefox';
      default:
        return null;
    }
  }

  String get key {
    switch (this) {
      case LunaBrowser.APPLE_SAFARI:
        return 'applesafari';
      case LunaBrowser.BRAVE_BROWSER:
        return 'bravebrowser';
      case LunaBrowser.GOOGLE_CHROME:
        return 'googlechrome';
      case LunaBrowser.MICROSOFT_EDGE:
        return 'microsoftedge';
      case LunaBrowser.MOZILLA_FIREFOX:
        return 'mozillafirefox';
      default:
        return null;
    }
  }

  LunaBrowser fromKey(String key) {
    switch (key) {
      case 'applesafari':
        return LunaBrowser.APPLE_SAFARI;
      case 'bravebrowser':
        return LunaBrowser.BRAVE_BROWSER;
      case 'googlechrome':
        return LunaBrowser.GOOGLE_CHROME;
      case 'microsoftedge':
        return LunaBrowser.MICROSOFT_EDGE;
      case 'mozillafirefox':
        return LunaBrowser.MOZILLA_FIREFOX;
      default:
        return null;
    }
  }

  IconData get icon {
    switch (this) {
      case LunaBrowser.APPLE_SAFARI:
        return LunaIcons.safari;
      case LunaBrowser.BRAVE_BROWSER:
        return LunaIcons.bravebrowser;
      case LunaBrowser.GOOGLE_CHROME:
        return LunaIcons.chrome;
      case LunaBrowser.MICROSOFT_EDGE:
        return LunaIcons.microsoftedge;
      case LunaBrowser.MOZILLA_FIREFOX:
        return LunaIcons.firefox;
      default:
        return null;
    }
  }

  String formatted(String url) {
    bool isHttps = url.substring(0, min(8, url.length)) == 'https://';
    switch (this) {
      case LunaBrowser.BRAVE_BROWSER:
        return 'brave://open-url?url=$url';
      case LunaBrowser.GOOGLE_CHROME:
        return isHttps
            ? url.replaceFirst('https://', 'googlechromes://')
            : url.replaceFirst('http://', 'googlechrome://');
      case LunaBrowser.MICROSOFT_EDGE:
        return isHttps
            ? url.replaceFirst('https://', 'microsoft-edge-https://')
            : url.replaceFirst('http://', 'microsoft-edge-http://');
      case LunaBrowser.MOZILLA_FIREFOX:
        return 'firefox://open-url?url=$url';
      case LunaBrowser.APPLE_SAFARI:
      default:
        return url;
    }
  }
}
