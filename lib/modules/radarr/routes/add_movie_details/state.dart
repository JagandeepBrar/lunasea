import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsState extends ChangeNotifier {
  final bool isDiscovery;
  final RadarrMovie movie;
  bool canExecuteAction = false;

  RadarrAddMovieDetailsState({
    required this.movie,
    required this.isDiscovery,
  });

  bool _monitored = RadarrDatabase.ADD_MOVIE_DEFAULT_MONITORED_STATE.read();
  bool get monitored => _monitored;
  set monitored(bool monitored) {
    _monitored = monitored;
    RadarrDatabase.ADD_MOVIE_DEFAULT_MONITORED_STATE.update(_monitored);
    notifyListeners();
  }

  late RadarrAvailability _availability;
  RadarrAvailability get availability => _availability;
  set availability(RadarrAvailability availability) {
    _availability = availability;
    RadarrDatabase.ADD_MOVIE_DEFAULT_MINIMUM_AVAILABILITY_ID
        .update(_availability.value);
    notifyListeners();
  }

  void initializeAvailability() {
    const _db = RadarrDatabase.ADD_MOVIE_DEFAULT_MINIMUM_AVAILABILITY_ID;
    RadarrAvailability? _ra = RadarrAvailability.TBA.from(_db.read());

    if (_ra == RadarrAvailability.TBA || _ra == RadarrAvailability.PREDB) {
      _availability = RadarrAvailability.ANNOUNCED;
    } else {
      _availability = RadarrAvailability.values.firstWhere(
        (avail) => avail == _ra,
        orElse: () => RadarrAvailability.ANNOUNCED,
      );
    }
  }

  late RadarrRootFolder _rootFolder;
  RadarrRootFolder get rootFolder => _rootFolder;
  set rootFolder(RadarrRootFolder rootFolder) {
    _rootFolder = rootFolder;
    RadarrDatabase.ADD_MOVIE_DEFAULT_ROOT_FOLDER_ID.update(_rootFolder.id);
    notifyListeners();
  }

  void initializeRootFolder(List<RadarrRootFolder>? rootFolders) {
    _rootFolder = (rootFolders ?? []).firstWhere(
      (element) =>
          element.id == RadarrDatabase.ADD_MOVIE_DEFAULT_ROOT_FOLDER_ID.read(),
      orElse: () => (rootFolders?.length ?? 0) != 0
          ? rootFolders![0]
          : RadarrRootFolder(id: -1, freeSpace: 0, path: LunaUI.TEXT_EMDASH),
    );
  }

  late RadarrQualityProfile _qualityProfile;
  RadarrQualityProfile get qualityProfile => _qualityProfile;
  set qualityProfile(RadarrQualityProfile qualityProfile) {
    _qualityProfile = qualityProfile;
    RadarrDatabase.ADD_MOVIE_DEFAULT_QUALITY_PROFILE_ID
        .update(_qualityProfile.id);
    notifyListeners();
  }

  void initializeQualityProfile(List<RadarrQualityProfile>? qualityProfiles) {
    _qualityProfile = (qualityProfiles ?? []).firstWhere(
      (element) =>
          element.id ==
          RadarrDatabase.ADD_MOVIE_DEFAULT_QUALITY_PROFILE_ID.read(),
      orElse: () => (qualityProfiles?.length ?? 0) != 0
          ? qualityProfiles![0]
          : RadarrQualityProfile(id: -1, name: LunaUI.TEXT_EMDASH),
    );
  }

  List<RadarrTag> _tags = [];
  List<RadarrTag> get tags => _tags;
  set tags(List<RadarrTag> tags) {
    _tags = tags;
    RadarrDatabase.ADD_MOVIE_DEFAULT_TAGS
        .update(tags.map<int?>((tag) => tag.id).toList());
    notifyListeners();
  }

  void initializeTags(List<RadarrTag>? tags) {
    _tags = (tags ?? [])
        .where((tag) =>
            RadarrDatabase.ADD_MOVIE_DEFAULT_TAGS.read().contains(tag.id))
        .toList();
  }

  LunaLoadingState _state = LunaLoadingState.INACTIVE;
  LunaLoadingState get state => _state;
  set state(LunaLoadingState state) {
    _state = state;
    notifyListeners();
  }
}
