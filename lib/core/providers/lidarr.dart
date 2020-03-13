import 'package:flutter/foundation.dart';

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

    bool _hideUnmonitored = false;
    bool get hideUnmonitored => _hideUnmonitored;
    set hideUnmonitored(bool hideUnmonitored) {
        assert(hideUnmonitored != null);
        _hideUnmonitored = hideUnmonitored;
        notifyListeners();
    }
}
