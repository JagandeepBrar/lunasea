//import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';

class TautulliDatabase {
    TautulliDatabase._();

    static void registerAdapters() {}
}

enum TautulliDatabaseValue {
    NAVIGATION_INDEX,
}

extension TautulliDatabaseValueExtension on TautulliDatabaseValue {
    String get key {
        switch(this) {
            case TautulliDatabaseValue.NAVIGATION_INDEX: return 'TAUTULLI_NAVIGATION_INDEX';
        }
        throw Exception('key not found');
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case TautulliDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
        }
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
