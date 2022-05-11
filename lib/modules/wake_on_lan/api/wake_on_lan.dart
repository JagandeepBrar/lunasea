// ignore: always_use_package_imports
import 'platform/wake_on_lan_stub.dart'
    if (dart.library.io) 'platform/wake_on_lan_io.dart'
    if (dart.library.html) 'platform/wake_on_lan_html.dart';

abstract class LunaWakeOnLAN {
  static bool get isSupported => isPlatformSupported();
  factory LunaWakeOnLAN() => getWakeOnLAN();

  Future<void> wake();
}
