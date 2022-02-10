import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorEditState extends ChangeNotifier {
  ReadarrAuthor? _series;
  ReadarrAuthor? get series => _series;
  set series(ReadarrAuthor? series) {
    _series = series;
    initializeMonitored();
    initializeSeriesPath();
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

  String _seriesPath = '';
  String get seriesPath => _seriesPath;
  set seriesPath(String seriesPath) {
    _seriesPath = seriesPath;
    notifyListeners();
  }

  void initializeSeriesPath() {
    _seriesPath = series!.path ?? '';
  }

  ReadarrQualityProfile? _qualityProfile;
  ReadarrQualityProfile? get qualityProfile => _qualityProfile;
  set qualityProfile(ReadarrQualityProfile? qualityProfile) {
    _qualityProfile = qualityProfile;
    notifyListeners();
  }

  void initializeQualityProfile(List<ReadarrQualityProfile> qualityProfiles) {
    _qualityProfile = qualityProfiles.firstWhere(
      (profile) => profile.id == series!.qualityProfileId,
      orElse: () => qualityProfiles[0],
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
      (p) => p.id == series!.metadataProfileId,
    );
  }

  List<ReadarrTag>? _tags;
  List<ReadarrTag>? get tags => _tags;
  set tags(List<ReadarrTag>? tags) {
    _tags = tags;
    notifyListeners();
  }

  void initializeTags(List<ReadarrTag> tags) {
    _tags = tags.where((tag) => (series!.tags ?? []).contains(tag.id)).toList();
  }
}
