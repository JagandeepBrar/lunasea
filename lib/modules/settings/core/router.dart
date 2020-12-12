import 'package:fluro/fluro.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsRouter {
    SettingsRouter._();

    static void initialize(FluroRouter router) {
        SettingsHomeRouter.defineRoutes(router);
        // Customization
        SettingsCustomizationRouter.defineRoutes(router);
        SettingsCustomizationAppearanceRouter.defineRoutes(router);
        SettingsCustomizationCalendarRouter.defineRoutes(router);
        SettingsCustomizationDrawerRouter.defineRoutes(router);
        SettingsCustomizationHomeRouter.defineRoutes(router);
        SettingsCustomizationLidarrRouter.defineRoutes(router);
        SettingsCustomizationNZBGetRouter.defineRoutes(router);
        SettingsCustomizationQuickActionsRouter.defineRoutes(router);
        SettingsCustomizationRadarrRouter.defineRoutes(router);
        SettingsCustomizationSABnzbdRouter.defineRoutes(router);
        SettingsCustomizationSearchRouter.defineRoutes(router);
        SettingsCustomizationSonarrRouter.defineRoutes(router);
        SettingsCustomizationTautulliRouter.defineRoutes(router);
        // Modules
        SettingsModulesRouter.defineRoutes(router);
        SettingsModulesWakeOnLANRouter.defineRoutes(router);
        SettingsModulesSearchRouter.defineRoutes(router);
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
        SettingsProfilesRouter.defineRoutes(router);
        SettingsBackupRestoreRouter().defineRoutes(router);
        SettingsDonationsRouter.defineRoutes(router);
        SettingsDonationsThankYouRouter.defineRoutes(router);
        SettingsResourcesRouter.defineRoutes(router);
        SettingsSystemRouter().defineRoutes(router);
        SettingsSystemLogsRouter().defineRoutes(router);
        SettingsSystemLogsDetailsRouter().defineRoutes(router);
    }
}
