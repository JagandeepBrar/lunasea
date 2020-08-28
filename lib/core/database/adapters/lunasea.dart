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
    ENABLED_SENTRY,
    CLIENT_IDENTIFIER,
    THEME_AMOLED,
    THEME_AMOLED_BORDER,
    SELECTED_BROWSER,
    DRAWER_EXPAND_AUTOMATION,
    DRAWER_EXPAND_CLIENTS,
    DRAWER_EXPAND_MONITORING,
    QUICK_ACTIONS_LIDARR,
    QUICK_ACTIONS_RADARR,
    QUICK_ACTIONS_SONARR,
    QUICK_ACTIONS_NZBGET,
    QUICK_ACTIONS_SABNZBD,
    QUICK_ACTIONS_TAUTULLI,
    QUICK_ACTIONS_SEARCH,
    USE_24_HOUR_TIME,
}

extension LunaSeaDatabaseValueExtension on LunaSeaDatabaseValue {
    String get key {
        switch(this) {
            case LunaSeaDatabaseValue.ENABLED_PROFILE: return 'profile';
            case LunaSeaDatabaseValue.ENABLED_SENTRY: return 'LUNASEA_ENABLED_SENTRY';
            case LunaSeaDatabaseValue.THEME_AMOLED: return 'LUNASEA_THEME_AMOLED';
            case LunaSeaDatabaseValue.THEME_AMOLED_BORDER: return 'LUNASEA_THEME_AMOLED_BORDER';
            case LunaSeaDatabaseValue.SELECTED_BROWSER: return 'LUNASEA_SELECTED_BROWSER';
            case LunaSeaDatabaseValue.CLIENT_IDENTIFIER: return 'LUNASEA_CLIENT_IDENTIFIER';
            case LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION: return 'LUNASEA_DRAWER_EXPAND_AUTOMATION';
            case LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS: return 'LUNASEA_DRAWER_EXPAND_CLIENTS';
            case LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING: return 'LUNASEA_DRAWER_EXPAND_MONITORING';
            case LunaSeaDatabaseValue.QUICK_ACTIONS_LIDARR: return 'LUNASEA_QUICK_ACTIONS_LIDARR';
            case LunaSeaDatabaseValue.QUICK_ACTIONS_RADARR: return 'LUNASEA_QUICK_ACTIONS_RADARR';
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SONARR: return 'LUNASEA_QUICK_ACTIONS_SONARR';
            case LunaSeaDatabaseValue.QUICK_ACTIONS_NZBGET: return 'LUNASEA_QUICK_ACTIONS_NZBGET';
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SABNZBD: return 'LUNASEA_QUICK_ACTIONS_SABNZBD';
            case LunaSeaDatabaseValue.QUICK_ACTIONS_TAUTULLI: return 'LUNASEA_QUICK_ACTIONS_TAUTULLI';
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SEARCH: return 'LUNASEA_QUICK_ACTIONS_SEARCH';
            case LunaSeaDatabaseValue.USE_24_HOUR_TIME: return 'LUNASEA_USE_24_HOUR_TIME';
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
            case LunaSeaDatabaseValue.ENABLED_SENTRY: return _box.get(this.key, defaultValue: true);
            case LunaSeaDatabaseValue.CLIENT_IDENTIFIER: return _box.get(this.key, defaultValue: null);
            case LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION: return _box.get(this.key, defaultValue: true);
            case LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS: return _box.get(this.key, defaultValue: true);
            case LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING: return _box.get(this.key, defaultValue: true);
            case LunaSeaDatabaseValue.QUICK_ACTIONS_LIDARR: return _box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.QUICK_ACTIONS_RADARR: return _box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SONARR: return _box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.QUICK_ACTIONS_NZBGET: return _box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SABNZBD: return _box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.QUICK_ACTIONS_TAUTULLI: return _box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SEARCH: return _box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.USE_24_HOUR_TIME: return _box.get(this.key, defaultValue: false);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
