import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditState extends ChangeNotifier {
    SonarrSeriesEditState({
        @required SonarrSeries series,
        @required List<SonarrQualityProfile> qualityProfiles,
        @required List<SonarrLanguageProfile> languageProfiles,
        @required List<SonarrTag> tags,
    }) {
        _monitored = series.monitored ?? true;
        _useSeasonFolders = series.seasonFolder ?? true;
        _seriesPath = series.path;
        _seriesType = series.seriesType ?? SonarrSeriesType.STANDARD;
        _qualityProfile = qualityProfiles.firstWhere(
            (profile) => profile.id == series.profileId,
            orElse: () => qualityProfiles.length == 0 ? null : qualityProfiles[0],
        );
        _languageProfile = (languageProfiles ?? []).firstWhere(
            (profile) => profile.id == series.languageProfileId,
            orElse: () => languageProfiles.length == 0 ? null : languageProfiles[0],
        );
        _tags = (tags ?? []).where((tag) => (series.tags ?? []).contains(tag.id)).toList();
    }

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

    String _seriesPath = '';
    String get seriesPath => _seriesPath;
    set seriesPath(String seriesPath) {
        assert(seriesPath != null);
        _seriesPath = seriesPath;
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
