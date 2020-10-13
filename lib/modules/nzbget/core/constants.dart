import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class NZBGetConstants {
    NZBGetConstants._();

    static const MODULE_KEY = 'nzbget';

    static const LunaModuleMap MODULE_MAP = LunaModuleMap(
        name: 'NZBGet',
        description: 'Manage Usenet Downloads',
        settingsDescription: 'Configure NZBGet',
        icon: CustomIcons.nzbget,
        route: '/nzbget',
        color: Color(0xFF42D535),
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
    );
}
