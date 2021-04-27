import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';
import 'package:quick_actions/quick_actions.dart';

part 'modules.g.dart';

const _DASHBOARD_KEY = 'dashboard';
const _LIDARR_KEY = 'lidarr';
const _NZBGET_KEY = 'nzbget';
const _OVERSEERR_KEY = 'overseerr';
const _RADARR_KEY = 'radarr';
const _SABNZBD_KEY = 'sabnzbd';
const _SEARCH_KEY = 'search';
const _SETTINGS_KEY = 'settings';
const _SONARR_KEY = 'sonarr';
const _TAUTULLI_KEY = 'tautulli';
const _WAKE_ON_LAN_KEY = 'wake_on_lan';

@HiveType(typeId: 25, adapterName: 'LunaModuleAdapter')
enum LunaModule {
  @HiveField(0)
  DASHBOARD,
  @HiveField(1)
  LIDARR,
  @HiveField(2)
  NZBGET,
  @HiveField(3)
  OVERSEERR,
  @HiveField(4)
  RADARR,
  @HiveField(5)
  SABNZBD,
  @HiveField(6)
  SEARCH,
  @HiveField(7)
  SETTINGS,
  @HiveField(8)
  SONARR,
  @HiveField(9)
  TAUTULLI,
  @HiveField(10)
  WAKE_ON_LAN,
}

extension LunaModuleExtension on LunaModule {
  /// Returns a list of only active/enabled _external_ modules.
  ///
  /// External modules are modules that are not entirely internal (dashboard, settings, etc.)
  List<LunaModule> allExternalModules() {
    List<LunaModule> modules = LunaModule.values.toList()
      ..remove(LunaModule.DASHBOARD)
      ..remove(LunaModule.SETTINGS);
    // Remove additional hidden modules
    if (kReleaseMode) modules.remove(LunaModule.OVERSEERR);
    return modules;
  }

  /// Used to convert a string key back to a [LunaModule] value.
  ///
  /// If the key is not found, returns null.
  LunaModule fromKey(String key) {
    switch (key) {
      case _DASHBOARD_KEY:
        return LunaModule.DASHBOARD;
      case _LIDARR_KEY:
        return LunaModule.LIDARR;
      case _NZBGET_KEY:
        return LunaModule.NZBGET;
      case _RADARR_KEY:
        return LunaModule.RADARR;
      case _SABNZBD_KEY:
        return LunaModule.SABNZBD;
      case _SEARCH_KEY:
        return LunaModule.SEARCH;
      case _SETTINGS_KEY:
        return LunaModule.SETTINGS;
      case _SONARR_KEY:
        return LunaModule.SONARR;
      case _OVERSEERR_KEY:
        return LunaModule.OVERSEERR;
      case _TAUTULLI_KEY:
        return LunaModule.TAUTULLI;
      case _WAKE_ON_LAN_KEY:
        return LunaModule.WAKE_ON_LAN;
    }
    return null;
  }

  /// Given a [LunaModule], return the module's key.
  String get key {
    switch (this) {
      case LunaModule.DASHBOARD:
        return _DASHBOARD_KEY;
      case LunaModule.LIDARR:
        return _LIDARR_KEY;
      case LunaModule.NZBGET:
        return _NZBGET_KEY;
      case LunaModule.RADARR:
        return _RADARR_KEY;
      case LunaModule.SABNZBD:
        return _SABNZBD_KEY;
      case LunaModule.SEARCH:
        return _SEARCH_KEY;
      case LunaModule.SETTINGS:
        return _SETTINGS_KEY;
      case LunaModule.SONARR:
        return _SONARR_KEY;
      case LunaModule.OVERSEERR:
        return _OVERSEERR_KEY;
      case LunaModule.TAUTULLI:
        return _TAUTULLI_KEY;
      case LunaModule.WAKE_ON_LAN:
        return _WAKE_ON_LAN_KEY;
    }
    throw Exception('Invalid LunaModule');
  }

  /// Returns true if the module is enabled in the current profile.
  bool get isEnabled {
    switch (this) {
      case LunaModule.DASHBOARD:
        return true;
      case LunaModule.SETTINGS:
        return true;
      case LunaModule.LIDARR:
        return Database.currentProfileObject?.lidarrEnabled ?? false;
      case LunaModule.NZBGET:
        return Database.currentProfileObject?.nzbgetEnabled ?? false;
      case LunaModule.OVERSEERR:
        return Database.currentProfileObject?.overseerrEnabled ?? false;
      case LunaModule.RADARR:
        return Database.currentProfileObject?.radarrEnabled ?? false;
      case LunaModule.SABNZBD:
        return Database.currentProfileObject?.sabnzbdEnabled ?? false;
      case LunaModule.SEARCH:
        return Database.indexersBox?.isNotEmpty ?? false;
      case LunaModule.SONARR:
        return Database.currentProfileObject?.sonarrEnabled ?? false;
      case LunaModule.TAUTULLI:
        return Database.currentProfileObject?.tautulliEnabled ?? false;
      case LunaModule.WAKE_ON_LAN:
        return Database.currentProfileObject?.wakeOnLANEnabled ?? false;
    }
    throw Exception('Invalid LunaModule');
  }

  /// Fetch the currently loaded configuration for a module.
  ///
  /// Pulled from the currently loaded profile.
  Map<String, dynamic> get loadedConfiguration {
    switch (this) {
      case LunaModule.DASHBOARD:
        return {};
      case LunaModule.LIDARR:
        return Database.currentProfileObject.getLidarr();
      case LunaModule.NZBGET:
        return Database.currentProfileObject.getNZBGet();
      case LunaModule.OVERSEERR:
        return Database.currentProfileObject.getOverseerr();
      case LunaModule.RADARR:
        return Database.currentProfileObject.getRadarr();
      case LunaModule.SABNZBD:
        return Database.currentProfileObject.getSABnzbd();
      case LunaModule.SEARCH:
        return Database.indexersBox
            .toMap()
            .map((key, value) => MapEntry(key.toString(), value.toMap()));
      case LunaModule.SETTINGS:
        return {};
      case LunaModule.SONARR:
        return Database.currentProfileObject.getSonarr();
      case LunaModule.TAUTULLI:
        return Database.currentProfileObject.getTautulli();
      case LunaModule.WAKE_ON_LAN:
        return Database.currentProfileObject.getWakeOnLAN();
    }
    throw Exception('Invalid LunaModule');
  }

  /// The name of the module.
  String get name {
    switch (this) {
      case LunaModule.DASHBOARD:
        return 'lunasea.Dashboard'.tr();
      case LunaModule.LIDARR:
        return 'Lidarr';
      case LunaModule.NZBGET:
        return 'NZBGet';
      case LunaModule.RADARR:
        return 'Radarr';
      case LunaModule.SABNZBD:
        return 'SABnzbd';
      case LunaModule.SEARCH:
        return 'search.Search'.tr();
      case LunaModule.SETTINGS:
        return 'lunasea.Settings'.tr();
      case LunaModule.SONARR:
        return 'Sonarr';
      case LunaModule.TAUTULLI:
        return 'Tautulli';
      case LunaModule.OVERSEERR:
        return 'Overseerr';
      case LunaModule.WAKE_ON_LAN:
        return 'Wake on LAN';
    }
    throw Exception('Invalid LunaModule');
  }

  /// The full base/home route for the module.
  String get route {
    switch (this) {
      case LunaModule.DASHBOARD:
        return DashboardHomeRouter().route();
      case LunaModule.LIDARR:
        return Lidarr.ROUTE_NAME;
      case LunaModule.NZBGET:
        return NZBGet.ROUTE_NAME;
      case LunaModule.RADARR:
        return RadarrHomeRouter().route();
      case LunaModule.SABNZBD:
        return SABnzbd.ROUTE_NAME;
      case LunaModule.SEARCH:
        return SearchHomeRouter().route();
      case LunaModule.SETTINGS:
        return SettingsHomeRouter().route();
      case LunaModule.SONARR:
        return SonarrHomeRouter().route();
      case LunaModule.TAUTULLI:
        return TautulliHomeRouter().route();
      case LunaModule.OVERSEERR:
        return OverseerrHomeRouter().route();
      case LunaModule.WAKE_ON_LAN:
        return null;
    }
    throw Exception('Invalid LunaModule');
  }

  /// The module's icon.
  IconData get icon {
    switch (this) {
      case LunaModule.DASHBOARD:
        return LunaIcons.home;
      case LunaModule.LIDARR:
        return LunaIcons.music;
      case LunaModule.NZBGET:
        return LunaIcons.nzbget;
      case LunaModule.RADARR:
        return LunaIcons.radarr;
      case LunaModule.SABNZBD:
        return LunaIcons.sabnzbd;
      case LunaModule.SEARCH:
        return Icons.search_rounded;
      case LunaModule.SETTINGS:
        return LunaIcons.settings;
      case LunaModule.SONARR:
        return LunaIcons.television;
      case LunaModule.TAUTULLI:
        return LunaIcons.tautulli;
      case LunaModule.OVERSEERR:
        return LunaIcons.overseerr;
      case LunaModule.WAKE_ON_LAN:
        return Icons.settings_remote_rounded;
    }
    throw Exception('Invalid LunaModule');
  }

  /// The [LunaModuleDatabase] for the module.
  LunaModuleDatabase get database {
    switch (this) {
      case LunaModule.SETTINGS:
        return null;
      case LunaModule.WAKE_ON_LAN:
        return null;
      case LunaModule.DASHBOARD:
        return DashboardDatabase();
      case LunaModule.SEARCH:
        return SearchDatabase();
      case LunaModule.LIDARR:
        return LidarrDatabase();
      case LunaModule.RADARR:
        return RadarrDatabase();
      case LunaModule.SONARR:
        return SonarrDatabase();
      case LunaModule.NZBGET:
        return NZBGetDatabase();
      case LunaModule.SABNZBD:
        return SABnzbdDatabase();
      case LunaModule.OVERSEERR:
        return OverseerrDatabase();
      case LunaModule.TAUTULLI:
        return TautulliDatabase();
    }
    throw Exception('Invalid LunaModule');
  }

  /// The global provider/state for the module.
  LunaModuleState state(BuildContext context) {
    switch (this) {
      case LunaModule.WAKE_ON_LAN:
        return null;
      case LunaModule.DASHBOARD:
        return context.read<DashboardState>();
      case LunaModule.SETTINGS:
        return context.read<SettingsState>();
      case LunaModule.SEARCH:
        return context.read<SearchState>();
      case LunaModule.LIDARR:
        return context.read<LidarrState>();
      case LunaModule.RADARR:
        return context.read<RadarrState>();
      case LunaModule.SONARR:
        return context.read<SonarrState>();
      case LunaModule.NZBGET:
        return context.read<NZBGetState>();
      case LunaModule.SABNZBD:
        return context.read<SABnzbdState>();
      case LunaModule.OVERSEERR:
        return context.read<OverseerrState>();
      case LunaModule.TAUTULLI:
        return context.read<TautulliState>();
    }
    throw Exception('Invalid LunaModule');
  }

  /// The module's brand colour.
  Color get color {
    switch (this) {
      case LunaModule.DASHBOARD:
        return LunaColours.accent;
      case LunaModule.LIDARR:
        return Color(0xFF159552);
      case LunaModule.NZBGET:
        return Color(0xFF42D535);
      case LunaModule.RADARR:
        return Color(0xFFFEC333);
      case LunaModule.SABNZBD:
        return Color(0xFFFECC2B);
      case LunaModule.SEARCH:
        return LunaColours.accent;
      case LunaModule.SETTINGS:
        return LunaColours.accent;
      case LunaModule.SONARR:
        return Color(0xFF3FC6F4);
      case LunaModule.TAUTULLI:
        return Color(0xFFDBA23A);
      case LunaModule.OVERSEERR:
        return Color(0xFF6366F1);
      case LunaModule.WAKE_ON_LAN:
        return LunaColours.accent;
    }
    throw Exception('Invalid LunaModule');
  }

  /// If available, the module's website.
  String get website {
    switch (this) {
      case LunaModule.DASHBOARD:
        return null;
      case LunaModule.LIDARR:
        return 'https://lidarr.audio';
      case LunaModule.NZBGET:
        return 'https://nzbget.net';
      case LunaModule.RADARR:
        return 'https://radarr.video';
      case LunaModule.SABNZBD:
        return 'https://sabnzbd.org';
      case LunaModule.SEARCH:
        return null;
      case LunaModule.SETTINGS:
        return null;
      case LunaModule.SONARR:
        return 'https://sonarr.tv';
      case LunaModule.TAUTULLI:
        return 'https://tautulli.com';
      case LunaModule.OVERSEERR:
        return 'https://overseerr.dev';
      case LunaModule.WAKE_ON_LAN:
        return null;
    }
    throw Exception('Invalid LunaModule');
  }

  /// If available, link to the module's GitHub repository.
  String get github {
    switch (this) {
      case LunaModule.DASHBOARD:
        return null;
      case LunaModule.LIDARR:
        return 'https://github.com/Lidarr/Lidarr';
      case LunaModule.NZBGET:
        return 'https://github.com/nzbget/nzbget';
      case LunaModule.RADARR:
        return 'https://github.com/Radarr/Radarr';
      case LunaModule.SABNZBD:
        return 'https://github.com/sabnzbd/sabnzbd';
      case LunaModule.SEARCH:
        return 'https://github.com/theotherp/nzbhydra2';
      case LunaModule.SETTINGS:
        return null;
      case LunaModule.SONARR:
        return 'https://github.com/Sonarr/Sonarr';
      case LunaModule.TAUTULLI:
        return 'https://github.com/Tautulli/Tautulli';
      case LunaModule.OVERSEERR:
        return 'https://github.com/sct/overseerr';
      case LunaModule.WAKE_ON_LAN:
        return null;
    }
    throw Exception('Invalid LunaModule');
  }

  /// Description of the module, to be used in the module list.
  String get description {
    switch (this) {
      case LunaModule.DASHBOARD:
        return 'lunasea.Dashboard'.tr();
      case LunaModule.LIDARR:
        return 'Manage Music';
      case LunaModule.NZBGET:
        return 'Manage Usenet Downloads';
      case LunaModule.RADARR:
        return 'Manage Movies';
      case LunaModule.SABNZBD:
        return 'Manage Usenet Downloads';
      case LunaModule.SEARCH:
        return 'Search Newznab Indexers';
      case LunaModule.SETTINGS:
        return 'Configure LunaSea';
      case LunaModule.SONARR:
        return 'Manage Television Series';
      case LunaModule.TAUTULLI:
        return 'View Plex Activity';
      case LunaModule.OVERSEERR:
        return 'Manage Requests for New Content';
      case LunaModule.WAKE_ON_LAN:
        return 'Wake Your Machine';
    }
    throw Exception('Invalid LunaModule');
  }

  /// Return the description/information for the module.
  ///
  /// This is the full information, copied from each module's website/GitHub.
  String get information {
    switch (this) {
      case LunaModule.DASHBOARD:
        return null;
      case LunaModule.LIDARR:
        return 'Lidarr is a music collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new tracks from your favorite artists and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.';
      case LunaModule.NZBGET:
        return 'NZBGet is a binary downloader, which downloads files from Usenet based on information given in nzb-files.';
      case LunaModule.RADARR:
        return 'Radarr is a movie collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new movies and will interface with clients and indexers to grab, sort, and rename them. It can also be configured to automatically upgrade the quality of existing files in the library when a better quality format becomes available.';
      case LunaModule.SABNZBD:
        return 'SABnzbd is a multi-platform binary newsgroup downloader. The program works in the background and simplifies the downloading verifying and extracting of files from Usenet.';
      case LunaModule.SEARCH:
        return 'LunaSea currently supports all indexers that support the newznab protocol, including NZBHydra2.';
      case LunaModule.SETTINGS:
        return null;
      case LunaModule.SONARR:
        return 'Sonarr is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.';
      case LunaModule.TAUTULLI:
        return 'Tautulli is an application that you can run alongside your Plex Media Server to monitor activity and track various statistics. Most importantly, these statistics include what has been watched, who watched it, when and where they watched it, and how it was watched.';
      case LunaModule.OVERSEERR:
        return 'Overseerr is a free and open source software application for managing requests for your media library. It integrates with your existing services, such as Sonarr, Radarr, and Plex!';
      case LunaModule.WAKE_ON_LAN:
        return 'Wake on LAN is an industry standard protocol for waking computers up from a very low power mode remotely by sending a specially constructed packet to the machine.';
    }
    throw Exception('Invalid LunaModule');
  }

  /// Return the [ShortcutItem] for the module.
  ShortcutItem get shortcutItem {
    switch (this) {
      case LunaModule.DASHBOARD:
        return ShortcutItem(type: key, localizedTitle: name);
      case LunaModule.LIDARR:
        return ShortcutItem(type: key, localizedTitle: name);
      case LunaModule.NZBGET:
        return ShortcutItem(type: key, localizedTitle: name);
      case LunaModule.RADARR:
        return ShortcutItem(type: key, localizedTitle: name);
      case LunaModule.SABNZBD:
        return ShortcutItem(type: key, localizedTitle: name);
      case LunaModule.SEARCH:
        return ShortcutItem(type: key, localizedTitle: name);
      case LunaModule.SETTINGS:
        return ShortcutItem(type: key, localizedTitle: name);
      case LunaModule.SONARR:
        return ShortcutItem(type: key, localizedTitle: name);
      case LunaModule.TAUTULLI:
        return ShortcutItem(type: key, localizedTitle: name);
      case LunaModule.OVERSEERR:
        return ShortcutItem(type: key, localizedTitle: name);
      case LunaModule.WAKE_ON_LAN:
        return null;
    }
    throw Exception('Invalid LunaModule');
  }

  /// Returns true if the module has a webhook handler available.
  bool get hasWebhooks {
    switch (this) {
      case LunaModule.DASHBOARD:
        return false;
      case LunaModule.LIDARR:
        return true;
      case LunaModule.NZBGET:
        return false;
      case LunaModule.RADARR:
        return true;
      case LunaModule.SABNZBD:
        return false;
      case LunaModule.SEARCH:
        return false;
      case LunaModule.SETTINGS:
        return false;
      case LunaModule.SONARR:
        return true;
      case LunaModule.OVERSEERR:
        return true;
      case LunaModule.TAUTULLI:
        return true;
      case LunaModule.WAKE_ON_LAN:
        return false;
    }
    throw Exception('Invalid LunaModule');
  }

  /// Clears/hides all banners for the module.
  void hideAllBanners() {
    switch (this) {
      case LunaModule.DASHBOARD:
        return;
      case LunaModule.LIDARR:
        return;
      case LunaModule.NZBGET:
        return;
      case LunaModule.RADARR:
        return;
      case LunaModule.SABNZBD:
        return;
      case LunaModule.SEARCH:
        return;
      case LunaModule.SETTINGS:
        return SettingsBanners.values.forEach((banner) => banner.markSeen());
      case LunaModule.SONARR:
        return;
      case LunaModule.TAUTULLI:
        return;
      case LunaModule.OVERSEERR:
        return;
      case LunaModule.WAKE_ON_LAN:
        return;
    }
    throw Exception('Invalid LunaModule');
  }

  /// Execute and handle the webhook for the module.
  Future<void> handleWebhook(Map<String, dynamic> data) async {
    switch (this) {
      case LunaModule.DASHBOARD:
        return;
      case LunaModule.LIDARR:
        return LidarrWebhooks().handle(data);
      case LunaModule.NZBGET:
        return;
      case LunaModule.RADARR:
        return RadarrWebhooks().handle(data);
      case LunaModule.SABNZBD:
        return;
      case LunaModule.SEARCH:
        return;
      case LunaModule.SETTINGS:
        return;
      case LunaModule.SONARR:
        return SonarrWebhooks().handle(data);
      case LunaModule.OVERSEERR:
        return OverseerrWebhooks().handle(data);
      case LunaModule.TAUTULLI:
        return TautulliWebhooks().handle(data);
      case LunaModule.WAKE_ON_LAN:
        return;
    }
    throw Exception('Invalid LunaModule');
  }

  /// Return the [SettingsPageRouter] for the module.
  SettingsPageRouter get settingsPage {
    switch (this) {
      case LunaModule.DASHBOARD:
        return SettingsConfigurationDashboardRouter();
      case LunaModule.LIDARR:
        return SettingsConfigurationLidarrRouter();
      case LunaModule.NZBGET:
        return SettingsConfigurationNZBGetRouter();
      case LunaModule.OVERSEERR:
        return SettingsConfigurationOverseerrRouter();
      case LunaModule.RADARR:
        return SettingsConfigurationRadarrRouter();
      case LunaModule.SABNZBD:
        return SettingsConfigurationSABnzbdRouter();
      case LunaModule.SEARCH:
        return SettingsConfigurationSearchRouter();
      case LunaModule.SETTINGS:
        return null;
      case LunaModule.SONARR:
        return SettingsConfigurationSonarrRouter();
      case LunaModule.TAUTULLI:
        return SettingsConfigurationTautulliRouter();
      case LunaModule.WAKE_ON_LAN:
        return SettingsConfigurationWakeOnLANRouter();
    }
    throw Exception('Invalid LunaModule');
  }

  Future<void> launch() async {
    if (route != null)
      LunaState.navigatorKey.currentState
          .pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
  }
}
