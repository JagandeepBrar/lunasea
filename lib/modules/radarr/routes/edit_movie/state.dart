import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditState extends ChangeNotifier {
    RadarrMoviesEditState({
        @required RadarrMovie movie,
        @required List<RadarrQualityProfile> qualityProfiles,
        @required List<RadarrTag> tags,
    }) {
        _monitored = movie.monitored ?? true;
        _path = movie.path ?? '';
        _availability = movie.minimumAvailability ?? RadarrAvailability.ANNOUNCED;
        _qualityProfile = qualityProfiles.firstWhere(
            (profile) => profile.id == movie.qualityProfileId,
            orElse: () => qualityProfiles.length == 0 ? null : qualityProfiles[0],
        );
        _tags = (tags ?? []).where((tag) => (movie.tags ?? []).contains(tag.id)).toList();
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

    String _path = '';
    String get path => _path;
    set path(String path) {
        assert(path != null);
        _path = path;
        notifyListeners();
    }

    RadarrQualityProfile _qualityProfile;
    RadarrQualityProfile get qualityProfile => _qualityProfile;
    set qualityProfile(RadarrQualityProfile qualityProfile) {
        assert(qualityProfile != null);
        _qualityProfile = qualityProfile;
        notifyListeners();
    }

    RadarrAvailability _availability;
    RadarrAvailability get availability => _availability;
    set availability(RadarrAvailability availability) {
        assert(availability != null);
        _availability = availability;
        notifyListeners();
    }

    List<RadarrTag> _tags;
    List<RadarrTag> get tags => _tags;
    set tags(List<RadarrTag> tags) {
        assert(tags != null);
        _tags = tags;
        notifyListeners();
    }
}
