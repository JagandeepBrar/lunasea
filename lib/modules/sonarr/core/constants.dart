import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrConstants {
    SonarrConstants._();

    static const String MODULE_KEY = 'sonarr';

    static const LunaModuleMap MODULE_MAP = LunaModuleMap(
        name: 'Sonarr',
        description: 'Manage Television Series',
        settingsDescription: 'Configure Sonarr',
        icon: CustomIcons.television,
        route: '/sonarr',
        color: Color(0xFF3FC6F4),
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
    );

    static const Map EVENT_TYPE_MESSAGES = {
        'episodeFileRenamed': 'Episode File Renamed',
        'episodeFileDeleted': 'Episode File Deleted',
        'downloadFolderImported': 'Imported Episode File',
        'downloadFailed': 'Download Failed',
        'grabbed': 'Grabbed From',
    };
    
    // ignore: non_constant_identifier_names
    static final List SERIES_TYPES = [
        SonarrSeriesType(type: 'anime'),
        SonarrSeriesType(type: 'daily'),
        SonarrSeriesType(type: 'standard'),
    ];
}