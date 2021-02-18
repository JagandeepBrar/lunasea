import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsRouter extends LunaModuleRouter {
    @override
    void defineAllRoutes(FluroRouter router) {
        SettingsHomeRouter().defineRoute(router);
        // Account
        SettingsAccountRouter().defineRoute(router);
        SettingsAccountPasswordResetRouter().defineRoute(router);
        // Configuration
        SettingsConfigurationRouter().defineRoute(router);
        SettingsConfigurationAppearanceRouter().defineRoute(router);
        SettingsConfigurationQuickActionsRouter().defineRoute(router);
        SettingsConfigurationHomeRouter().defineRoute(router);
        // Configuration/Lidarr
        SettingsConfigurationLidarrRouter().defineRoute(router);
        SettingsConfigurationLidarrConnectionDetailsRouter().defineRoute(router);
        SettingsConfigurationLidarrDefaultPagesRouter().defineRoute(router);
        SettingsConfigurationLidarrHeadersRouter().defineRoute(router);
        // Configuration/NZBGet
        SettingsConfigurationNZBGetRouter().defineRoute(router);
        SettingsConfigurationNZBGetConnectionDetailsRouter().defineRoute(router);
        SettingsConfigurationNZBGetDefaultPagesRouter().defineRoute(router);
        SettingsConfigurationNZBGetHeadersRouter().defineRoute(router);
        // Configuration/Radarr
        SettingsConfigurationRadarrRouter().defineRoute(router);
        SettingsConfigurationRadarrConnectionDetailsRouter().defineRoute(router);
        SettingsConfigurationRadarrDefaultPagesRouter().defineRoute(router);
        SettingsConfigurationRadarrDefaultSortingRouter().defineRoute(router);
        SettingsConfigurationRadarrHeadersRouter().defineRoute(router);
        // Configuration/SABnzbd
        SettingsConfigurationSABnzbdRouter().defineRoute(router);
        SettingsConfigurationSABnzbdConnectionDetailsRouter().defineRoute(router);
        SettingsConfigurationSABnzbdDefaultPagesRouter().defineRoute(router);
        SettingsConfigurationSABnzbdHeadersRouter().defineRoute(router);
        // Configuration/Search
        SettingsConfigurationSearchRouter().defineRoute(router);
        SettingsConfigurationSearchAddRouter().defineRoute(router);
        SettingsConfigurationSearchEditRouter().defineRoute(router);
        // Configuration/Sonarr
        SettingsConfigurationSonarrRouter().defineRoute(router);
        SettingsConfigurationSonarrConnectionDetailsRouter().defineRoute(router);
        SettingsConfigurationSonarrDefaultPagesRouter().defineRoute(router);
        SettingsConfigurationSonarrDefaultSortingRouter().defineRoute(router);
        SettingsConfigurationSonarrHeadersRouter().defineRoute(router);
        // Configuration/Tautulli
        SettingsConfigurationTautulliRouter().defineRoute(router);
        SettingsConfigurationTautulliConnectionDetailsRouter().defineRoute(router);
        SettingsConfigurationTautulliDefaultPagesRouter().defineRoute(router);
        SettingsConfigurationTautulliHeadersRouter().defineRoute(router);
        // Configuration/Wake-on-LAN
        SettingsConfigurationWakeOnLANRouter().defineRoute(router);
        // Other
        SettingsProfilesRouter().defineRoute(router);
        SettingsDonationsRouter().defineRoute(router);
        SettingsDonationsThankYouRouter().defineRoute(router);
        SettingsResourcesRouter().defineRoute(router);
        SettingsSystemRouter().defineRoute(router);
        SettingsSystemLogsRouter().defineRoute(router);
        SettingsSystemLogsDetailsRouter().defineRoute(router);
    }
}
