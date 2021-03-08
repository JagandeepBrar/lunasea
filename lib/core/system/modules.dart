import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';
import 'package:quick_actions/quick_actions.dart';

enum LunaModule {
    DASHBOARD,
    LIDARR,
    NZBGET,
    RADARR,
    SABNZBD,
    SEARCH,
    SETTINGS,
    SONARR,
    TAUTULLI,
    WAKE_ON_LAN,
}

extension LunaModuleExtension on LunaModule {
    LunaModule fromKey(String key) {
        switch(key) {
            case 'dashboard': return LunaModule.DASHBOARD;
            case 'lidarr': return LunaModule.LIDARR;
            case 'nzbget': return LunaModule.NZBGET;
            case 'radarr': return LunaModule.RADARR;
            case 'sabnzbd': return LunaModule.SABNZBD;
            case 'search': return LunaModule.SEARCH;
            case 'settings': return LunaModule.SETTINGS;
            case 'sonarr': return LunaModule.SONARR;
            case 'tautulli': return LunaModule.TAUTULLI;
            case 'wake_on_lan': return LunaModule.WAKE_ON_LAN;
        }
        return null;
    }

    String get key {
        switch(this) {
            case LunaModule.DASHBOARD: return 'dashboard';
            case LunaModule.LIDARR: return 'lidarr';
            case LunaModule.NZBGET: return 'nzbget';
            case LunaModule.RADARR: return 'radarr';
            case LunaModule.SABNZBD: return 'sabnzbd';
            case LunaModule.SEARCH: return 'search';
            case LunaModule.SETTINGS: return 'settings';
            case LunaModule.SONARR: return 'sonarr';
            case LunaModule.TAUTULLI: return 'tautulli';
            case LunaModule.WAKE_ON_LAN: return 'wake_on_lan';
        }
        throw Exception('Invalid LunaModule');
    }

    bool get enabled {
        switch(this) {
            case LunaModule.DASHBOARD: return null;
            case LunaModule.LIDARR: return Database.currentProfileObject.lidarrEnabled ?? false;
            case LunaModule.NZBGET: return Database.currentProfileObject.nzbgetEnabled ?? false;
            case LunaModule.RADARR: return Database.currentProfileObject.radarrEnabled ?? false;
            case LunaModule.SABNZBD: return Database.currentProfileObject.sabnzbdEnabled ?? false;
            case LunaModule.SEARCH: return (Database.indexersBox.values?.length ?? 0) > 0;
            case LunaModule.SETTINGS: return null;
            case LunaModule.SONARR: return Database.currentProfileObject.sonarrEnabled ?? false;
            case LunaModule.TAUTULLI: return Database.currentProfileObject.tautulliEnabled ?? false;
            case LunaModule.WAKE_ON_LAN: return Database.currentProfileObject.wakeOnLANEnabled ?? false;
        }
        throw Exception('Invalid LunaModule');
    }

    String get name {
        switch(this) {
            case LunaModule.DASHBOARD: return 'lunasea.Dashboard'.tr();
            case LunaModule.LIDARR: return 'Lidarr';
            case LunaModule.NZBGET: return 'NZBGet';
            case LunaModule.RADARR: return 'Radarr';
            case LunaModule.SABNZBD: return 'SABnzbd';
            case LunaModule.SEARCH: return 'search.Search'.tr();
            case LunaModule.SETTINGS: return 'lunasea.Settings'.tr();
            case LunaModule.SONARR: return 'Sonarr';
            case LunaModule.TAUTULLI: return 'Tautulli';
            case LunaModule.WAKE_ON_LAN: return 'Wake on LAN';
        }
        throw Exception('Invalid LunaModule');
    }

    String get route {
        switch(this) {
            case LunaModule.DASHBOARD: return Dashboard.ROUTE_NAME;
            case LunaModule.LIDARR: return Lidarr.ROUTE_NAME;
            case LunaModule.NZBGET: return NZBGet.ROUTE_NAME;
            case LunaModule.RADARR: return RadarrHomeRouter().route();
            case LunaModule.SABNZBD: return SABnzbd.ROUTE_NAME;
            case LunaModule.SEARCH: return SearchHomeRouter().route();
            case LunaModule.SETTINGS: return SettingsHomeRouter().route();
            case LunaModule.SONARR: return SonarrHomeRouter().route();
            case LunaModule.TAUTULLI: return TautulliHomeRouter.ROUTE_NAME;
            case LunaModule.WAKE_ON_LAN: return null;
        }
        throw Exception('Invalid LunaModule');
    }

    IconData get icon {
        switch(this) {
            case LunaModule.DASHBOARD: return CustomIcons.home;
            case LunaModule.LIDARR: return CustomIcons.music;
            case LunaModule.NZBGET: return CustomIcons.nzbget;
            case LunaModule.RADARR: return CustomIcons.radarr;
            case LunaModule.SABNZBD: return CustomIcons.sabnzbd;
            case LunaModule.SEARCH: return Icons.search_rounded;
            case LunaModule.SETTINGS: return CustomIcons.settings;
            case LunaModule.SONARR: return CustomIcons.television;
            case LunaModule.TAUTULLI: return CustomIcons.tautulli;
            case LunaModule.WAKE_ON_LAN: return Icons.settings_remote;
        }
        throw Exception('Invalid LunaModule');
    }

    Color get color {
        switch(this) {
            case LunaModule.DASHBOARD: return LunaColours.accent;
            case LunaModule.LIDARR: return Color(0xFF159552);
            case LunaModule.NZBGET: return Color(0xFF42D535);
            case LunaModule.RADARR: return Color(0xFFFEC333);
            case LunaModule.SABNZBD: return Color(0xFFFECC2B);
            case LunaModule.SEARCH: return LunaColours.accent;
            case LunaModule.SETTINGS: return LunaColours.accent;
            case LunaModule.SONARR: return Color(0xFF3FC6F4);
            case LunaModule.TAUTULLI: return Color(0xFFDBA23A);
            case LunaModule.WAKE_ON_LAN: return LunaColours.accent;
        }
        throw Exception('Invalid LunaModule');
    }

    String get website {
        switch(this) {
            case LunaModule.DASHBOARD: return null;
            case LunaModule.LIDARR: return 'https://lidarr.audio';
            case LunaModule.NZBGET: return 'https://nzbget.net';
            case LunaModule.RADARR: return 'https://radarr.video';
            case LunaModule.SABNZBD: return 'https://sabnzbd.org';
            case LunaModule.SEARCH: return null;
            case LunaModule.SETTINGS: return null;
            case LunaModule.SONARR: return 'https://sonarr.tv';
            case LunaModule.TAUTULLI: return 'https://tautulli.com';
            case LunaModule.WAKE_ON_LAN: return null;
        }
        throw Exception('Invalid LunaModule');
    }

    String get github {
        switch(this) {
            case LunaModule.DASHBOARD: return null;
            case LunaModule.LIDARR: return 'https://github.com/Lidarr/Lidarr';
            case LunaModule.NZBGET: return 'https://github.com/nzbget/nzbget';
            case LunaModule.RADARR: return 'https://github.com/Radarr/Radarr';
            case LunaModule.SABNZBD: return 'https://github.com/sabnzbd/sabnzbd';
            case LunaModule.SEARCH: return 'https://github.com/theotherp/nzbhydra2';
            case LunaModule.SETTINGS: return null;
            case LunaModule.SONARR: return 'https://github.com/Sonarr/Sonarr';
            case LunaModule.TAUTULLI: return 'https://github.com/Tautulli/Tautulli';
            case LunaModule.WAKE_ON_LAN: return null;
        }
        throw Exception('Invalid LunaModule');
    }

    String get description {
        switch(this) {
            case LunaModule.DASHBOARD: return 'lunasea.Dashboard'.tr();
            case LunaModule.LIDARR: return 'Manage Music';
            case LunaModule.NZBGET: return 'Manage Usenet Downloads';
            case LunaModule.RADARR: return 'Manage Movies';
            case LunaModule.SABNZBD: return 'Manage Usenet Downloads';
            case LunaModule.SEARCH: return 'Search Newznab Indexers';
            case LunaModule.SETTINGS: return 'Configure LunaSea';
            case LunaModule.SONARR: return 'Manage Television Series';
            case LunaModule.TAUTULLI: return 'View Plex Activity';
            case LunaModule.WAKE_ON_LAN: return 'Wake Your Machine';
        }
        throw Exception('Invalid LunaModule');
    }

    String get information {
        switch(this) {
            case LunaModule.DASHBOARD: return null;
            case LunaModule.LIDARR: return 'Lidarr is a music collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new tracks from your favorite artists and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.';
            case LunaModule.NZBGET: return 'NZBGet is a binary downloader, which downloads files from Usenet based on information given in nzb-files.';
            case LunaModule.RADARR: return 'Radarr is a movie collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new movies and will interface with clients and indexers to grab, sort, and rename them. It can also be configured to automatically upgrade the quality of existing files in the library when a better quality format becomes available.';
            case LunaModule.SABNZBD: return 'SABnzbd is a multi-platform binary newsgroup downloader. The program works in the background and simplifies the downloading verifying and extracting of files from Usenet.';
            case LunaModule.SEARCH: return 'LunaSea currently supports all indexers that support the newznab protocol, including NZBHydra2.';
            case LunaModule.SETTINGS: return null;
            case LunaModule.SONARR: return 'Sonarr is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.';
            case LunaModule.TAUTULLI: return 'Tautulli is an application that you can run alongside your Plex Media Server to monitor activity and track various statistics. Most importantly, these statistics include what has been watched, who watched it, when and where they watched it, and how it was watched.';
            case LunaModule.WAKE_ON_LAN: return 'Wake on LAN is an industry standard protocol for waking computers up from a very low power mode remotely by sending a specially constructed packet to the machine.';
        }
        throw Exception('Invalid LunaModule');
    }

    ShortcutItem get shortcutItem {
        switch(this) {
            case LunaModule.DASHBOARD: return ShortcutItem(type: key, localizedTitle: name);
            case LunaModule.LIDARR: return ShortcutItem(type: key, localizedTitle: name);
            case LunaModule.NZBGET: return ShortcutItem(type: key, localizedTitle: name);
            case LunaModule.RADARR: return ShortcutItem(type: key, localizedTitle: name);
            case LunaModule.SABNZBD: return ShortcutItem(type: key, localizedTitle: name);
            case LunaModule.SEARCH: return ShortcutItem(type: key, localizedTitle: name);
            case LunaModule.SETTINGS: return ShortcutItem(type: key, localizedTitle: name);
            case LunaModule.SONARR: return ShortcutItem(type: key, localizedTitle: name);
            case LunaModule.TAUTULLI: return ShortcutItem(type: key, localizedTitle: name);
            case LunaModule.WAKE_ON_LAN: return null;          
        }
        throw Exception('Invalid LunaModule');
    }

    Future<void> handleWebhook(Map<String, dynamic> data) async {
        switch(this) {
            case LunaModule.DASHBOARD: return;
            case LunaModule.LIDARR: return LidarrWebhooks().handle(data);
            case LunaModule.NZBGET: return;
            case LunaModule.RADARR: return RadarrWebhooks().handle(data);
            case LunaModule.SABNZBD: return;
            case LunaModule.SEARCH: return;
            case LunaModule.SETTINGS: return;
            case LunaModule.SONARR: return SonarrWebhooks().handle(data);
            case LunaModule.TAUTULLI: return;
            case LunaModule.WAKE_ON_LAN: return;
        }
        throw Exception('Invalid LunaModule');
    }

    Future<void> launch() async {
        if(route != null) LunaState.navigatorKey.currentState.pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
    }
}
