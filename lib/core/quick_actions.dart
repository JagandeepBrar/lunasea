import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/main.dart';
export 'package:quick_actions/quick_actions.dart' show ShortcutItem;

class LunaQuickActions {
    LunaQuickActions._();
    
    static final QuickActions _quickActions = QuickActions();

    /// Initialize the quick actions by setting the action handler.
    /// 
    /// Required before the handler can actually receive any intents.
    static void initialize(BuildContext context) {
        _quickActions.initialize((action) => _handler(context, action));
        setShortcutItems();
    }

    /// Sets the shortcut items by checking the database and enabling the respective action if enabled.
    static void setShortcutItems() {
        _quickActions.setShortcutItems(<ShortcutItem>[
            // General
            if(LunaDatabaseValue.QUICK_ACTIONS_SEARCH.data) SearchConstants.MODULE_QUICK_ACTION,
            // Automation
            if(LunaDatabaseValue.QUICK_ACTIONS_LIDARR.data) LidarrConstants.MODULE_QUICK_ACTION,
            if(LunaDatabaseValue.QUICK_ACTIONS_RADARR.data) RadarrConstants.MODULE_QUICK_ACTION,
            if(LunaDatabaseValue.QUICK_ACTIONS_SONARR.data) SonarrConstants.MODULE_QUICK_ACTION,
            // Clients
            if(LunaDatabaseValue.QUICK_ACTIONS_NZBGET.data) NZBGetConstants.MODULE_QUICK_ACTION,
            if(LunaDatabaseValue.QUICK_ACTIONS_SABNZBD.data) SABnzbdConstants.MODULE_QUICK_ACTION,
            // Monitoring
            if(LunaDatabaseValue.QUICK_ACTIONS_TAUTULLI.data) TautulliConstants.MODULE_QUICK_ACTION,
        ]);
    }

    /// The actual shortcut command handler
    static void _handler(BuildContext context, String action) {
        if(action != null) {
            switch(action) {
                // General
                case SearchConstants.MODULE_KEY: _pushSearch(); break;
                // Automation
                case LidarrConstants.MODULE_KEY: _pushLidarr(); break;
                case RadarrConstants.MODULE_KEY: _pushRadarr(); break;
                case SonarrConstants.MODULE_KEY: _pushSonarr(); break;
                // Clients
                case NZBGetConstants.MODULE_KEY: _pushNZBGet(); break;
                case SABnzbdConstants.MODULE_KEY: _pushSABnzbd(); break;
                // Monitoring
                case TautulliConstants.MODULE_KEY: _pushTautulli(); break;
            }
        }
    }

    // General
    static void _pushSearch() => LunaBIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(Search.ROUTE_NAME, (Route<dynamic> route) => false);
    // Automation
    static void _pushLidarr() => LunaBIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(Lidarr.ROUTE_NAME, (Route<dynamic> route) => false);
    static void _pushRadarr() => LunaBIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(RadarrHomeRouter.route(), (Route<dynamic> route) => false);
    static void _pushSonarr() => LunaBIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(SonarrHomeRouter.route(), (Route<dynamic> route) => false);
    // Clients
    static void _pushNZBGet() => LunaBIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(NZBGet.ROUTE_NAME, (Route<dynamic> route) => false);
    static void _pushSABnzbd() => LunaBIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(SABnzbd.ROUTE_NAME, (Route<dynamic> route) => false);
    // Monitoring
    static void _pushTautulli() => LunaBIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(TautulliHomeRouter.route(), (Route<dynamic> route) => false);
}
