import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesEditState extends ChangeNotifier {
  MylarSeries? _series;
  MylarSeries? get series => _series;
  set series(MylarSeries? series) {
    _series = series;
    initializeMonitored();
    initializeUseSeasonFolders();
    initializeSeriesPath();
    initializeSeriesType();
  }

  bool canExecuteAction = false;

  LunaLoadingState _state = LunaLoadingState.INACTIVE;
  LunaLoadingState get state => _state;
  set state(LunaLoadingState state) {
    _state = state;
    notifyListeners();
  }

  bool _monitored = true;
  bool get monitored => _monitored;
  set monitored(bool monitored) {
    _monitored = monitored;
    notifyListeners();
  }

  void initializeMonitored() {
    _monitored = series!.monitored ?? false;
  }

  bool _useSeasonFolders = true;
  bool get useSeasonFolders => _useSeasonFolders;
  set useSeasonFolders(bool useSeasonFolders) {
    _useSeasonFolders = useSeasonFolders;
    notifyListeners();
  }

  void initializeUseSeasonFolders() {
    _useSeasonFolders = series!.seasonFolder ?? false;
  }

  String _seriesPath = '';
  String get seriesPath => _seriesPath;
  set seriesPath(String seriesPath) {
    _seriesPath = seriesPath;
    notifyListeners();
  }

  void initializeSeriesPath() {
    _seriesPath = series!.path ?? '';
  }

  MylarSeriesType? _seriesType;
  MylarSeriesType? get seriesType => _seriesType;
  set seriesType(MylarSeriesType? seriesType) {
    _seriesType = seriesType;
    notifyListeners();
  }

  void initializeSeriesType() {
    _seriesType = series!.seriesType ?? MylarSeriesType.STANDARD;
  }

  MylarQualityProfile? _qualityProfile;
  MylarQualityProfile? get qualityProfile => _qualityProfile;
  set qualityProfile(MylarQualityProfile? qualityProfile) {
    _qualityProfile = qualityProfile;
    notifyListeners();
  }

  void initializeQualityProfile(List<MylarQualityProfile> qualityProfiles) {
    _qualityProfile = qualityProfiles.firstWhere(
      (profile) => profile.id == series!.qualityProfileId,
      orElse: () => qualityProfiles[0],
    );
  }

  MylarLanguageProfile? _languageProfile;
  MylarLanguageProfile? get languageProfile => _languageProfile;
  set languageProfile(MylarLanguageProfile? languageProfile) {
    _languageProfile = languageProfile;
    notifyListeners();
  }

  void initializeLanguageProfile(List<MylarLanguageProfile> languageProfiles) {
    if (languageProfiles.isEmpty) return;
    _languageProfile = languageProfiles.firstWhere(
      (p) => p.id == series!.languageProfileId,
    );
  }

  List<MylarTag>? _tags;
  List<MylarTag>? get tags => _tags;
  set tags(List<MylarTag>? tags) {
    _tags = tags;
    notifyListeners();
  }

  void initializeTags(List<MylarTag> tags) {
    _tags = tags.where((tag) => (series!.tags ?? []).contains(tag.id)).toList();
  }
}
