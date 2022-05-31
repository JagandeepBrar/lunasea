import 'package:lunasea/database/table.dart';
import 'package:lunasea/modules/lidarr/core/api/data/metadata.dart';
import 'package:lunasea/modules/lidarr/core/api/data/qualityprofile.dart';
import 'package:lunasea/modules/lidarr/core/api/data/rootfolder.dart';
import 'package:lunasea/vendor.dart';

enum LidarrDatabase<T> with LunaTableMixin<T> {
  NAVIGATION_INDEX<int>(0),
  ADD_MONITORED_STATUS<String>('all'),
  ADD_ARTIST_SEARCH_FOR_MISSING<bool>(true),
  ADD_ALBUM_FOLDERS<bool>(true),
  ADD_QUALITY_PROFILE<LidarrQualityProfile?>(null),
  ADD_METADATA_PROFILE<LidarrMetadataProfile?>(null),
  ADD_ROOT_FOLDER<LidarrRootFolder?>(null);

  @override
  String get table => TABLE_LIDARR_KEY;

  @override
  final T defaultValue;

  const LidarrDatabase(this.defaultValue);

  @override
  void registerAdapters() {
    Hive.registerAdapter(LidarrQualityProfileAdapter());
    Hive.registerAdapter(LidarrMetadataProfileAdapter());
    Hive.registerAdapter(LidarrRootFolderAdapter());
  }

  @override
  dynamic export() {
    if (this == LidarrDatabase.ADD_ALBUM_FOLDERS) return null;
    if (this == LidarrDatabase.ADD_QUALITY_PROFILE) return null;
    if (this == LidarrDatabase.ADD_METADATA_PROFILE) return null;
    if (this == LidarrDatabase.ADD_ROOT_FOLDER) return null;
    return super.export();
  }

  @override
  void import(dynamic value) {
    if (this == LidarrDatabase.ADD_ALBUM_FOLDERS) return;
    if (this == LidarrDatabase.ADD_QUALITY_PROFILE) return;
    if (this == LidarrDatabase.ADD_METADATA_PROFILE) return;
    if (this == LidarrDatabase.ADD_ROOT_FOLDER) return;
    return super.import(value);
  }
}
