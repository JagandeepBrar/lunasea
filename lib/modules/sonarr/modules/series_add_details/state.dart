import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsState extends ChangeNotifier {
    SonarrSeriesAddDetailsState({
        @required SonarrSeriesLookup series,
        @required List<SonarrRootFolder> rootFolders,
        @required List<SonarrQualityProfile> qualityProfiles,
        @required List<SonarrLanguageProfile> languageProfiles,
        @required List<SonarrTag> tags,
    }) {
        _series = series;
        _tags = [];
        _monitored = SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED.data ?? true;
        _useSeasonFolders = SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS.data ?? true;
        _seriesType = SonarrSeriesType.values.firstWhere(
            (element) => element.value == SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE.data,
            orElse: () => SonarrSeriesType.STANDARD,
        );
        _rootFolder = rootFolders.firstWhere(
            (element) => element.id == SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER.data,
            orElse: () => rootFolders[0],
        );
        _qualityProfile = qualityProfiles.firstWhere(
            (element) => element.id == SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE.data,
            orElse: () => qualityProfiles[0],
        );
        _languageProfile = languageProfiles.firstWhere(
            (element) => element.id == SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE.data,
            orElse: () => (languageProfiles?.length ?? 0) == 0 ? null : languageProfiles[0],
        );
        _processSeasons(_series);
    }

    void _processSeasons(SonarrSeriesLookup series) {
        SonarrMonitorStatus _status = SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data;
        _status.process(series.seasons);
    }

    SonarrSeriesLookup _series;
    SonarrSeriesLookup get series => _series;

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

    bool _useSeasonFolders = true;
    bool get useSeasonFolders => _useSeasonFolders;
    set useSeasonFolders(bool useSeasonFolders) {
        assert(useSeasonFolders != null);
        _useSeasonFolders = useSeasonFolders;
        notifyListeners();
    }

    SonarrRootFolder _rootFolder;
    SonarrRootFolder get rootFolder => _rootFolder;
    set rootFolder(SonarrRootFolder rootFolder) {
        assert(rootFolder != null);
        _rootFolder = rootFolder;
        notifyListeners();
    }

    SonarrSeriesType _seriesType;
    SonarrSeriesType get seriesType => _seriesType;
    set seriesType(SonarrSeriesType seriesType) {
        assert(seriesType != null);
        _seriesType = seriesType;
        notifyListeners();
    }

    SonarrQualityProfile _qualityProfile;
    SonarrQualityProfile get qualityProfile => _qualityProfile;
    set qualityProfile(SonarrQualityProfile qualityProfile) {
        assert(qualityProfile != null);
        _qualityProfile = qualityProfile;
        notifyListeners();
    }

    SonarrLanguageProfile _languageProfile;
    SonarrLanguageProfile get languageProfile => _languageProfile;
    set languageProfile(SonarrLanguageProfile languageProfile) {
        assert(languageProfile != null);
        _languageProfile = languageProfile;
        notifyListeners();
    }

    List<SonarrTag> _tags;
    List<SonarrTag> get tags => _tags;
    set tags(List<SonarrTag> tags) {
        assert(tags != null);
        _tags = tags;
        notifyListeners();
    }
}
