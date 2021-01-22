import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrConstants {
    SonarrConstants._();

    static const MODULE_KEY = 'sonarr';

    //ignore: non_constant_identifier_names
    static LunaModuleMetadata MODULE_METADATA = LunaModuleMetadata(
        name: 'Sonarr',
        description: 'Manage Television Series',
        settingsDescription: 'Configure Sonarr',
        helpMessage: 'Sonarr is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.',
        icon: CustomIcons.television,
        route: SonarrHomeRouter.route(),
        color: Color(0xFF3FC6F4),
        website: 'https://sonarr.tv',
        github: 'https://github.com/Sonarr/Sonarr',
        shortcutItem: ShortcutItem(type: MODULE_KEY, localizedTitle: 'Sonarr'),
    );
}
