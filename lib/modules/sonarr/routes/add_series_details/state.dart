import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsState extends ChangeNotifier {
    final SonarrSeriesLookup series;
    bool canExecuteAction = false;

    SonarrSeriesAddDetailsState({
        @required this.series,
    }) {
        _processSeasons();
    }

    void _processSeasons() {
        SonarrMonitorStatus _status = SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data;
        _status.process(series.seasons);
    }

    bool _monitored = true;
    bool get monitored => _monitored;
    set monitored(bool monitored) {
        assert(monitored != null);
        _monitored = monitored;
        notifyListeners();
    }
    void initializeMonitored() {
        _monitored = SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED.data ?? true;
    }


    bool _useSeasonFolders = true;
    bool get useSeasonFolders => _useSeasonFolders;
    set useSeasonFolders(bool useSeasonFolders) {
        assert(useSeasonFolders != null);
        _useSeasonFolders = useSeasonFolders;
        notifyListeners();
    }
    void initializeUseSeasonFolders() {
        _useSeasonFolders = SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS.data ?? true;
    }

    SonarrSeriesType _seriesType;
    SonarrSeriesType get seriesType => _seriesType;
    set seriesType(SonarrSeriesType seriesType) {
        assert(seriesType != null);
        _seriesType = seriesType;
        notifyListeners();
    }
    void initializeSeriesType() {
        _seriesType = SonarrSeriesType.values.firstWhere(
            (element) => element.value == SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE.data,
            orElse: () => SonarrSeriesType.STANDARD,
        );
    }

    SonarrRootFolder _rootFolder;
    SonarrRootFolder get rootFolder => _rootFolder;
    set rootFolder(SonarrRootFolder rootFolder) {
        assert(rootFolder != null);
        _rootFolder = rootFolder;
        notifyListeners();
    }
    void initializeRootFolder(List<SonarrRootFolder> rootFolders) {
        _rootFolder = (rootFolders ?? []).firstWhere(
            (element) => element.id == SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER.data,
            orElse: () => (rootFolders?.length ?? 0) != 0 ? rootFolders[0] : SonarrRootFolder(id: -1, freeSpace: 0, path: Constants.TEXT_EMDASH),
        );
    }

    SonarrQualityProfile _qualityProfile;
    SonarrQualityProfile get qualityProfile => _qualityProfile;
    set qualityProfile(SonarrQualityProfile qualityProfile) {
        assert(qualityProfile != null);
        _qualityProfile = qualityProfile;
        notifyListeners();
    }
    void initializeQualityProfile(List<SonarrQualityProfile> qualityProfiles) {
        _qualityProfile = (qualityProfiles ?? []).firstWhere(
            (element) => element.id == SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE.data,
            orElse: () => (qualityProfiles?.length ?? 0) != 0 ? qualityProfiles[0] : SonarrQualityProfile(id: -1, name: Constants.TEXT_EMDASH),
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
        _languageProfile = (languageProfiles ?? []).firstWhere(
            (element) => element.id == SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE.data,
            orElse: () => (languageProfiles?.length ?? 0) != 0 ? languageProfiles[0] : SonarrLanguageProfile(id: -1, name: Constants.TEXT_EMDASH),
        );
    }

    List<SonarrTag> _tags;
    List<SonarrTag> get tags => _tags;
    set tags(List<SonarrTag> tags) {
        assert(tags != null);
        _tags = tags;
        SonarrDatabaseValue.ADD_SERIES_DEFAULT_TAGS.put((tags ?? []).map<int>((tag) => tag.id).toList());
        notifyListeners();
    }
    void initializeTags(List<SonarrTag> tags) {
        _tags = (tags ?? []).where((tag) => ((SonarrDatabaseValue.ADD_SERIES_DEFAULT_TAGS.data as List) ?? []).contains(tag.id)).toList();
    }

    LunaLoadingState _state = LunaLoadingState.INACTIVE;
    LunaLoadingState get state => _state;
    set state(LunaLoadingState state) {
        assert(state != null);
        _state = state;
        notifyListeners();
    }
}
