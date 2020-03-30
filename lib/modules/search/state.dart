import 'package:flutter/foundation.dart';
import 'package:lunasea/core.dart';
import '../search.dart';

class SearchModel extends ChangeNotifier {
    IndexerHiveObject _indexer;
    IndexerHiveObject get indexer => _indexer;
    set indexer(IndexerHiveObject indexer) {
        assert(indexer != null);
        _indexer = indexer;
        notifyListeners();
    }
    
    NewznabCategoryData _category;
    NewznabCategoryData get category => _category;
    set category(NewznabCategoryData category) {
        assert(category != null);
        _category = category;
        notifyListeners();
    }

    String _searchTitle;
    String get searchTitle => _searchTitle;
    set searchTitle(String title) {
        assert(title != null);
        _searchTitle = title;
        notifyListeners();
    }

    String _searchQuery;
    String get searchQuery => _searchQuery;
    set searchQuery(String query) {
        assert(query != null);
        _searchQuery = query;
        notifyListeners();
    }

    int _searchCategoryID;
    int get searchCategoryID => _searchCategoryID;
    set searchCategoryID(int id) {
        assert(id != null);
        _searchCategoryID = id;
        notifyListeners();
    }

    NewznabResultData _resultDetails;
    NewznabResultData get resultDetails => _resultDetails;
    set resultDetails(NewznabResultData details) {
        assert(details != null);
        _resultDetails = details;
        notifyListeners();
    }
}
