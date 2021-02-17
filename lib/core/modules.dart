enum LunaModule {
    LIDARR,
    RADARR,
    SONARR,
    SABNZBD,
    NZBGET,
    SEARCH,
    SETTINGS,
    WAKE_ON_LAN,
    TAUTULLI,
}

extension LunaModuleExtension on LunaModule {
    String get key {
        switch(this) {
            case LunaModule.LIDARR: return 'lidarr';
            case LunaModule.RADARR: return 'radarr';
            case LunaModule.SONARR: return 'sonarr';
            case LunaModule.SABNZBD: return 'sabnzbd';
            case LunaModule.NZBGET: return 'nzbget';
            case LunaModule.SEARCH: return 'search';
            case LunaModule.SETTINGS: return 'settings';
            case LunaModule.WAKE_ON_LAN: return 'wake_on_lan';
            case LunaModule.TAUTULLI: return 'tautulli';
        }
        throw Exception('Unknown LunaModule instance');
    }

    String get name {
        switch(this) {
            case LunaModule.LIDARR: return 'Lidarr';
            case LunaModule.RADARR: return 'Radarr';
            case LunaModule.SONARR: return 'Sonarr';
            case LunaModule.SABNZBD: return 'SABnzbd';
            case LunaModule.NZBGET: return 'NZBGet';
            case LunaModule.SEARCH: return 'Search';
            case LunaModule.SETTINGS: return 'Settings';
            case LunaModule.WAKE_ON_LAN: return 'Wake on LAN';
            case LunaModule.TAUTULLI: return 'Tautulli';
        }
        throw Exception('Unknown LunaModule instance');
    }
}
