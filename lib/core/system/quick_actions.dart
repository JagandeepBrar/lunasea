import 'dart:io';
import 'package:lunasea/core.dart';
import 'package:quick_actions/quick_actions.dart';

class LunaQuickActions {
  static final QuickActions _quickActions = QuickActions();

  static bool get isPlatformCompatible => Platform.isAndroid || Platform.isIOS;

  /// Initialize the quick actions by setting the action handler.
  ///
  /// Required before the handler can actually receive any intents.
  void initialize() {
    if (isPlatformCompatible) _quickActions.initialize(_handler);
    setShortcutItems();
  }

  /// Sets the shortcut items by checking the database and enabling the respective action if enabled.
  void setShortcutItems() {
    if (isPlatformCompatible)
      _quickActions.setShortcutItems(<ShortcutItem>[
        if (LunaModule.SEARCH.isGloballyEnabled &&
            LunaDatabaseValue.QUICK_ACTIONS_SEARCH.data)
          LunaModule.SEARCH.shortcutItem,
        if (LunaModule.LIDARR.isGloballyEnabled &&
            LunaDatabaseValue.QUICK_ACTIONS_LIDARR.data)
          LunaModule.LIDARR.shortcutItem,
        if (LunaModule.RADARR.isGloballyEnabled &&
            LunaDatabaseValue.QUICK_ACTIONS_RADARR.data)
          LunaModule.RADARR.shortcutItem,
        if (LunaModule.SONARR.isGloballyEnabled &&
            LunaDatabaseValue.QUICK_ACTIONS_SONARR.data)
          LunaModule.SONARR.shortcutItem,
        if (LunaModule.NZBGET.isGloballyEnabled &&
            LunaDatabaseValue.QUICK_ACTIONS_NZBGET.data)
          LunaModule.NZBGET.shortcutItem,
        if (LunaModule.SABNZBD.isGloballyEnabled &&
            LunaDatabaseValue.QUICK_ACTIONS_SABNZBD.data)
          LunaModule.SABNZBD.shortcutItem,
        if (LunaModule.OVERSEERR.isGloballyEnabled &&
            LunaDatabaseValue.QUICK_ACTIONS_OVERSEERR.data)
          LunaModule.OVERSEERR.shortcutItem,
        if (LunaModule.TAUTULLI.isGloballyEnabled &&
            LunaDatabaseValue.QUICK_ACTIONS_TAUTULLI.data)
          LunaModule.TAUTULLI.shortcutItem,
        LunaModule.SETTINGS.shortcutItem,
      ]);
  }

  /// The actual shortcut command handler
  void _handler(String action) => LunaModule.LIDARR.fromKey(action)?.launch();
}
