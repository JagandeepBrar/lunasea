import 'package:quick_actions/quick_actions.dart';
import 'package:lunasea/core/database/luna_database.dart';
import 'package:lunasea/core/modules.dart';
import 'package:lunasea/system/platform.dart';

// ignore: always_use_package_imports
import '../quick_actions.dart';

bool isPlatformSupported() => LunaPlatform().isMobile;
LunaQuickActions getQuickActions() {
  if (isPlatformSupported()) return IO();
  throw UnsupportedError('LunaQuickActions unsupported');
}

class IO implements LunaQuickActions {
  final QuickActions _quickActions = const QuickActions();

  @override
  Future<void> initialize() async {
    _quickActions.initialize(actionHandler);
    setActionItems();
  }

  @override
  void actionHandler(String action) {
    LunaModule.LIDARR.fromKey(action)?.launch();
  }

  @override
  void setActionItems() {
    _quickActions.setShortcutItems(<ShortcutItem>[
      if (LunaDatabaseValue.QUICK_ACTIONS_TAUTULLI.data)
        LunaModule.TAUTULLI.shortcutItem,
      if (LunaDatabaseValue.QUICK_ACTIONS_SONARR.data)
        LunaModule.SONARR.shortcutItem,
      if (LunaDatabaseValue.QUICK_ACTIONS_SEARCH.data)
        LunaModule.SEARCH.shortcutItem,
      if (LunaDatabaseValue.QUICK_ACTIONS_SABNZBD.data)
        LunaModule.SABNZBD.shortcutItem,
      if (LunaDatabaseValue.QUICK_ACTIONS_RADARR.data)
        LunaModule.RADARR.shortcutItem,
      if (LunaDatabaseValue.QUICK_ACTIONS_OVERSEERR.data)
        LunaModule.OVERSEERR.shortcutItem,
      if (LunaDatabaseValue.QUICK_ACTIONS_NZBGET.data)
        LunaModule.NZBGET.shortcutItem,
      if (LunaDatabaseValue.QUICK_ACTIONS_LIDARR.data)
        LunaModule.LIDARR.shortcutItem,
      LunaModule.SETTINGS.shortcutItem,
    ]);
  }
}
