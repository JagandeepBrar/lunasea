import 'package:lunasea/core/database.dart';

class NZBGetDatabase {
    NZBGetDatabase._();

    static void registerAdapters() {}
}

enum NZBGetDatabaseValue {
    NAVIGATION_INDEX,
}

extension NZBGetDatabaseValueExtension on NZBGetDatabaseValue {
    String get key {
        switch(this) {
            case NZBGetDatabaseValue.NAVIGATION_INDEX: return 'NZBGET_NAVIGATION_INDEX';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case NZBGetDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
