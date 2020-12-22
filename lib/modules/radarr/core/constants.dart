import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrConstants {
    RadarrConstants._();

    static const String MODULE_KEY = 'radarr';

    static const LunaModuleMetadata MODULE_METADATA = LunaModuleMetadata(
        name: 'Radarr',
        description: 'Manage Movies',
        settingsDescription: 'Configure Radarr',
        helpMessage: 'Radarr is a movie collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new movies and will interface with clients and indexers to grab, sort, and rename them. It can also be configured to automatically upgrade the quality of existing files in the library when a better quality format becomes available.',
        icon: CustomIcons.radarr,
        route: '/radarr',
        color: Color(0xFFFEC333),
        website: 'https://radarr.video',
        github: 'https://github.com/Radarr/Radarr',
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_METADATA.name,
    );

    static const Map EVENT_TYPE_MESSAGES = {
        'movieFileRenamed': 'Movie File Renamed',
        'movieFileDeleted': 'Movie File Deleted',
        'downloadFolderImported': 'Imported Movie File',
        'downloadFailed': 'Download Failed',
        'grabbed': 'Grabbed From',
    };

    // ignore: non_constant_identifier_names
    static final List<RadarrAvailability> MINIMUM_AVAILBILITIES = [
        RadarrAvailability(id: 'preDB', name: 'PreDB'),
        RadarrAvailability(id: 'announced', name: 'Announced'),
        RadarrAvailability(id: 'inCinemas', name: 'In Cinemas'),
        RadarrAvailability(id: 'released', name: 'Physical/Web'),
    ];
}