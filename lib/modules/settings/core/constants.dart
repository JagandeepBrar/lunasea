import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/main.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:quick_actions/quick_actions.dart';

class SettingsConstants {
    SettingsConstants._();

    static const MODULE_KEY = 'settings';

    //ignore: non_constant_identifier_names
    static LunaModuleMetadata MODULE_METADATA = LunaModuleMetadata(
        name: 'Settings',
        description: 'Update Configuration',
        settingsDescription: '',
        helpMessage: '',
        icon: CustomIcons.settings,
        route: '/settings',
        color: Color(LunaColours.ACCENT_COLOR),
        website: '',
        github: '',
        pushBaseRoute: () => LunaBIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(SettingsHomeRouter().route(), (Route<dynamic> route) => false),
        shortcutItem: ShortcutItem(type: MODULE_KEY, localizedTitle: 'Settings'),
    );
}
