import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrConstants {
    RadarrConstants._();

    static const String MODULE_KEY = 'radarr';

    static const ModuleMap MODULE_MAP = ModuleMap(
        name: 'Radarr',
        description: 'Manage Movies',
        settingsDescription: 'Configure Radarr',
        icon: CustomIcons.movies,
        route: '/radarr',
        color: Color(0xFFFEC333),
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
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