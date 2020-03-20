import 'package:flutter/foundation.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrModel extends ChangeNotifier {
    String _searchFilter = '';
    String get searchFilter => _searchFilter;
    set searchFilter(String searchFilter) {
        assert(searchFilter != null);
        _searchFilter = searchFilter;
        notifyListeners();
    }

    String _sortType = 'abc';
    String get sortType => _sortType;
    set sortType(String sortType) {
        assert(sortType != null);
        _sortType = sortType;
        notifyListeners();
    }

    bool _sortAscending = true;
    bool get sortAscending => _sortAscending;
    set sortAscending(bool sortAscending) {
        assert(sortAscending != null);
        _sortAscending = sortAscending;
        notifyListeners();
    }

    bool _hideUnmonitoredArtists = false;
    bool get hideUnmonitoredArtists => _hideUnmonitoredArtists;
    set hideUnmonitoredArtists(bool hideUnmonitoredArtists) {
        assert(hideUnmonitoredArtists != null);
        _hideUnmonitoredArtists = hideUnmonitoredArtists;
        notifyListeners();
    }

    bool _hideUnmonitoredAlbums = false;
    bool get hideUnmonitoredAlbums => _hideUnmonitoredAlbums;
    set hideUnmonitoredAlbums(bool hideUnmonitoredAlbums) {
        assert(hideUnmonitoredAlbums != null);
        _hideUnmonitoredAlbums = hideUnmonitoredAlbums;
        notifyListeners();
    }

    String _addSearchQuery = '';
    String get addSearchQuery => _addSearchQuery;
    set addSearchQuery(String addSearchQuery) {
        assert(addSearchQuery != null);
        _addSearchQuery = addSearchQuery;
        notifyListeners();
    }

    LidarrRootFolder _addRootFolder;
    LidarrRootFolder get addRootFolder => _addRootFolder;
    set addRootFolder(LidarrRootFolder addRootFolder) {
        assert(addRootFolder != null);
        _addRootFolder = addRootFolder;
        notifyListeners();
    }

    LidarrQualityProfile _addQualityProfile;
    LidarrQualityProfile get addQualityProfile => _addQualityProfile;
    set addQualityProfile(LidarrQualityProfile addQualityProfile) {
        assert(addQualityProfile != null);
        _addQualityProfile = addQualityProfile;
        notifyListeners();
    }

    LidarrMetadataProfile _addMetadataProfile;
    LidarrMetadataProfile get addMetadataProfile => _addMetadataProfile;
    set addMetadataProfile(LidarrMetadataProfile addMetadataProfile) {
        assert(addMetadataProfile != null);
        _addMetadataProfile = addMetadataProfile;
        notifyListeners();
    }
}
