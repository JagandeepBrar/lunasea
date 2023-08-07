import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesAddDetailsState extends ChangeNotifier {
  final MylarSeries series;
  bool canExecuteAction = false;

  MylarSeriesAddDetailsState({
    required this.series,
  });

  bool _monitored = true;
  bool get monitored => _monitored;
  set monitored(bool monitored) {
    _monitored = monitored;
    notifyListeners();
  }

  void initializeMonitored() {
    _monitored = MylarDatabase.ADD_SERIES_DEFAULT_MONITORED.read();
  }

  bool _useSeasonFolders = true;
  bool get useSeasonFolders => _useSeasonFolders;
  set useSeasonFolders(bool useSeasonFolders) {
    _useSeasonFolders = useSeasonFolders;
    notifyListeners();
  }

  void initializeUseSeasonFolders() {
    _useSeasonFolders =
        MylarDatabase.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS.read();
  }

  late MylarSeriesType _seriesType;
  MylarSeriesType get seriesType => _seriesType;
  set seriesType(MylarSeriesType seriesType) {
    _seriesType = seriesType;
    notifyListeners();
  }

  void initializeSeriesType() {
    _seriesType = MylarSeriesType.values.firstWhere(
      (element) =>
          element.value == MylarDatabase.ADD_SERIES_DEFAULT_SERIES_TYPE.read(),
      orElse: () => MylarSeriesType.STANDARD,
    );
  }

  late MylarSeriesMonitorType _monitorType;
  MylarSeriesMonitorType get monitorType => _monitorType;
  set monitorType(MylarSeriesMonitorType monitorType) {
    _monitorType = monitorType;
    notifyListeners();
  }

  void initializeMonitorType() {
    _monitorType = MylarSeriesMonitorType.values.firstWhere(
      (element) =>
          element.value ==
          MylarDatabase.ADD_SERIES_DEFAULT_MONITOR_TYPE.read(),
      orElse: () => MylarSeriesMonitorType.ALL,
    );
  }

  late MylarRootFolder _rootFolder;
  MylarRootFolder get rootFolder => _rootFolder;
  set rootFolder(MylarRootFolder rootFolder) {
    _rootFolder = rootFolder;
    notifyListeners();
  }

  void initializeRootFolder(List<MylarRootFolder> rootFolders) {
    _rootFolder = rootFolders.firstWhere(
      (element) =>
          element.id == MylarDatabase.ADD_SERIES_DEFAULT_ROOT_FOLDER.read(),
      orElse: () => rootFolders.isNotEmpty
          ? rootFolders[0]
          : MylarRootFolder(id: -1, freeSpace: 0, path: LunaUI.TEXT_EMDASH),
    );
  }

  late MylarQualityProfile _qualityProfile;
  MylarQualityProfile get qualityProfile => _qualityProfile;
  set qualityProfile(MylarQualityProfile qualityProfile) {
    _qualityProfile = qualityProfile;
    notifyListeners();
  }

  void initializeQualityProfile(List<MylarQualityProfile> qualityProfiles) {
    _qualityProfile = qualityProfiles.firstWhere(
      (element) =>
          element.id ==
          MylarDatabase.ADD_SERIES_DEFAULT_QUALITY_PROFILE.read(),
      orElse: () => qualityProfiles.isNotEmpty
          ? qualityProfiles[0]
          : MylarQualityProfile(id: -1, name: LunaUI.TEXT_EMDASH),
    );
  }

  late MylarLanguageProfile _languageProfile;
  MylarLanguageProfile get languageProfile => _languageProfile;
  set languageProfile(MylarLanguageProfile languageProfile) {
    _languageProfile = languageProfile;
    notifyListeners();
  }

  void initializeLanguageProfile(List<MylarLanguageProfile> languageProfiles) {
    _languageProfile = languageProfiles.firstWhere(
      (element) =>
          element.id ==
          MylarDatabase.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE.read(),
      orElse: () => languageProfiles.isNotEmpty
          ? languageProfiles[0]
          : MylarLanguageProfile(id: -1, name: LunaUI.TEXT_EMDASH),
    );
  }

  late List<MylarTag> _tags;
  List<MylarTag> get tags => _tags;
  set tags(List<MylarTag> tags) {
    _tags = tags;
    MylarDatabase.ADD_SERIES_DEFAULT_TAGS
        .update(tags.map<int?>((tag) => tag.id).toList());
    notifyListeners();
  }

  void initializeTags(List<MylarTag> tags) {
    _tags = tags
        .where((tag) =>
            (MylarDatabase.ADD_SERIES_DEFAULT_TAGS.read()).contains(tag.id))
        .toList();
  }

  LunaLoadingState _state = LunaLoadingState.INACTIVE;
  LunaLoadingState get state => _state;
  set state(LunaLoadingState state) {
    _state = state;
    notifyListeners();
  }
}
