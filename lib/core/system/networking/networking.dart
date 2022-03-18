import 'platform/networking_stub.dart'
    if (dart.library.io) 'platform/networking_io.dart'
    if (dart.library.html) 'platform/networking_html.dart';

abstract class LunaNetworking {
  static bool get isSupported => isPlatformSupported();
  factory LunaNetworking() => getNetworking();

  void initialize();
}
