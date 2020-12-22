import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsConstants {
    SettingsConstants._();

    static const String MODULE_KEY = 'settings';

    static const LunaModuleMetadata MODULE_METADATA = LunaModuleMetadata(
        name: 'Settings',
        description: 'Update Configuration',
        settingsDescription: '',
        helpMessage: '',
        icon: CustomIcons.settings,
        route: '/settings',
        color: Color(LunaColours.ACCENT_COLOR),
        website: '',
        github: '',
    );
}
