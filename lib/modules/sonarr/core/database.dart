import 'package:hive/hive.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrDatabase {
    SonarrDatabase._();

    static void registerAdapters() {
        Hive.registerAdapter(SonarrQualityProfileAdapter());
        Hive.registerAdapter(SonarrRootFolderAdapter());
        Hive.registerAdapter(SonarrSeriesTypeAdapter());
    }
}

enum SonarrDatabaseValue {
    ADD_QUALITY_PROFILE,
    ADD_ROOT_FOLDER,
    ADD_SERIES_TYPE,
}

extension SonarrDatabaseValueExtension on SonarrDatabaseValue {
    String get key {
        switch(this) {
            case SonarrDatabaseValue.ADD_QUALITY_PROFILE: return 'SONARR_ADD_QUALITY_PROFILE';
            case SonarrDatabaseValue.ADD_ROOT_FOLDER: return 'SONARR_ADD_ROOT_FOLDER';
            case SonarrDatabaseValue.ADD_SERIES_TYPE: return 'SONARR_ADD_SERIES_TYPE';
        }
        return '';
    }
}
