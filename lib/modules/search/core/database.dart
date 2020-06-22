import 'package:lunasea/core/database.dart';

class SearchDatabase {
    SearchDatabase._();

    static void registerAdapters() {}
}

enum SearchDatabaseValue {
    NAVIGATION_INDEX,
}

extension SearchDatabaseValueExtension on SearchDatabaseValue {
    String get key {
        switch(this) {
            case SearchDatabaseValue.NAVIGATION_INDEX: return 'SEARCH_NAVIGATION_INDEX';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case SearchDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
        }
        throw Exception('data not found'); 
    }
}
