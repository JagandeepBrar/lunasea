import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliConstants {
    TautulliConstants._();

    static const String MODULE_KEY = 'tautulli';

    static const LunaModuleMap MODULE_MAP = LunaModuleMap(
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
}
