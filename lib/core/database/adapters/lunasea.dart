import 'package:lunasea/core.dart';

class LunaSeaDatabase extends LunaModuleDatabase {
    @override
    void registerAdapters() {
        Hive.registerAdapter(LSBrowsersAdapter());
    }

    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        for(LunaSeaDatabaseValue value in LunaSeaDatabaseValue.values) {
            switch(value) {
                // Non-primitive values
                case LunaSeaDatabaseValue.SELECTED_BROWSER: data[value.key] = (LunaSeaDatabaseValue.SELECTED_BROWSER.data as LSBrowsers).key; break;
                // Primitive values
                case LunaSeaDatabaseValue.ENABLED_PROFILE: 
                case LunaSeaDatabaseValue.ENABLED_SENTRY:
                case LunaSeaDatabaseValue.THEME_AMOLED:
                case LunaSeaDatabaseValue.THEME_AMOLED_BORDER:
                case LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY:
                case LunaSeaDatabaseValue.DRAWER_GROUP_MODULES:
                case LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION:
                case LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS:
                case LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING:
                case LunaSeaDatabaseValue.QUICK_ACTIONS_LIDARR:
                case LunaSeaDatabaseValue.QUICK_ACTIONS_RADARR:
                case LunaSeaDatabaseValue.QUICK_ACTIONS_SONARR:
                case LunaSeaDatabaseValue.QUICK_ACTIONS_NZBGET:
                case LunaSeaDatabaseValue.QUICK_ACTIONS_SABNZBD:
                case LunaSeaDatabaseValue.QUICK_ACTIONS_TAUTULLI:
                case LunaSeaDatabaseValue.QUICK_ACTIONS_SEARCH:
                case LunaSeaDatabaseValue.USE_24_HOUR_TIME: data[value.key] = value.data;
            }
        }
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        for(String key in config.keys) {
            LunaSeaDatabaseValue value = valueFromKey(key);
            if(value != null) switch(value) {
                // Non-primitive values
                case LunaSeaDatabaseValue.SELECTED_BROWSER: value.put(LSBrowsers.APPLE_SAFARI.fromKey(config[key])); break;
                // Primitive values
                case LunaSeaDatabaseValue.ENABLED_PROFILE: 
                case LunaSeaDatabaseValue.ENABLED_SENTRY:
                case LunaSeaDatabaseValue.THEME_AMOLED:
                case LunaSeaDatabaseValue.THEME_AMOLED_BORDER:
                case LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY:
                case LunaSeaDatabaseValue.DRAWER_GROUP_MODULES:
                case LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION:
                case LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS:
                case LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING:
                case LunaSeaDatabaseValue.QUICK_ACTIONS_LIDARR:
                case LunaSeaDatabaseValue.QUICK_ACTIONS_RADARR:
                case LunaSeaDatabaseValue.QUICK_ACTIONS_SONARR:
                case LunaSeaDatabaseValue.QUICK_ACTIONS_NZBGET:
                case LunaSeaDatabaseValue.QUICK_ACTIONS_SABNZBD:
                case LunaSeaDatabaseValue.QUICK_ACTIONS_TAUTULLI:
                case LunaSeaDatabaseValue.QUICK_ACTIONS_SEARCH:
                case LunaSeaDatabaseValue.USE_24_HOUR_TIME: value.put(config[key]); break;
            }
        }
    }

    LunaSeaDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'profile': return LunaSeaDatabaseValue.ENABLED_PROFILE;
            case 'LUNASEA_ENABLED_SENTRY': return LunaSeaDatabaseValue.ENABLED_SENTRY;
            case 'LUNASEA_THEME_AMOLED': return LunaSeaDatabaseValue.THEME_AMOLED;
            case 'LUNASEA_THEME_AMOLED_BORDER': return LunaSeaDatabaseValue.THEME_AMOLED_BORDER;
            case 'LUNASEA_THEME_IMAGE_BACKGROUND_OPACITY': return LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY;
            case 'LUNASEA_SELECTED_BROWSER': return LunaSeaDatabaseValue.SELECTED_BROWSER;
            case 'LUNASEA_DRAWER_GROUP_MODULES': return LunaSeaDatabaseValue.DRAWER_GROUP_MODULES;
            case 'LUNASEA_DRAWER_EXPAND_AUTOMATION': return LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION;
            case 'LUNASEA_DRAWER_EXPAND_CLIENTS': return LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS;
            case 'LUNASEA_DRAWER_EXPAND_MONITORING': return LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING;
            case 'LUNASEA_QUICK_ACTIONS_LIDARR': return LunaSeaDatabaseValue.QUICK_ACTIONS_LIDARR;
            case 'LUNASEA_QUICK_ACTIONS_RADARR': return LunaSeaDatabaseValue.QUICK_ACTIONS_RADARR;
            case 'LUNASEA_QUICK_ACTIONS_SONARR': return LunaSeaDatabaseValue.QUICK_ACTIONS_SONARR;
            case 'LUNASEA_QUICK_ACTIONS_NZBGET': return LunaSeaDatabaseValue.QUICK_ACTIONS_NZBGET;
            case 'LUNASEA_QUICK_ACTIONS_SABNZBD': return LunaSeaDatabaseValue.QUICK_ACTIONS_SABNZBD;
            case 'LUNASEA_QUICK_ACTIONS_TAUTULLI': return LunaSeaDatabaseValue.QUICK_ACTIONS_TAUTULLI;
            case 'LUNASEA_QUICK_ACTIONS_SEARCH': return LunaSeaDatabaseValue.QUICK_ACTIONS_SEARCH;
            case 'LUNASEA_USE_24_HOUR_TIME': return LunaSeaDatabaseValue.USE_24_HOUR_TIME;
        }
        return null;
    }
}

enum LunaSeaDatabaseValue {
    ENABLED_PROFILE,
    ENABLED_SENTRY,
    THEME_AMOLED,
    THEME_AMOLED_BORDER,
    THEME_IMAGE_BACKGROUND_OPACITY,
    SELECTED_BROWSER,
    DRAWER_GROUP_MODULES,
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
            case LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY: return 'LUNASEA_THEME_IMAGE_BACKGROUND_OPACITY';
            case LunaSeaDatabaseValue.SELECTED_BROWSER: return 'LUNASEA_SELECTED_BROWSER';
            case LunaSeaDatabaseValue.DRAWER_GROUP_MODULES: return 'LUNASEA_DRAWER_GROUP_MODULES';
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
            case LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY: return _box.get(this.key, defaultValue: 10);
            case LunaSeaDatabaseValue.ENABLED_SENTRY: return _box.get(this.key, defaultValue: true);
            case LunaSeaDatabaseValue.DRAWER_GROUP_MODULES: return _box.get(this.key, defaultValue: false);
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

    void put(dynamic value) {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case LunaSeaDatabaseValue.ENABLED_PROFILE: if(value.runtimeType == String) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.ENABLED_SENTRY: if(value.runtimeType == bool) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.THEME_AMOLED: if(value.runtimeType == bool) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.THEME_AMOLED_BORDER: if(value.runtimeType == bool) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY: if(value.runtimeType == int) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.SELECTED_BROWSER: if(value.runtimeType == LSBrowsers) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.DRAWER_GROUP_MODULES: if(value.runtimeType == bool) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION: if(value.runtimeType == bool) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS: if(value.runtimeType == bool) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING: if(value.runtimeType == bool) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.QUICK_ACTIONS_LIDARR: if(value.runtimeType == bool) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.QUICK_ACTIONS_RADARR: if(value.runtimeType == bool) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SONARR: if(value.runtimeType == bool) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.QUICK_ACTIONS_NZBGET: if(value.runtimeType == bool) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SABNZBD: if(value.runtimeType == bool) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.QUICK_ACTIONS_TAUTULLI: if(value.runtimeType == bool) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SEARCH: if(value.runtimeType == bool) _box.put(this.key, value); return;
            case LunaSeaDatabaseValue.USE_24_HOUR_TIME: if(value.runtimeType == bool) _box.put(this.key, value); return;
        }
        LunaLogger.warning('LunaSeaDatabaseValueExtension', 'put', 'Attempted to enter data for invalid LunaSeaDatabaseValue: ${this?.toString() ?? 'null'}');
    }
}
