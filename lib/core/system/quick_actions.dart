import 'package:lunasea/core.dart';
import 'package:quick_actions/quick_actions.dart';
export 'package:quick_actions/quick_actions.dart';

class LunaQuickActions {    
    static final QuickActions _quickActions = QuickActions();

    /// Initialize the quick actions by setting the action handler.
    /// 
    /// Required before the handler can actually receive any intents.
    void initialize() {
        _quickActions.initialize((action) => _handler(action));
        setShortcutItems();
    }

    /// Sets the shortcut items by checking the database and enabling the respective action if enabled.
    void setShortcutItems() {
        _quickActions.setShortcutItems(<ShortcutItem>[
            if(LunaDatabaseValue.QUICK_ACTIONS_SEARCH.data) LunaModule.SEARCH.shortcutItem,
            if(LunaDatabaseValue.QUICK_ACTIONS_LIDARR.data) LunaModule.LIDARR.shortcutItem,
            if(LunaDatabaseValue.QUICK_ACTIONS_RADARR.data) LunaModule.RADARR.shortcutItem,
            if(LunaDatabaseValue.QUICK_ACTIONS_SONARR.data) LunaModule.SONARR.shortcutItem,
            if(LunaDatabaseValue.QUICK_ACTIONS_NZBGET.data) LunaModule.NZBGET.shortcutItem,
            if(LunaDatabaseValue.QUICK_ACTIONS_SABNZBD.data) LunaModule.SABNZBD.shortcutItem,
            if(LunaDatabaseValue.QUICK_ACTIONS_TAUTULLI.data) LunaModule.TAUTULLI.shortcutItem,
            LunaModule.SETTINGS.shortcutItem,
        ]);
    }

    /// The actual shortcut command handler
    void _handler(String action) => LunaModule.LIDARR.fromKey(action)?.launch();
}
