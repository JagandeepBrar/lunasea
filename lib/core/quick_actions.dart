import 'package:lunasea/core.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:lunasea/modules.dart';

class LunaQuickActions {
    LunaQuickActions._();
    
    static final QuickActions _quickActions = QuickActions();

    /// Initialize the quick actions by setting the action handler.
    /// 
    /// Required before the handler can actually receive any intents.
    static void initialize() {
        _quickActions.initialize((action) => _handler(action));
        setShortcutItems();
    }

    /// Sets the shortcut items by checking the database and enabling the respective action if enabled.
    static void setShortcutItems() {
        _quickActions.setShortcutItems(<ShortcutItem>[
            if(LunaDatabaseValue.QUICK_ACTIONS_SEARCH.data) SearchConstants.MODULE_METADATA.shortcutItem,
            if(LunaDatabaseValue.QUICK_ACTIONS_LIDARR.data) LidarrConstants.MODULE_METADATA.shortcutItem,
            if(LunaDatabaseValue.QUICK_ACTIONS_RADARR.data) RadarrConstants.MODULE_METADATA.shortcutItem,
            if(LunaDatabaseValue.QUICK_ACTIONS_SONARR.data) SonarrConstants.MODULE_METADATA.shortcutItem,
            if(LunaDatabaseValue.QUICK_ACTIONS_NZBGET.data) NZBGetConstants.MODULE_METADATA.shortcutItem,
            if(LunaDatabaseValue.QUICK_ACTIONS_SABNZBD.data) SABnzbdConstants.MODULE_METADATA.shortcutItem,
            if(LunaDatabaseValue.QUICK_ACTIONS_TAUTULLI.data) TautulliConstants.MODULE_METADATA.shortcutItem,
        ]);
    }

    /// The actual shortcut command handler
    static void _handler(String action) {
        if(action != null) {
            switch(action) {
                case SearchConstants.MODULE_KEY: SearchConstants.MODULE_METADATA.pushBaseRoute(); break;
                case LidarrConstants.MODULE_KEY: LidarrConstants.MODULE_METADATA.pushBaseRoute(); break;
                case RadarrConstants.MODULE_KEY: RadarrConstants.MODULE_METADATA.pushBaseRoute(); break;
                case SonarrConstants.MODULE_KEY: SonarrConstants.MODULE_METADATA.pushBaseRoute(); break;
                case NZBGetConstants.MODULE_KEY: NZBGetConstants.MODULE_METADATA.pushBaseRoute(); break;
                case SABnzbdConstants.MODULE_KEY: SABnzbdConstants.MODULE_METADATA.pushBaseRoute(); break;
                case TautulliConstants.MODULE_KEY: TautulliConstants.MODULE_METADATA.pushBaseRoute(); break;
            }
        }
    }
}
