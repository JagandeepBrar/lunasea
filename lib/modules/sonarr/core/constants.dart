import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SonarrConstants {
    SonarrConstants._();

    static const _HELP_MESSAGE = '';
    static const String MODULE_KEY = 'sonarr';

    static const LunaModuleMap MODULE_MAP = LunaModuleMap(
        name: 'Sonarr',
        description: 'Manage Television Series',
        settingsDescription: 'Configure Sonarr',
        helpMessage: _HELP_MESSAGE,
        icon: CustomIcons.television,
        route: '/sonarr',
        color: Color(0xFF3FC6F4),
        website: 'https://sonarr.tv',
        github: 'https://github.com/Sonarr/Sonarr',
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
    );
}
