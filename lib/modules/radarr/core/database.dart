import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart' hide RadarrDatabaseValueExtension;

class RadarrDatabase {
    RadarrDatabase._();

    static void registerAdapters() {
        Hive.registerAdapter(RadarrQualityProfileAdapter());
        Hive.registerAdapter(RadarrRootFolderAdapter());
        Hive.registerAdapter(RadarrAvailabilityAdapter());
    }
}

enum RadarrDatabaseValue {
    NAVIGATION_INDEX,
    ADD_MONITORED,
    ADD_QUALITY_PROFILE,
    ADD_ROOT_FOLDER,
    ADD_AVAILABILITY,
}

extension RadarrDatabaseValueExtension on RadarrDatabaseValue {
    String get key {
        switch(this) {
            case RadarrDatabaseValue.NAVIGATION_INDEX: return 'RADARR_NAVIGATION_INDEX';
            case RadarrDatabaseValue.ADD_MONITORED: return 'RADARR_ADD_MONITORED';
            case RadarrDatabaseValue.ADD_QUALITY_PROFILE: return 'RADARR_ADD_QUALITY_PROFILE';
            case RadarrDatabaseValue.ADD_ROOT_FOLDER: return 'RADARR_ADD_ROOT_FOLDER';
            case RadarrDatabaseValue.ADD_AVAILABILITY: return 'RADARR_ADD_AVAILABILITY';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case RadarrDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
            case RadarrDatabaseValue.ADD_MONITORED: return _box.get(this.key, defaultValue: true);
            case RadarrDatabaseValue.ADD_QUALITY_PROFILE: return _box.get(this.key);
            case RadarrDatabaseValue.ADD_ROOT_FOLDER: return _box.get(this.key);
            case RadarrDatabaseValue.ADD_AVAILABILITY: return _box.get(this.key);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
