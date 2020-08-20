import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliConstants {
    TautulliConstants._();

    static const String MODULE_KEY = 'tautulli';

    static const Map MODULE_MAP = {
        'name': 'Tautulli',
        'desc': 'View Plex Activity',
        'settings_desc': 'Configure Tautulli',
        'icon': CustomIcons.tautulli,
        'route': '/tautulli',
        'color': Color(0xFFDBA23A),
    };

    // ignore: non_constant_identifier_names
    static final Map<String, WidgetBuilder> MODULE_ROUTES = <String, WidgetBuilder>{
        //  /tautulli
        Tautulli.ROUTE_NAME: (context) => Tautulli(),
        //  /tautulli/*
        TautulliActivityRoute.ROUTE_NAME: (context) => TautulliActivityRoute(),
        TautulliHistoryRoute.ROUTE_NAME: (context) => TautulliHistoryRoute(),
        TautulliUsersRoute.ROUTE_NAME: (context) => TautulliUsersRoute(),
        TautulliMoreRoute.ROUTE_NAME: (context) => TautulliMoreRoute(),
        //  /tautulli/activity/*
        TautulliActivityDetailsRoute.ROUTE_NAME: (context) => TautulliActivityDetailsRoute(),
    };
}
