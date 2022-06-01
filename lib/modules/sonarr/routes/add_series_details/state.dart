import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsState extends ChangeNotifier {
  final SonarrSeries series;
  bool canExecuteAction = false;

  SonarrSeriesAddDetailsState({
    required this.series,
  });

  bool _monitored = true;
  bool get monitored => _monitored;
  set monitored(bool monitored) {
    _monitored = monitored;
    notifyListeners();
  }

  void initializeMonitored() {
    _monitored = SonarrDatabase.ADD_SERIES_DEFAULT_MONITORED.read();
  }

  bool _useSeasonFolders = true;
  bool get useSeasonFolders => _useSeasonFolders;
  set useSeasonFolders(bool useSeasonFolders) {
    _useSeasonFolders = useSeasonFolders;
    notifyListeners();
  }

  void initializeUseSeasonFolders() {
    _useSeasonFolders =
        SonarrDatabase.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS.read();
  }

  late SonarrSeriesType _seriesType;
  SonarrSeriesType get seriesType => _seriesType;
  set seriesType(SonarrSeriesType seriesType) {
    _seriesType = seriesType;
    notifyListeners();
  }

  void initializeSeriesType() {
    _seriesType = SonarrSeriesType.values.firstWhere(
      (element) =>
          element.value == SonarrDatabase.ADD_SERIES_DEFAULT_SERIES_TYPE.read(),
      orElse: () => SonarrSeriesType.STANDARD,
    );
  }

  late SonarrSeriesMonitorType _monitorType;
  SonarrSeriesMonitorType get monitorType => _monitorType;
  set monitorType(SonarrSeriesMonitorType monitorType) {
    _monitorType = monitorType;
    notifyListeners();
  }

  void initializeMonitorType() {
    _monitorType = SonarrSeriesMonitorType.values.firstWhere(
      (element) =>
          element.value ==
          SonarrDatabase.ADD_SERIES_DEFAULT_MONITOR_TYPE.read(),
      orElse: () => SonarrSeriesMonitorType.ALL,
    );
  }

  late SonarrRootFolder _rootFolder;
  SonarrRootFolder get rootFolder => _rootFolder;
  set rootFolder(SonarrRootFolder rootFolder) {
    _rootFolder = rootFolder;
    notifyListeners();
  }

  void initializeRootFolder(List<SonarrRootFolder> rootFolders) {
    _rootFolder = rootFolders.firstWhere(
      (element) =>
          element.id == SonarrDatabase.ADD_SERIES_DEFAULT_ROOT_FOLDER.read(),
      orElse: () => rootFolders.isNotEmpty
          ? rootFolders[0]
          : SonarrRootFolder(id: -1, freeSpace: 0, path: LunaUI.TEXT_EMDASH),
    );
  }

  late SonarrQualityProfile _qualityProfile;
  SonarrQualityProfile get qualityProfile => _qualityProfile;
  set qualityProfile(SonarrQualityProfile qualityProfile) {
    _qualityProfile = qualityProfile;
    notifyListeners();
  }

  void initializeQualityProfile(List<SonarrQualityProfile> qualityProfiles) {
    _qualityProfile = qualityProfiles.firstWhere(
      (element) =>
          element.id ==
          SonarrDatabase.ADD_SERIES_DEFAULT_QUALITY_PROFILE.read(),
      orElse: () => qualityProfiles.isNotEmpty
          ? qualityProfiles[0]
          : SonarrQualityProfile(id: -1, name: LunaUI.TEXT_EMDASH),
    );
  }

  late SonarrLanguageProfile _languageProfile;
  SonarrLanguageProfile get languageProfile => _languageProfile;
  set languageProfile(SonarrLanguageProfile languageProfile) {
    _languageProfile = languageProfile;
    notifyListeners();
  }

  void initializeLanguageProfile(List<SonarrLanguageProfile> languageProfiles) {
    _languageProfile = languageProfiles.firstWhere(
      (element) =>
          element.id ==
          SonarrDatabase.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE.read(),
      orElse: () => languageProfiles.isNotEmpty
          ? languageProfiles[0]
          : SonarrLanguageProfile(id: -1, name: LunaUI.TEXT_EMDASH),
    );
  }

  late List<SonarrTag> _tags;
  List<SonarrTag> get tags => _tags;
  set tags(List<SonarrTag> tags) {
    _tags = tags;
    SonarrDatabase.ADD_SERIES_DEFAULT_TAGS
        .update(tags.map<int?>((tag) => tag.id).toList());
    notifyListeners();
  }

  void initializeTags(List<SonarrTag> tags) {
    _tags = tags
        .where((tag) =>
            (SonarrDatabase.ADD_SERIES_DEFAULT_TAGS.read()).contains(tag.id))
        .toList();
  }

  LunaLoadingState _state = LunaLoadingState.INACTIVE;
  LunaLoadingState get state => _state;
  set state(LunaLoadingState state) {
    _state = state;
    notifyListeners();
  }
}
