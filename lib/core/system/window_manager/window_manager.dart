import 'platform/window_manager_stub.dart'
    if (dart.library.io) 'platform/window_manager_io.dart'
    if (dart.library.html) 'platform/window_manager_html.dart';

abstract class LunaWindowManager {
  static const double MINIMUM_WINDOW_SIZE = 400;

  static bool get isSupported => isPlatformSupported();
  factory LunaWindowManager() => getWindowManager();

  Future<void> initialize();
  Future<void> setWindowTitle(String title);
}
