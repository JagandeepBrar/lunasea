import 'package:hive/hive.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDatabase {
    LidarrDatabase._();

    static void registerAdapters() {
        Hive.registerAdapter(LidarrQualityProfileAdapter());
        Hive.registerAdapter(LidarrMetadataProfileAdapter());
        Hive.registerAdapter(LidarrRootFolderAdapter());
    }
}

enum LidarrDatabaseValue {
    ADD_MONITORED,
    ADD_ALBUM_FOLDERS,
    ADD_QUALITY_PROFILE,
    ADD_METADATA_PROFILE,
    ADD_ROOT_FOLDER,
}

extension LidarrDatabaseValueExtension on LidarrDatabaseValue {
    String get key {
        switch(this) {
            case LidarrDatabaseValue.ADD_MONITORED: return 'LIDARR_ADD_MONITORED';
            case LidarrDatabaseValue.ADD_ALBUM_FOLDERS: return 'LIDARR_ADD_ALBUM_FOLDERS';
            case LidarrDatabaseValue.ADD_QUALITY_PROFILE: return 'LIDARR_ADD_QUALITY_PROFILE';
            case LidarrDatabaseValue.ADD_METADATA_PROFILE: return 'LIDARR_ADD_METADATA_PROFILE';
            case LidarrDatabaseValue.ADD_ROOT_FOLDER: return 'LIDARR_ADD_ROOT_FOLDER';
        }
        return '';
    }
}
