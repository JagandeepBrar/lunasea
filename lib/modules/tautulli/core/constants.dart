import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliConstants {
    TautulliConstants._();

    static const _HELP_MESSAGE = '';
    static const String MODULE_KEY = 'tautulli';

    static const LunaModuleMap MODULE_MAP = LunaModuleMap(
        name: 'Tautulli',
        description: 'View Plex Activity',
        settingsDescription: 'Configure Tautulli',
        helpMessage: _HELP_MESSAGE,
        icon: CustomIcons.tautulli,
        route: '/tautulli',
        color: Color(0xFFDBA23A),
        website: 'https://tautulli.com',
        github: 'https://github.com/Tautulli/Tautulli',
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
    );
}
