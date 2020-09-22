import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsConstants {
    SettingsConstants._();

    static const String MODULE_KEY = 'settings';

    static const ModuleMap MODULE_MAP = ModuleMap(
        name: 'Settings',
        description: 'Update Configuration',
        settingsDescription: '',
        icon: CustomIcons.settings,
        route: '/settings',
        color: Color(LunaColours.ACCENT_COLOR),
    );
}
