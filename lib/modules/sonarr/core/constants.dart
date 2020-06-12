import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrConstants {
    SonarrConstants._();

    static const String MODULE_KEY = 'sonarr';

    static const Map MODULE_MAP = {
        'name': 'Sonarr',
        'desc': 'Manage Television Series',
        'icon': CustomIcons.television,
        'route': '/sonarr',
    };

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