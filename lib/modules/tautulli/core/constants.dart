import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliConstants {
    TautulliConstants._();

    static const String MODULE_KEY = 'tautulli';

    static const ModuleMap MODULE_MAP = ModuleMap(
        name: 'Tautulli',
        description: 'View Plex Activity',
        settingsDescription: 'Configure Tautulli',
        icon: CustomIcons.tautulli,
        route: '/tautulli',
        color: Color(0xFFDBA23A),
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
    );

    // ignore: non_constant_identifier_names
    static final Map<String, WidgetBuilder> MODULE_ROUTES = <String, WidgetBuilder>{
        Tautulli.ROUTE_NAME: (context) => Tautulli(),
        // Activity
        TautulliActivityRoute.ROUTE_NAME: (context) => TautulliActivityRoute(),
        TautulliActivityDetailsRoute.ROUTE_NAME: (context) => TautulliActivityDetailsRoute(),
        // History
        TautulliHistoryRoute.ROUTE_NAME: (context) => TautulliHistoryRoute(),
        // Users
        TautulliUsersRoute.ROUTE_NAME: (context) => TautulliUsersRoute(),
        TautulliUserDetailsRoute.ROUTE_NAME: (context) => TautulliUserDetailsRoute(),
        // More
        TautulliMoreRoute.ROUTE_NAME: (context) => TautulliMoreRoute(),
        TautulliLogsRoute.ROUTE_NAME: (context) => TautulliLogsRoute(),
        TautulliSyncedItemsRoute.ROUTE_NAME: (context) => TautulliSyncedItemsRoute(),
    };
}
