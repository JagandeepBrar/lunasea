import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditState extends ChangeNotifier {
  RadarrMovie? _movie;
  RadarrMovie? get movie => _movie;
  set movie(RadarrMovie? movie) {
    _movie = movie;
    initializeMonitored();
    initializeAvailability();
    initializePath();
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
    _monitored = movie!.monitored ?? false;
  }

  String _path = '';
  String get path => _path;
  set path(String path) {
    _path = path;
    notifyListeners();
  }

  void initializePath() {
    _path = movie!.path ?? '';
  }

  RadarrQualityProfile? _qualityProfile;
  RadarrQualityProfile get qualityProfile => _qualityProfile!;
  set qualityProfile(RadarrQualityProfile qualityProfile) {
    _qualityProfile = qualityProfile;
    notifyListeners();
  }

  void initializeQualityProfile(List<RadarrQualityProfile> qualityProfiles) {
    _qualityProfile = qualityProfiles
        .firstWhere((profile) => profile.id == movie?.qualityProfileId);
  }

  late RadarrAvailability _availability;
  RadarrAvailability get availability => _availability;
  set availability(RadarrAvailability availability) {
    _availability = availability;
    notifyListeners();
  }

  void initializeAvailability() {
    _availability = movie!.minimumAvailability ?? RadarrAvailability.ANNOUNCED;
  }

  late List<RadarrTag> _tags;
  List<RadarrTag> get tags => _tags;
  set tags(List<RadarrTag> tags) {
    _tags = tags;
    notifyListeners();
  }

  void initializeTags(List<RadarrTag>? tags) {
    _tags = (tags ?? [])
        .where((tag) => (movie!.tags ?? []).contains(tag.id))
        .toList();
  }
}
