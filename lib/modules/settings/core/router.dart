import 'package:fluro/fluro.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsRouter {
    SettingsRouter._();

    static void initialize(FluroRouter router) {
        SettingsHomeRouter().defineRoutes(router);
        // Customization
        SettingsCustomizationRouter.defineRoutes(router);
        SettingsCustomizationHomeRouter.defineRoutes(router);
        SettingsCustomizationLidarrRouter.defineRoutes(router);
        SettingsCustomizationNZBGetRouter.defineRoutes(router);
        SettingsCustomizationRadarrRouter.defineRoutes(router);
        SettingsCustomizationSABnzbdRouter.defineRoutes(router);
        SettingsCustomizationSonarrRouter.defineRoutes(router);
        SettingsCustomizationTautulliRouter.defineRoutes(router);
        // Configuration
        SettingsConfigurationRouter().defineRoutes(router);
        SettingsConfigurationAppearanceRouter().defineRoutes(router);
        SettingsConfigurationCalendarRouter().defineRoutes(router);
        SettingsConfigurationDrawerRouter().defineRoutes(router);
        SettingsConfigurationQuickActionsRouter().defineRoutes(router);
        SettingsConfigurationSearchRouter().defineRoutes(router);
        // Modules
        SettingsModulesWakeOnLANRouter.defineRoutes(router);
        SettingsModulesSearchAddRouter.defineRoutes(router);
        SettingsModulesSearchEditRouter.defineRoutes(router);
        SettingsModulesLidarrRouter.defineRoutes(router);
        SettingsModulesLidarrHeadersRouter.defineRoutes(router);
        SettingsModulesRadarrRouter.defineRoutes(router);
        SettingsModulesRadarrHeadersRouter.defineRoutes(router);
        SettingsModulesSonarrRouter.defineRoutes(router);
        SettingsModulesSonarrHeadersRouter.defineRoutes(router);
        SettingsModulesNZBGetRouter.defineRoutes(router);
        SettingsModulesNZBGetHeadersRouter.defineRoutes(router);
        SettingsModulesSABnzbdRouter.defineRoutes(router);
        SettingsModulesSABnzbdHeadersRouter.defineRoutes(router);
        SettingsModulesTautulliRouter.defineRoutes(router);
        SettingsModulesTautulliHeadersRouter.defineRoutes(router);
        // Other
        SettingsProfilesRouter().defineRoutes(router);
        SettingsBackupRestoreRouter().defineRoutes(router);
        SettingsDonationsRouter().defineRoutes(router);
        SettingsDonationsThankYouRouter().defineRoutes(router);
        SettingsResourcesRouter.defineRoutes(router);
        SettingsSystemRouter().defineRoutes(router);
        SettingsSystemLogsRouter().defineRoutes(router);
        SettingsSystemLogsDetailsRouter().defineRoutes(router);
    }
}
