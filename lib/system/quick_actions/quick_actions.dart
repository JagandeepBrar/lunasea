// ignore: always_use_package_imports
import 'platform/quick_actions_stub.dart'
    if (dart.library.io) 'platform/quick_actions_io.dart'
    if (dart.library.html) 'platform/quick_actions_html.dart';

abstract class LunaQuickActions {
  static bool get isSupported => isPlatformSupported();
  factory LunaQuickActions() => getQuickActions();

  Future<void> initialize();
  void setActionItems();
  void actionHandler(String action);
}
