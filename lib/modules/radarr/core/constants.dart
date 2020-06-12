import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrConstants {
    RadarrConstants._();

    static const String MODULE_KEY = 'radarr';

    static const Map MODULE_MAP = {
        'name': 'Radarr',
        'desc': 'Manage Movies',
        'icon': CustomIcons.movies,
        'route': '/radarr',
    };

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