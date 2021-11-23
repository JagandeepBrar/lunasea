import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditState extends ChangeNotifier {
  SonarrSeries _series;
  SonarrSeries get series => _series;
  set series(SonarrSeries series) {
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
    assert(state != null);
    _state = state;
    notifyListeners();
  }

  bool _monitored = true;
  bool get monitored => _monitored;
  set monitored(bool monitored) {
    assert(monitored != null);
    _monitored = monitored;
    notifyListeners();
  }

  void initializeMonitored() {
    _monitored = series.monitored ?? false;
  }

  bool _useSeasonFolders = true;
  bool get useSeasonFolders => _useSeasonFolders;
  set useSeasonFolders(bool useSeasonFolders) {
    assert(useSeasonFolders != null);
    _useSeasonFolders = useSeasonFolders;
    notifyListeners();
  }

  void initializeUseSeasonFolders() {
    _useSeasonFolders = series.seasonFolder ?? false;
  }

  String _seriesPath = '';
  String get seriesPath => _seriesPath;
  set seriesPath(String seriesPath) {
    assert(seriesPath != null);
    _seriesPath = seriesPath;
    notifyListeners();
  }

  void initializeSeriesPath() {
    _seriesPath = series.path ?? '';
  }

  SonarrSeriesType _seriesType;
  SonarrSeriesType get seriesType => _seriesType;
  set seriesType(SonarrSeriesType seriesType) {
    assert(seriesType != null);
    _seriesType = seriesType;
    notifyListeners();
  }

  void initializeSeriesType() {
    _seriesType = series.seriesType ?? SonarrSeriesType.STANDARD;
  }

  SonarrQualityProfile _qualityProfile;
  SonarrQualityProfile get qualityProfile => _qualityProfile;
  set qualityProfile(SonarrQualityProfile qualityProfile) {
    assert(qualityProfile != null);
    _qualityProfile = qualityProfile;
    notifyListeners();
  }

  void initializeQualityProfile(List<SonarrQualityProfile> qualityProfiles) {
    _qualityProfile = qualityProfiles.firstWhere(
      (profile) => profile.id == series.qualityProfileId,
      orElse: () => qualityProfiles.isEmpty ? null : qualityProfiles[0],
    );
  }

  SonarrLanguageProfile _languageProfile;
  SonarrLanguageProfile get languageProfile => _languageProfile;
  set languageProfile(SonarrLanguageProfile languageProfile) {
    assert(languageProfile != null);
    _languageProfile = languageProfile;
    notifyListeners();
  }

  void initializeLanguageProfile(List<SonarrLanguageProfile> languageProfiles) {
    _languageProfile = languageProfiles.firstWhere(
      (profile) => profile.id == series.languageProfileId,
      orElse: () => languageProfiles.isEmpty ? null : languageProfiles[0],
    );
  }

  List<SonarrTag> _tags;
  List<SonarrTag> get tags => _tags;
  set tags(List<SonarrTag> tags) {
    assert(tags != null);
    _tags = tags;
    notifyListeners();
  }

  void initializeTags(List<SonarrTag> tags) {
    _tags = (tags ?? [])
        .where((tag) => (series.tags ?? []).contains(tag.id))
        .toList();
  }
}
