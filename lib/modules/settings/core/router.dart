import 'package:fluro_fork/fluro_fork.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsRouter {
    static final Router router = Router();

    SettingsRouter._();

    static void initialize() {
        SettingsRoute.defineRoute(router);
        SettingsErrorRoute.defineRoute(router);
        // Customization
        SettingsCustomizationRoute.defineRoute(router);
        SettingsCustomizationAppearanceRoute.defineRoute(router);
        SettingsCustomizationDrawerRoute.defineRoute(router);
        SettingsCustomizationQuickActionsRoute.defineRoute(router);
        SettingsCustomizationCalendarRoute.defineRoute(router);
        SettingsCustomizationHomeRoute.defineRoute(router);
        SettingsCustomizationSearchRoute.defineRoute(router);
        SettingsCustomizationLidarrRoute.defineRoute(router);
        SettingsCustomizationRadarrRoute.defineRoute(router);
        SettingsCustomizationSonarrRoute.defineRoute(router);
        SettingsCustomizationNZBGetRoute.defineRoute(router);
        SettingsCustomizationSABnzbdRoute.defineRoute(router);
        SettingsCustomizationTautulliRoute.defineRoute(router);
        // Modules
        SettingsModulesRoute.defineRoute(router);
        SettingsModulesWakeOnLANRoute.defineRoute(router);
        SettingsModulesSearchRoute.defineRoute(router);
        SettingsModulesSearchAddRoute.defineRoute(router);
        SettingsModulesSearchEditRoute.defineRoute(router);
        SettingsModulesLidarrRoute.defineRoute(router);
        SettingsModulesLidarrHeadersRoute.defineRoute(router);
        SettingsModulesRadarrRoute.defineRoute(router);
        SettingsModulesRadarrHeadersRoute.defineRoute(router);
        SettingsModulesSonarrRoute.defineRoute(router);
        SettingsModulesSonarrHeadersRoute.defineRoute(router);
        SettingsModulesNZBGetRoute.defineRoute(router);
        SettingsModulesNZBGetHeadersRoute.defineRoute(router);
        SettingsModulesSABnzbdRoute.defineRoute(router);
        SettingsModulesSABnzbdHeadersRoute.defineRoute(router);
        SettingsModulesTautulliRoute.defineRoute(router);
        SettingsModulesTautulliHeadersRoute.defineRoute(router);
        // Profiles
        SettingsProfilesRoute.defineRoute(router);
        // ---
        // Backup & Restore
        SettingsBackupRestoreRoute.defineRoute(router);
        // Donations
        SettingsDonationsRoute.defineRoute(router);
        SettingsDonationsThankYouRoute.defineRoute(router);
        // Logs
        SettingsLogsRoute.defineRoute(router);
        SettingsLogsDetailsRoute.defineRoute(router);
        // Resources
        SettingsResourcesRoute.defineRoute(router);
        // System
        SettingsSystemRoute.defineRoute(router);
    }
}
