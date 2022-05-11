// ignore: always_use_package_imports
import 'platform/window_manager_stub.dart'
    if (dart.library.io) 'platform/window_manager_io.dart'
    if (dart.library.html) 'platform/window_manager_html.dart';

abstract class LunaWindowManager {
  // Need to change `windows/runner/main.cpp` and `linux/my_application.cc` manually if this wants to be changed
  static const double INITIAL_WINDOW_SIZE = 700;
  static const double MINIMUM_WINDOW_SIZE = 500;

  static bool get isSupported => isPlatformSupported();
  factory LunaWindowManager() => getWindowManager();

  Future<void> initialize();
  Future<void> setWindowTitle(String title);
}
