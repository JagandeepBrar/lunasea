import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:lunasea/modules.dart';
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
                case SearchConstants.MODULE_KEY: _pushSearch(context); break;
                case LidarrConstants.MODULE_KEY: _pushLidarr(context); break;
                case RadarrConstants.MODULE_KEY: _pushRadarr(context); break;
                case SonarrConstants.MODULE_KEY: _pushSonarr(context); break;
                case NZBGetConstants.MODULE_KEY: _pushNZBGet(context); break;
                case SABnzbdConstants.MODULE_KEY: _pushSABnzbd(context); break;
                case TautulliConstants.MODULE_KEY: _pushTautulli(context); break;
            }
        }
    }

    static void _pushSearch(BuildContext context)   => Navigator.of(context).pushNamed(Search.ROUTE_NAME);
    static void _pushLidarr(BuildContext context)   => Navigator.of(context).pushNamed(Lidarr.ROUTE_NAME);
    static void _pushRadarr(BuildContext context)   => Navigator.of(context).pushNamed(Radarr.ROUTE_NAME);
    static void _pushSonarr(BuildContext context)   => Navigator.of(context).pushNamed(Sonarr.ROUTE_NAME);
    static void _pushNZBGet(BuildContext context)   => Navigator.of(context).pushNamed(NZBGet.ROUTE_NAME);
    static void _pushSABnzbd(BuildContext context)  => Navigator.of(context).pushNamed(SABnzbd.ROUTE_NAME);
    static void _pushTautulli(BuildContext context) => Navigator.of(context).pushNamed(TautulliModule.ROUTE_NAME);
}
