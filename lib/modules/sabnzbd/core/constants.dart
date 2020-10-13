import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SABnzbdConstants {
    SABnzbdConstants._();

    static const String MODULE_KEY = 'sabnzbd';

    static const LunaModuleMap MODULE_MAP = LunaModuleMap(
        name: 'SABnzbd',
        description: 'Manage Usenet Downloads',
        settingsDescription: 'Configure SABnzbd',
        icon: CustomIcons.sabnzbd,
        route: '/sabnzbd',
        color: Color(0xFFFECC2B),
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
    );
}
