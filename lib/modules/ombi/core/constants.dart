import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class OmbiConstants {
    OmbiConstants._();

    static const String MODULE_KEY = 'ombi';

    static const LunaModuleMap MODULE_MAP = LunaModuleMap(
        name: 'Ombi',
        description: 'Manage Requests for Media',
        settingsDescription: 'Configure Ombi',
        icon: CustomIcons.tautulli,
        route: '/ombi',
        color: Color(0xFFD4782C),
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
    );
}
