import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/router/router.dart';
import 'package:lunasea/router/routes.dart';
import 'package:lunasea/router/routes/settings.dart';
import 'package:quick_actions/quick_actions.dart';

import 'package:lunasea/modules/search.dart';
import 'package:lunasea/modules/settings.dart';

import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/modules/overseerr.dart';
import 'package:lunasea/modules/sabnzbd.dart';
import 'package:lunasea/modules/nzbget.dart';
import 'package:lunasea/modules/tautulli.dart';

import 'package:lunasea/modules/dashboard/core/state.dart' as dashboard_state;
import 'package:lunasea/api/wake_on_lan/wake_on_lan.dart';
import 'package:lunasea/system/flavor.dart';

part 'modules.g.dart';

const MODULE_DASHBOARD_KEY = 'dashboard';
const MODULE_EXTERNAL_MODULES_KEY = 'external_modules';
const MODULE_LIDARR_KEY = 'lidarr';
const MODULE_NZBGET_KEY = 'nzbget';
const MODULE_OVERSEERR_KEY = 'overseerr';
const MODULE_RADARR_KEY = 'radarr';
const MODULE_SABNZBD_KEY = 'sabnzbd';
const MODULE_SEARCH_KEY = 'search';
const MODULE_SETTINGS_KEY = 'settings';
const MODULE_SONARR_KEY = 'sonarr';
const MODULE_TAUTULLI_KEY = 'tautulli';
const MODULE_WAKE_ON_LAN_KEY = 'wake_on_lan';

@HiveType(typeId: 25, adapterName: 'LunaModuleAdapter')
enum LunaModule {
  @HiveField(0)
  DASHBOARD(MODULE_DASHBOARD_KEY),
  @HiveField(11)
  EXTERNAL_MODULES(MODULE_EXTERNAL_MODULES_KEY),
  @HiveField(1)
  LIDARR(MODULE_LIDARR_KEY),
  @HiveField(2)
  NZBGET(MODULE_NZBGET_KEY),
  @HiveField(3)
  OVERSEERR(MODULE_OVERSEERR_KEY),
  @HiveField(4)
  RADARR(MODULE_RADARR_KEY),
  @HiveField(5)
  SABNZBD(MODULE_SABNZBD_KEY),
  @HiveField(6)
  SEARCH(MODULE_SEARCH_KEY),
  @HiveField(7)
  SETTINGS(MODULE_SETTINGS_KEY),
  @HiveField(8)
  SONARR(MODULE_SONARR_KEY),
  @HiveField(9)
  TAUTULLI(MODULE_TAUTULLI_KEY),
  @HiveField(10)
  WAKE_ON_LAN(MODULE_WAKE_ON_LAN_KEY);

  final String key;
  const LunaModule(this.key);

  static LunaModule? fromKey(String? key) {
    switch (key) {
      case MODULE_DASHBOARD_KEY:
        return LunaModule.DASHBOARD;
      case MODULE_LIDARR_KEY:
        return LunaModule.LIDARR;
      case MODULE_NZBGET_KEY:
        return LunaModule.NZBGET;
      case MODULE_RADARR_KEY:
        return LunaModule.RADARR;
      case MODULE_SABNZBD_KEY:
        return LunaModule.SABNZBD;
      case MODULE_SEARCH_KEY:
        return LunaModule.SEARCH;
      case MODULE_SETTINGS_KEY:
        return LunaModule.SETTINGS;
      case MODULE_SONARR_KEY:
        return LunaModule.SONARR;
      case MODULE_OVERSEERR_KEY:
        return LunaModule.OVERSEERR;
      case MODULE_TAUTULLI_KEY:
        return LunaModule.TAUTULLI;
      case MODULE_WAKE_ON_LAN_KEY:
        return LunaModule.WAKE_ON_LAN;
      case MODULE_EXTERNAL_MODULES_KEY:
        return LunaModule.EXTERNAL_MODULES;
    }
    return null;
  }

  static List<LunaModule> get active {
    return LunaModule.values.filter((m) {
      if (m == LunaModule.DASHBOARD) return false;
      if (m == LunaModule.SETTINGS) return false;
      return m.featureFlag;
    }).toList();
  }
}

extension LunaModuleEnablementExtension on LunaModule {
  bool get featureFlag {
    switch (this) {
      case LunaModule.OVERSEERR:
        return LunaFlavor.EDGE.isRunningFlavor();
      case LunaModule.WAKE_ON_LAN:
        return LunaWakeOnLAN.isSupported;
      default:
        return true;
    }
  }

  bool get isEnabled {
    switch (this) {
      case LunaModule.DASHBOARD:
        return true;
      case LunaModule.SETTINGS:
        return true;
      case LunaModule.LIDARR:
        return LunaProfile.current.lidarrEnabled;
      case LunaModule.NZBGET:
        return LunaProfile.current.nzbgetEnabled;
      case LunaModule.OVERSEERR:
        return LunaProfile.current.overseerrEnabled;
      case LunaModule.RADARR:
        return LunaProfile.current.radarrEnabled;
      case LunaModule.SABNZBD:
        return LunaProfile.current.sabnzbdEnabled;
      case LunaModule.SEARCH:
        return !LunaBox.indexers.isEmpty;
      case LunaModule.SONARR:
        return LunaProfile.current.sonarrEnabled;
      case LunaModule.TAUTULLI:
        return LunaProfile.current.tautulliEnabled;
      case LunaModule.WAKE_ON_LAN:
        return LunaProfile.current.wakeOnLANEnabled;
      case LunaModule.EXTERNAL_MODULES:
        return !LunaBox.externalModules.isEmpty;
    }
  }
}

extension LunaModuleMetadataExtension on LunaModule {
  String get title {
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
      case LunaModule.EXTERNAL_MODULES:
        return 'lunasea.ExternalModules'.tr();
    }
  }

  IconData get icon {
    switch (this) {
      case LunaModule.DASHBOARD:
        return Icons.home_rounded;
      case LunaModule.LIDARR:
        return LunaIcons.LIDARR;
      case LunaModule.NZBGET:
        return LunaIcons.NZBGET;
      case LunaModule.RADARR:
        return LunaIcons.RADARR;
      case LunaModule.SABNZBD:
        return LunaIcons.SABNZBD;
      case LunaModule.SEARCH:
        return Icons.search_rounded;
      case LunaModule.SETTINGS:
        return Icons.settings_rounded;
      case LunaModule.SONARR:
        return LunaIcons.SONARR;
      case LunaModule.TAUTULLI:
        return LunaIcons.TAUTULLI;
      case LunaModule.OVERSEERR:
        return LunaIcons.OVERSEERR;
      case LunaModule.WAKE_ON_LAN:
        return Icons.settings_remote_rounded;
      case LunaModule.EXTERNAL_MODULES:
        return Icons.settings_ethernet_rounded;
    }
  }

  Color get color {
    switch (this) {
      case LunaModule.DASHBOARD:
        return LunaColours.accent;
      case LunaModule.LIDARR:
        return const Color(0xFF159552);
      case LunaModule.NZBGET:
        return const Color(0xFF42D535);
      case LunaModule.RADARR:
        return const Color(0xFFFEC333);
      case LunaModule.SABNZBD:
        return const Color(0xFFFECC2B);
      case LunaModule.SEARCH:
        return LunaColours.accent;
      case LunaModule.SETTINGS:
        return LunaColours.accent;
      case LunaModule.SONARR:
        return const Color(0xFF3FC6F4);
      case LunaModule.TAUTULLI:
        return const Color(0xFFDBA23A);
      case LunaModule.OVERSEERR:
        return const Color(0xFF6366F1);
      case LunaModule.WAKE_ON_LAN:
        return LunaColours.accent;
      case LunaModule.EXTERNAL_MODULES:
        return LunaColours.accent;
    }
  }

  String? get website {
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
      case LunaModule.EXTERNAL_MODULES:
        return null;
    }
  }

  String? get github {
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
      case LunaModule.EXTERNAL_MODULES:
        return null;
    }
  }

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
      case LunaModule.EXTERNAL_MODULES:
        return 'Access External Modules';
    }
  }

  String? get information {
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
      case LunaModule.EXTERNAL_MODULES:
        return 'LunaSea allows you to add links to additional modules that are not currently supported allowing you to open the module\'s web GUI without having to leave LunaSea!';
    }
  }
}

extension LunaModuleRoutingExtension on LunaModule {
  String? get homeRoute {
    switch (this) {
      case LunaModule.DASHBOARD:
        return LunaRoutes.dashboard.root.path;
      case LunaModule.LIDARR:
        return LunaRoutes.lidarr.root.path;
      case LunaModule.NZBGET:
        return LunaRoutes.nzbget.root.path;
      case LunaModule.RADARR:
        return LunaRoutes.radarr.root.path;
      case LunaModule.SABNZBD:
        return LunaRoutes.sabnzbd.root.path;
      case LunaModule.SEARCH:
        return LunaRoutes.search.root.path;
      case LunaModule.SETTINGS:
        return LunaRoutes.settings.root.path;
      case LunaModule.SONARR:
        return LunaRoutes.sonarr.root.path;
      case LunaModule.TAUTULLI:
        return LunaRoutes.tautulli.root.path;
      case LunaModule.OVERSEERR:
        return LunaRoutes.overseerr.root.path;
      case LunaModule.WAKE_ON_LAN:
        return null;
      case LunaModule.EXTERNAL_MODULES:
        return LunaRoutes.externalModules.root.path;
    }
  }

  SettingsRoutes? get settingsRoute {
    switch (this) {
      case LunaModule.DASHBOARD:
        return SettingsRoutes.CONFIGURATION_DASHBOARD;
      case LunaModule.LIDARR:
        return SettingsRoutes.CONFIGURATION_LIDARR;
      case LunaModule.NZBGET:
        return SettingsRoutes.CONFIGURATION_NZBGET;
      case LunaModule.OVERSEERR:
        return SettingsRoutes.CONFIGURATION_OVERSEERR;
      case LunaModule.RADARR:
        return SettingsRoutes.CONFIGURATION_RADARR;
      case LunaModule.SABNZBD:
        return SettingsRoutes.CONFIGURATION_SABNZBD;
      case LunaModule.SEARCH:
        return SettingsRoutes.CONFIGURATION_SEARCH;
      case LunaModule.SETTINGS:
        return null;
      case LunaModule.SONARR:
        return SettingsRoutes.CONFIGURATION_SONARR;
      case LunaModule.TAUTULLI:
        return SettingsRoutes.CONFIGURATION_TAUTULLI;
      case LunaModule.WAKE_ON_LAN:
        return SettingsRoutes.CONFIGURATION_WAKE_ON_LAN;
      case LunaModule.EXTERNAL_MODULES:
        return SettingsRoutes.CONFIGURATION_EXTERNAL_MODULES;
    }
  }

  Future<void> launch() async {
    if (homeRoute != null) {
      LunaRouter.router.replace(homeRoute!);
    }
  }
}

extension LunaModuleWebhookExtension on LunaModule {
  bool get hasWebhooks {
    switch (this) {
      case LunaModule.LIDARR:
        return true;
      case LunaModule.RADARR:
        return true;
      case LunaModule.SONARR:
        return true;
      case LunaModule.OVERSEERR:
        return true;
      case LunaModule.TAUTULLI:
        return true;
      default:
        return false;
    }
  }

  Future<void> handleWebhook(Map<String, dynamic> data) async {
    switch (this) {
      case LunaModule.LIDARR:
        return LidarrWebhooks().handle(data);
      case LunaModule.RADARR:
        return RadarrWebhooks().handle(data);
      case LunaModule.SONARR:
        return SonarrWebhooks().handle(data);
      case LunaModule.OVERSEERR:
        return OverseerrWebhooks().handle(data);
      case LunaModule.TAUTULLI:
        return TautulliWebhooks().handle(data);
      default:
        return;
    }
  }
}

extension LunaModuleExtension on LunaModule {
  ShortcutItem get shortcutItem {
    if (this == LunaModule.WAKE_ON_LAN) {
      throw Exception('WAKE_ON_LAN does not have a shortcut item');
    }
    return ShortcutItem(type: key, localizedTitle: title);
  }

  LunaModuleState? state(BuildContext context) {
    switch (this) {
      case LunaModule.WAKE_ON_LAN:
        return null;
      case LunaModule.DASHBOARD:
        return context.read<dashboard_state.ModuleState>();
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
      case LunaModule.EXTERNAL_MODULES:
        return null;
    }
  }

  Widget informationBanner() {
    String key = 'LUNASEA_MODULE_INFORMATION_${this.key}';
    void markSeen() => LunaBox.alerts.update(key, false);

    return LunaBox.alerts.listenableBuilder(
      selectKeys: [key],
      builder: (context, _) {
        if (LunaBox.alerts.read(key, fallback: true)) {
          return LunaBanner(
            dismissCallback: markSeen,
            headerText: this.title,
            bodyText: this.information,
            icon: this.icon,
            iconColor: this.color,
            buttons: [
              if (this.github != null)
                LunaButton.text(
                  text: 'GitHub',
                  icon: LunaIcons.GITHUB,
                  onTap: this.github!.openLink,
                ),
              if (this.website != null)
                LunaButton.text(
                  text: 'lunasea.Website'.tr(),
                  icon: Icons.home_rounded,
                  onTap: this.website!.openLink,
                ),
            ],
          );
        }
        return const SizedBox(height: 0.0, width: double.infinity);
      },
    );
  }
}
