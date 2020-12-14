import 'package:lunasea/core.dart';

class OmbiDatabase extends LunaModuleDatabase {
    void registerAdapters() {}
}

enum OmbiDatabaseValue {
    NAVIGATION_INDEX,
}

extension OmbiDatabaseValueExtension on OmbiDatabaseValue {
    String get key {
        switch(this) {
            case OmbiDatabaseValue.NAVIGATION_INDEX: return 'OMBI_NAVIGATION_INDEX';
        }
        throw Exception('key not found');
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case OmbiDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
        }
        throw Exception('data not found');
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
