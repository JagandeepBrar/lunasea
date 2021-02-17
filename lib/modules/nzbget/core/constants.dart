import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

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
        route: NZBGet.ROUTE_NAME,
        color: Color(0xFF42D535),
        website: 'https://nzbget.net',
        github: 'https://github.com/nzbget/nzbget',
        shortcutItem: ShortcutItem(type: MODULE_KEY, localizedTitle: 'NZBGet'),
    );
}
