import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/main.dart';
export 'package:quick_actions/quick_actions.dart' show ShortcutItem;

class HomescreenActions {
    static final QuickActions _quickActions = QuickActions();

    HomescreenActions._();

    static void initialize(BuildContext context) {
        _quickActions.initialize((action) => _handler(context, action));
        setShortcutItems();
    }

    static void setShortcutItems() {
        _quickActions.setShortcutItems(<ShortcutItem>[
            if(LunaSeaDatabaseValue.QUICK_ACTIONS_SEARCH.data) SearchConstants.MODULE_QUICK_ACTION,
            if(LunaSeaDatabaseValue.QUICK_ACTIONS_LIDARR.data) LidarrConstants.MODULE_QUICK_ACTION,
            if(LunaSeaDatabaseValue.QUICK_ACTIONS_RADARR.data) RadarrConstants.MODULE_QUICK_ACTION,
            if(LunaSeaDatabaseValue.QUICK_ACTIONS_SONARR.data) SonarrConstants.MODULE_QUICK_ACTION,
            if(LunaSeaDatabaseValue.QUICK_ACTIONS_NZBGET.data) NZBGetConstants.MODULE_QUICK_ACTION,
            if(LunaSeaDatabaseValue.QUICK_ACTIONS_SABNZBD.data) SABnzbdConstants.MODULE_QUICK_ACTION,
            if(LunaSeaDatabaseValue.QUICK_ACTIONS_TAUTULLI.data) TautulliConstants.MODULE_QUICK_ACTION,
        ]);
    }

    static void _handler(BuildContext context, String action) {
        if(action != null) {
            switch(action) {
                case SearchConstants.MODULE_KEY: _pushSearch(); break;
                case LidarrConstants.MODULE_KEY: _pushLidarr(); break;
                case RadarrConstants.MODULE_KEY: _pushRadarr(); break;
                case SonarrConstants.MODULE_KEY: _pushSonarr(); break;
                case NZBGetConstants.MODULE_KEY: _pushNZBGet(); break;
                case SABnzbdConstants.MODULE_KEY: _pushSABnzbd(); break;
                case TautulliConstants.MODULE_KEY: _pushTautulli(); break;
            }
        }
    }

    static void _pushSearch()   => BIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(Search.ROUTE_NAME, (Route<dynamic> route) => false);
    static void _pushLidarr()   => BIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(Lidarr.ROUTE_NAME, (Route<dynamic> route) => false);
    static void _pushRadarr()   => BIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(Radarr.ROUTE_NAME, (Route<dynamic> route) => false);
    static void _pushSonarr()   => BIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(Sonarr.ROUTE_NAME, (Route<dynamic> route) => false);
    static void _pushNZBGet()   => BIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(NZBGet.ROUTE_NAME, (Route<dynamic> route) => false);
    static void _pushSABnzbd()  => BIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(SABnzbd.ROUTE_NAME, (Route<dynamic> route) => false);
    static void _pushTautulli() => BIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(TautulliModule.ROUTE_NAME, (Route<dynamic> route) => false);
}
