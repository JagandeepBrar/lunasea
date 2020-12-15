import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class HomeConstants {
    HomeConstants._();

    static const MODULE_KEY = 'home';

    static const LunaModuleMap MODULE_MAP = LunaModuleMap(
        name: 'Home',
        description: 'Home',
        settingsDescription: 'Configure the Home Screen',
        helpMessage: '',
        icon: CustomIcons.home,
        route: '/',
        color: Color(LunaColours.ACCENT_COLOR),
        website: '',
        github: '',
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
    );
}
