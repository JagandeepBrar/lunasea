import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchState extends LunaModuleState {
    SearchState() {
        reset();
    }

    @override
    void reset() {
        _api = null;
        _indexer = null;
        _activeCategory = null;
    }

    NewznabAPI _api;
    NewznabAPI get api => _api;
    set api(NewznabAPI api) {
        assert(api != null);
        _api = api;
    }

    IndexerHiveObject _indexer;
    IndexerHiveObject get indexer => _indexer;
    set indexer(IndexerHiveObject indexer) {
        assert(indexer != null);
        _indexer = indexer;
        api = NewznabAPI.from(_indexer);
        notifyListeners();
    }

    Future<List<NewznabCategoryData>> _categories;
    Future<List<NewznabCategoryData>> get categories => _categories;
    void fetchCategories() {
        if(_api != null) _categories = _api.getCategories();
        notifyListeners();
    }
    
    NewznabCategoryData _activeCategory;
    NewznabCategoryData get activeCategory => _activeCategory;
    set activeCategory(NewznabCategoryData category) {
        assert(category != null);
        _activeCategory = category;
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

    String _searchResultsFilter = '';
    String get searchResultsFilter => _searchResultsFilter;
    set searchResultsFilter(String searchResultsFilter) {
        assert(searchResultsFilter != null);
        _searchResultsFilter = searchResultsFilter;
        notifyListeners();
    }

    SearchResultsSorting _sortResultsSorting = SearchResultsSorting.age;
    SearchResultsSorting get sortResultsSorting => _sortResultsSorting;
    set sortResultsSorting(SearchResultsSorting sortResultsSorting) {
        assert(sortResultsSorting != null);
        _sortResultsSorting = sortResultsSorting;
        notifyListeners();
    }

    bool _sortResultsAscending = true;
    bool get sortResultsAscending => _sortResultsAscending;
    set sortResultsAscending(bool sortResultsAscending) {
        assert(sortResultsAscending != null);
        _sortResultsAscending = sortResultsAscending;
        notifyListeners();
    }
}
