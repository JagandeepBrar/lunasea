import 'package:fluro/fluro.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsRouter {
    SettingsRouter._();

    static void initialize(FluroRouter router) {
        SettingsHomeRouter().defineRoute(router);
        // Customization
        // SettingsCustomizationRouter.defineRoute(router);
        // SettingsCustomizationNZBGetRouter.defineRoute(router);
        // SettingsCustomizationSABnzbdRouter.defineRoute(router);
        // SettingsCustomizationSonarrRouter.defineRoute(router);
        // SettingsCustomizationTautulliRouter.defineRoute(router);
        // Configuration
        SettingsConfigurationRouter().defineRoute(router);
        SettingsConfigurationAppearanceRouter().defineRoute(router);
        SettingsConfigurationDrawerRouter().defineRoute(router);
        SettingsConfigurationHomeRouter().defineRoute(router);
        SettingsConfigurationLidarrRouter().defineRoute(router);
        SettingsConfigurationLidarrHeadersRouter().defineRoute(router);
        SettingsConfigurationQuickActionsRouter().defineRoute(router);
        SettingsConfigurationRadarrRouter().defineRoute(router);
        SettingsConfigurationRadarrHeadersRouter().defineRoute(router);
        SettingsConfigurationSearchRouter().defineRoute(router);
        SettingsConfigurationSonarrRouter().defineRoute(router);
        SettingsConfigurationSonarrHeadersRouter().defineRoute(router);
        SettingsConfigurationWakeOnLANRouter().defineRoute(router);
        // Modules
        // SettingsModulesSearchAddRouter.defineRoute(router);
        // SettingsModulesSearchEditRouter.defineRoute(router);
        // SettingsModulesNZBGetRouter.defineRoute(router);
        // SettingsModulesNZBGetHeadersRouter.defineRoute(router);
        // SettingsModulesSABnzbdRouter.defineRoute(router);
        // SettingsModulesSABnzbdHeadersRouter.defineRoute(router);
        // SettingsModulesTautulliRouter.defineRoute(router);
        // SettingsModulesTautulliHeadersRouter.defineRoute(router);
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
