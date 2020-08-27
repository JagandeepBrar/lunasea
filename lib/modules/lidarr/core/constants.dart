import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LidarrConstants {
    LidarrConstants._();

    static const MODULE_KEY = 'lidarr';

    static const ModuleMap MODULE_MAP = ModuleMap(
        name: 'Lidarr',
        description: 'Manage Music',
        settingsDescription: 'Configure Lidarr',
        icon: CustomIcons.music,
        route: '/lidarr',
        color: Color(0xFF159552),
    );

    static const Map EVENT_TYPE_MESSAGES = {
        'trackFileRenamed': 'Track File Renamed',
        'trackFileDeleted': 'Track File Deleted',
        'trackFileImported': 'Track File Imported',
        'albumImportIncomplete': 'Album Import Incomplete',
        'downloadImported': 'Download Imported',
        'downloadFailed': 'Download Failed',
        'grabbed': 'Grabbed From',
    };

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
    );
}