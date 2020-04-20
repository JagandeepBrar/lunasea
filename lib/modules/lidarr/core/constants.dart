import 'package:lunasea/core.dart';

class LidarrConstants {
    LidarrConstants._();

    static const Map SERVICE_MAP = {
        'name': 'Lidarr',
        'desc': 'Manage Music',
        'icon': CustomIcons.music,
        'route': '/lidarr',
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