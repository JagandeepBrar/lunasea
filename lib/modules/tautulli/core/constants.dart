import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

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
}
