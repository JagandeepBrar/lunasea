import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditState extends ChangeNotifier {
  SonarrSeries? _series;
  SonarrSeries? get series => _series;
  set series(SonarrSeries? series) {
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

  SonarrSeriesType? _seriesType;
  SonarrSeriesType? get seriesType => _seriesType;
  set seriesType(SonarrSeriesType? seriesType) {
    _seriesType = seriesType;
    notifyListeners();
  }

  void initializeSeriesType() {
    _seriesType = series!.seriesType ?? SonarrSeriesType.STANDARD;
  }

  SonarrQualityProfile? _qualityProfile;
  SonarrQualityProfile? get qualityProfile => _qualityProfile;
  set qualityProfile(SonarrQualityProfile? qualityProfile) {
    _qualityProfile = qualityProfile;
    notifyListeners();
  }

  void initializeQualityProfile(List<SonarrQualityProfile> qualityProfiles) {
    _qualityProfile = qualityProfiles.firstWhere(
      (profile) => profile.id == series!.qualityProfileId,
      orElse: () => qualityProfiles[0],
    );
  }

  SonarrLanguageProfile? _languageProfile;
  SonarrLanguageProfile? get languageProfile => _languageProfile;
  set languageProfile(SonarrLanguageProfile? languageProfile) {
    _languageProfile = languageProfile;
    notifyListeners();
  }

  void initializeLanguageProfile(List<SonarrLanguageProfile> languageProfiles) {
    if (languageProfiles.isEmpty) return;
    _languageProfile = languageProfiles.firstWhere(
      (p) => p.id == series!.languageProfileId,
    );
  }

  List<SonarrTag>? _tags;
  List<SonarrTag>? get tags => _tags;
  set tags(List<SonarrTag>? tags) {
    _tags = tags;
    notifyListeners();
  }

  void initializeTags(List<SonarrTag> tags) {
    _tags = tags.where((tag) => (series!.tags ?? []).contains(tag.id)).toList();
  }
}
