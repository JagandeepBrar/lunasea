import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart' hide LidarrDatabaseValueExtension;

class LidarrDatabase {
    LidarrDatabase._();

    static void registerAdapters() {
        Hive.registerAdapter(LidarrQualityProfileAdapter());
        Hive.registerAdapter(LidarrMetadataProfileAdapter());
        Hive.registerAdapter(LidarrRootFolderAdapter());
    }
}

enum LidarrDatabaseValue {
    NAVIGATION_INDEX,
    ADD_MONITORED,
    ADD_ALBUM_FOLDERS,
    ADD_QUALITY_PROFILE,
    ADD_METADATA_PROFILE,
    ADD_ROOT_FOLDER,
}

extension LidarrDatabaseValueExtension on LidarrDatabaseValue {
    String get key {
        switch(this) {
            case LidarrDatabaseValue.NAVIGATION_INDEX: return 'LIDARR_NAVIGATION_INDEX';
            case LidarrDatabaseValue.ADD_MONITORED: return 'LIDARR_ADD_MONITORED';
            case LidarrDatabaseValue.ADD_ALBUM_FOLDERS: return 'LIDARR_ADD_ALBUM_FOLDERS';
            case LidarrDatabaseValue.ADD_QUALITY_PROFILE: return 'LIDARR_ADD_QUALITY_PROFILE';
            case LidarrDatabaseValue.ADD_METADATA_PROFILE: return 'LIDARR_ADD_METADATA_PROFILE';
            case LidarrDatabaseValue.ADD_ROOT_FOLDER: return 'LIDARR_ADD_ROOT_FOLDER';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case LidarrDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
            case LidarrDatabaseValue.ADD_MONITORED: return _box.get(this.key, defaultValue: true);
            case LidarrDatabaseValue.ADD_ALBUM_FOLDERS: return _box.get(this.key, defaultValue: true);
            case LidarrDatabaseValue.ADD_QUALITY_PROFILE: return _box.get(this.key);
            case LidarrDatabaseValue.ADD_METADATA_PROFILE: return _box.get(this.key);
            case LidarrDatabaseValue.ADD_ROOT_FOLDER: return _box.get(this.key);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
