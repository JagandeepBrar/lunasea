import 'package:fluro/fluro.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsRouter {
    SettingsRouter._();

    static void initialize(FluroRouter router) {
        SettingsHomeRouter().defineRoute(router);
        // Configuration
        SettingsConfigurationRouter().defineRoute(router);
        SettingsConfigurationAppearanceRouter().defineRoute(router);
        SettingsConfigurationDrawerRouter().defineRoute(router);
        SettingsConfigurationHomeRouter().defineRoute(router);
        SettingsConfigurationLidarrRouter().defineRoute(router);
        SettingsConfigurationLidarrHeadersRouter().defineRoute(router);
        SettingsConfigurationNZBGetRouter().defineRoute(router);
        SettingsConfigurationNZBGetHeadersRouter().defineRoute(router);
        SettingsConfigurationQuickActionsRouter().defineRoute(router);
        SettingsConfigurationRadarrRouter().defineRoute(router);
        SettingsConfigurationRadarrHeadersRouter().defineRoute(router);
        SettingsConfigurationSABnzbdRouter().defineRoute(router);
        SettingsConfigurationSABnzbdHeadersRouter().defineRoute(router);
        SettingsConfigurationSearchRouter().defineRoute(router);
        SettingsConfigurationSearchAddRouter().defineRoute(router);
        SettingsConfigurationSearchEditRouter().defineRoute(router);
        SettingsConfigurationSonarrRouter().defineRoute(router);
        SettingsConfigurationSonarrHeadersRouter().defineRoute(router);
        SettingsConfigurationTautulliRouter().defineRoute(router);
        SettingsConfigurationTautulliHeadersRouter().defineRoute(router);
        SettingsConfigurationWakeOnLANRouter().defineRoute(router);
        // Modules
        // SettingsModulesSABnzbdRouter.defineRoute(router);
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
