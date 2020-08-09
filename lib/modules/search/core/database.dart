import 'package:lunasea/core/database.dart';

class SearchDatabase {
    SearchDatabase._();

    static void registerAdapters() {}
}

enum SearchDatabaseValue {
    NAVIGATION_INDEX,
    HIDE_XXX,
}

extension SearchDatabaseValueExtension on SearchDatabaseValue {
    String get key {
        switch(this) {
            case SearchDatabaseValue.NAVIGATION_INDEX: return 'SEARCH_NAVIGATION_INDEX';
            case SearchDatabaseValue.HIDE_XXX: return 'SEARCH_HIDE_XXX';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case SearchDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
            case SearchDatabaseValue.HIDE_XXX: return _box.get(this.key, defaultValue: false);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
