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
                case LunaSeaDatabaseValue.USE_24_HOUR_TIME: data[value.key] = value.data; break;
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
            default: return null;
        }
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
        final box = Database.lunaSeaBox;
        switch(this) {
            case LunaSeaDatabaseValue.ENABLED_PROFILE: return box.get(this.key, defaultValue: 'default');
            case LunaSeaDatabaseValue.SELECTED_BROWSER: return box.get(this.key, defaultValue: LSBrowsers.APPLE_SAFARI);
            case LunaSeaDatabaseValue.THEME_AMOLED: return box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.THEME_AMOLED_BORDER: return box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY: return box.get(this.key, defaultValue: 10);
            case LunaSeaDatabaseValue.ENABLED_SENTRY: return box.get(this.key, defaultValue: true);
            case LunaSeaDatabaseValue.DRAWER_GROUP_MODULES: return box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION: return box.get(this.key, defaultValue: true);
            case LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS: return box.get(this.key, defaultValue: true);
            case LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING: return box.get(this.key, defaultValue: true);
            case LunaSeaDatabaseValue.QUICK_ACTIONS_LIDARR: return box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.QUICK_ACTIONS_RADARR: return box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SONARR: return box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.QUICK_ACTIONS_NZBGET: return box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SABNZBD: return box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.QUICK_ACTIONS_TAUTULLI: return box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SEARCH: return box.get(this.key, defaultValue: false);
            case LunaSeaDatabaseValue.USE_24_HOUR_TIME: return box.get(this.key, defaultValue: false);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case LunaSeaDatabaseValue.ENABLED_PROFILE: if(value.runtimeType == String) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.ENABLED_SENTRY: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.THEME_AMOLED: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.THEME_AMOLED_BORDER: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY: if(value.runtimeType == int) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.SELECTED_BROWSER: if(value.runtimeType == LSBrowsers) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.DRAWER_GROUP_MODULES: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.QUICK_ACTIONS_LIDARR: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.QUICK_ACTIONS_RADARR: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SONARR: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.QUICK_ACTIONS_NZBGET: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SABNZBD: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.QUICK_ACTIONS_TAUTULLI: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.QUICK_ACTIONS_SEARCH: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LunaSeaDatabaseValue.USE_24_HOUR_TIME: if(value.runtimeType == bool) box.put(this.key, value); return;
        }
        LunaLogger.warning('LunaSeaDatabaseValueExtension', 'put', 'Attempted to enter data for invalid LunaSeaDatabaseValue: ${this?.toString() ?? 'null'}');
    }
}
