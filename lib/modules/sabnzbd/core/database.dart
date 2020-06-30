import 'package:lunasea/core/database.dart';

class SABnzbdDatabase {
    SABnzbdDatabase._();

    static void registerAdapters() {}
}

enum SABnzbdDatabaseValue {
    NAVIGATION_INDEX,
}

extension SABnzbdDatabaseValueExtension on SABnzbdDatabaseValue {
    String get key {
        switch(this) {
            case SABnzbdDatabaseValue.NAVIGATION_INDEX: return 'SABNZBD_NAVIGATION_INDEX';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case SABnzbdDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
        }
        throw Exception('data not found'); 
    }
    
    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
