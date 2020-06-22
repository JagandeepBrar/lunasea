import 'package:lunasea/core/database.dart';

class SettingsDatabase {
    SettingsDatabase._();

    static void registerAdapters() {}
}

enum SettingsDatabaseValue {
    NAVIGATION_INDEX,
}

extension SettingsDatabaseValueExtension on SettingsDatabaseValue {
    String get key {
        switch(this) {
            case SettingsDatabaseValue.NAVIGATION_INDEX: return 'SETTINGS_NAVIGATION_INDEX';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case SettingsDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
        }
        throw Exception('data not found'); 
    }
}
