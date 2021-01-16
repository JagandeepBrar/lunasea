import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/main.dart';
import 'package:lunasea/modules/home.dart';
import 'package:quick_actions/quick_actions.dart';

class HomeConstants {
    HomeConstants._();

    static const MODULE_KEY = 'home';

    //ignore: non_constant_identifier_names
    static LunaModuleMetadata MODULE_METADATA = LunaModuleMetadata(
        name: 'Home',
        description: 'Home',
        settingsDescription: 'Configure the Home Screen',
        helpMessage: '',
        icon: CustomIcons.home,
        route: '/',
        color: Color(LunaColours.ACCENT_COLOR),
        website: '',
        github: '',
        pushBaseRoute: () => LunaBIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(Home.ROUTE_NAME, (Route<dynamic> route) => false),
        shortcutItem: ShortcutItem(type: MODULE_KEY, localizedTitle: 'Home'),
    );
}
