import 'package:hive/hive.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrDatabase {
    RadarrDatabase._();

    static void registerAdapters() {
        Hive.registerAdapter(RadarrQualityProfileAdapter());
        Hive.registerAdapter(RadarrRootFolderAdapter());
        Hive.registerAdapter(RadarrAvailabilityAdapter());
    }
}

enum RadarrDatabaseValue {
    ADD_MONITORED,
    ADD_QUALITY_PROFILE,
    ADD_ROOT_FOLDER,
    ADD_AVAILABILITY,
}

extension RadarrDatabaseValueExtension on RadarrDatabaseValue {
    String get key {
        switch(this) {
            case RadarrDatabaseValue.ADD_MONITORED: return 'RADARR_ADD_MONITORED';
            case RadarrDatabaseValue.ADD_QUALITY_PROFILE: return 'RADARR_ADD_QUALITY_PROFILE';
            case RadarrDatabaseValue.ADD_ROOT_FOLDER: return 'RADARR_ADD_ROOT_FOLDER';
            case RadarrDatabaseValue.ADD_AVAILABILITY: return 'RADARR_ADD_AVAILABILITY';
        }
        return '';
    }
}
