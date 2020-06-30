import 'package:lunasea/core/database/database.dart';
import 'package:lunasea/core/extensions.dart';

class LunaSeaDatabase {
    LunaSeaDatabase._();

    static void registerAdapters() {
        Hive.registerAdapter(LSBrowsersAdapter());
    }
}

enum LunaSeaDatabaseValue {
    ENABLED_PROFILE,
    THEME_AMOLED,
    THEME_AMOLED_BORDER,
    SELECTED_BROWSER,
}

extension LunaSeaDatabaseValueExtension on LunaSeaDatabaseValue {
    String get key {
        switch(this) {
            case LunaSeaDatabaseValue.ENABLED_PROFILE: return 'profile';
            case LunaSeaDatabaseValue.THEME_AMOLED: return 'LUNASEA_THEME_AMOLED';
            case LunaSeaDatabaseValue.THEME_AMOLED_BORDER: return 'LUNASEA_THEME_AMOLED_BORDER';
            case LunaSeaDatabaseValue.SELECTED_BROWSER: return 'LUNASEA_SELECTED_BROWSER';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case LunaSeaDatabaseValue.ENABLED_PROFILE: return _box.get(this.key, defaultValue: 'default');
            case LunaSeaDatabaseValue.SELECTED_BROWSER: return _box.get(this.key, defaultValue: LSBrowsers.APPLE_SAFARI);
            case LunaSeaDatabaseValue.THEME_AMOLED: return _box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.THEME_AMOLED_BORDER: return _box.get(this.key, defaultValue: false);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
