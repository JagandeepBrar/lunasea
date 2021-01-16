import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/main.dart';
import 'package:lunasea/modules/nzbget.dart';
import 'package:quick_actions/quick_actions.dart';

class NZBGetConstants {
    NZBGetConstants._();

    static const MODULE_KEY = 'nzbget';

    //ignore: non_constant_identifier_names
    static LunaModuleMetadata MODULE_METADATA = LunaModuleMetadata(
        name: 'NZBGet',
        description: 'Manage Usenet Downloads',
        settingsDescription: 'Configure NZBGet',
        helpMessage: 'NZBGet is a binary downloader, which downloads files from Usenet based on information given in nzb-files.',
        icon: CustomIcons.nzbget,
        route: '/nzbget',
        color: Color(0xFF42D535),
        website: 'https://nzbget.net',
        github: 'https://github.com/nzbget/nzbget',
        pushBaseRoute: () => LunaBIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(NZBGet.ROUTE_NAME, (Route<dynamic> route) => false),
        shortcutItem: ShortcutItem(type: MODULE_KEY, localizedTitle: 'NZBGet'),
    );
}
