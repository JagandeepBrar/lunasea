import 'package:flutter/foundation.dart';
import 'package:lunasea/core/api/newznab.dart';
import 'package:lunasea/core/database/adapters.dart';

class SearchModel extends ChangeNotifier {
    IndexerHiveObject _indexer;
    get indexer => _indexer;
    set indexer(IndexerHiveObject indexer) {
        assert(indexer != null);
        _indexer = indexer;
        notifyListeners();
    }
    
    NewznabCategoryData _category;
    get category => _category;
    set category(NewznabCategoryData category) {
        assert(category != null);
        _category = category;
        notifyListeners();
    }

    String _searchQuery;
    get searchQuery => _searchQuery;
    set searchQuery(String query) {
        assert(query != null);
        _searchQuery = query;
        notifyListeners();
    }

    int _searchCategoryID;
    get searchCategoryID => _searchCategoryID;
    set searchCategoryID(int id) {
        assert(id != null);
        _searchCategoryID = id;
        notifyListeners();
    }

    NewznabResultData _resultDetails;
    get resultDetails => _resultDetails;
    set resultDetails(NewznabResultData details) {
        assert(details != null);
        _resultDetails = details;
        notifyListeners();
    }
}
