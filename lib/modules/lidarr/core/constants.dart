import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LidarrConstants {
    LidarrConstants._();

    static const String MODULE_KEY = 'lidarr';

    static const Map MODULE_MAP = {
        'name': 'Lidarr',
        'desc': 'Manage Music',
        'icon': CustomIcons.music,
        'route': '/lidarr',
        'color': Color(0xFF159552),
    };

    static const Map EVENT_TYPE_MESSAGES = {
        'trackFileRenamed': 'Track File Renamed',
        'trackFileDeleted': 'Track File Deleted',
        'trackFileImported': 'Track File Imported',
        'albumImportIncomplete': 'Album Import Incomplete',
        'downloadImported': 'Download Imported',
        'downloadFailed': 'Download Failed',
        'grabbed': 'Grabbed From',
    };
}