import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorAddDetailsState extends ChangeNotifier {
  final ReadarrAuthor series;
  bool canExecuteAction = false;

  ReadarrAuthorAddDetailsState({
    required this.series,
  });

  bool _monitored = true;
  bool get monitored => _monitored;
  set monitored(bool monitored) {
    _monitored = monitored;
    notifyListeners();
  }

  void initializeMonitored() {
    _monitored = ReadarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED.data ?? true;
  }

  late ReadarrAuthorMonitorType _monitorType;
  ReadarrAuthorMonitorType get monitorType => _monitorType;
  set monitorType(ReadarrAuthorMonitorType monitorType) {
    _monitorType = monitorType;
    notifyListeners();
  }

  void initializeMonitorType() {
    _monitorType = ReadarrAuthorMonitorType.values.firstWhere(
      (element) =>
          element.value ==
          ReadarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_TYPE.data,
      orElse: () => ReadarrAuthorMonitorType.ALL,
    );
  }

  late ReadarrRootFolder _rootFolder;
  ReadarrRootFolder get rootFolder => _rootFolder;
  set rootFolder(ReadarrRootFolder rootFolder) {
    _rootFolder = rootFolder;
    notifyListeners();
  }

  void initializeRootFolder(List<ReadarrRootFolder> rootFolders) {
    _rootFolder = rootFolders.firstWhere(
      (element) =>
          element.id ==
          ReadarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER.data,
      orElse: () => rootFolders.isNotEmpty
          ? rootFolders[0]
          : ReadarrRootFolder(id: -1, freeSpace: 0, path: LunaUI.TEXT_EMDASH),
    );
  }

  late ReadarrQualityProfile _qualityProfile;
  ReadarrQualityProfile get qualityProfile => _qualityProfile;
  set qualityProfile(ReadarrQualityProfile qualityProfile) {
    _qualityProfile = qualityProfile;
    notifyListeners();
  }

  void initializeQualityProfile(List<ReadarrQualityProfile> qualityProfiles) {
    _qualityProfile = qualityProfiles.firstWhere(
      (element) =>
          element.id ==
          ReadarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE.data,
      orElse: () => qualityProfiles.isNotEmpty
          ? qualityProfiles[0]
          : ReadarrQualityProfile(id: -1, name: LunaUI.TEXT_EMDASH),
    );
  }

  late ReadarrMetadataProfile _metadataProfile;
  ReadarrMetadataProfile get metadataProfile => _metadataProfile;
  set metadataProfile(ReadarrMetadataProfile metadataProfile) {
    _metadataProfile = metadataProfile;
    notifyListeners();
  }

  void initializeMetadataProfile(
      List<ReadarrMetadataProfile> metadataProfiles) {
    _metadataProfile = metadataProfiles.firstWhere(
      (element) =>
          element.id ==
          ReadarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE.data,
      orElse: () => metadataProfiles.isNotEmpty
          ? metadataProfiles[0]
          : ReadarrMetadataProfile(id: -1, name: LunaUI.TEXT_EMDASH),
    );
  }

  late List<ReadarrTag> _tags;
  List<ReadarrTag> get tags => _tags;
  set tags(List<ReadarrTag> tags) {
    _tags = tags;
    ReadarrDatabaseValue.ADD_SERIES_DEFAULT_TAGS
        .put(tags.map<int?>((tag) => tag.id).toList());
    notifyListeners();
  }

  void initializeTags(List<ReadarrTag> tags) {
    _tags = tags
        .where((tag) =>
            ((ReadarrDatabaseValue.ADD_SERIES_DEFAULT_TAGS.data as List?) ?? [])
                .contains(tag.id))
        .toList();
  }

  LunaLoadingState _state = LunaLoadingState.INACTIVE;
  LunaLoadingState get state => _state;
  set state(LunaLoadingState state) {
    _state = state;
    notifyListeners();
  }
}
