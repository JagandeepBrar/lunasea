import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/settings/modules/donations_thankyou/route.dart';

class SettingsConstants {
    SettingsConstants._();

    static const String MODULE_KEY = 'settings';

    static const ModuleMap MODULE_MAP = ModuleMap(
        name: 'Settings',
        description: 'Update Configuration',
        settingsDescription: '',
        icon: CustomIcons.settings,
        route: '/settings',
        color: Color(Constants.ACCENT_COLOR),
    );

    // ignore: non_constant_identifier_names
    static final Map<String, WidgetBuilder> MODULE_ROUTES = <String, WidgetBuilder>{
        SettingsRoute.ROUTE_NAME: (context) => SettingsRoute(),
        // Customization
        SettingsCustomizationRoute.ROUTE_NAME: (context) => SettingsCustomizationRoute(),
        SettingsCustomizationAppearanceRoute.ROUTE_NAME: (context) => SettingsCustomizationAppearanceRoute(),
        SettingsCustomizationCalendarRoute.ROUTE_NAME: (context) => SettingsCustomizationCalendarRoute(),
        SettingsCustomizationDrawerRoute.ROUTE_NAME: (context) => SettingsCustomizationDrawerRoute(),
        SettingsCustomizationHomeRoute.ROUTE_NAME: (context) => SettingsCustomizationHomeRoute(),
        SettingsCustomizationLidarrRoute.ROUTE_NAME: (context) => SettingsCustomizationLidarrRoute(),
        SettingsCustomizationNZBGetRoute.ROUTE_NAME: (context) => SettingsCustomizationNZBGetRoute(),
        SettingsCustomizationQuickActionsRoute.ROUTE_NAME: (context) => SettingsCustomizationQuickActionsRoute(),
        SettingsCustomizationRadarrRoute.ROUTE_NAME: (context) => SettingsCustomizationRadarrRoute(),
        SettingsCustomizationSABnzbdRoute.ROUTE_NAME: (context) => SettingsCustomizationSABnzbdRoute(),
        SettingsCustomizationSearchRoute.ROUTE_NAME: (context) => SettingsCustomizationSearchRoute(),
        SettingsCustomizationSonarrRoute.ROUTE_NAME: (context) => SettingsCustomizationSonarrRoute(),
        SettingsCustomizationTautulliRoute.ROUTE_NAME: (context) => SettingsCustomizationTautulliRoute(),
        // Modules
        SettingsModulesRoute.ROUTE_NAME: (context) => SettingsModulesRoute(),
        SettingsModulesLidarrRoute.ROUTE_NAME: (context) => SettingsModulesLidarrRoute(),
        SettingsModulesNZBGetRoute.ROUTE_NAME: (context) => SettingsModulesNZBGetRoute(),
        SettingsModulesRadarrRoute.ROUTE_NAME: (context) => SettingsModulesRadarrRoute(),
        SettingsModulesSABnzbdRoute.ROUTE_NAME: (context) => SettingsModulesSABnzbdRoute(),
        SettingsModulesSearchRoute.ROUTE_NAME: (context) => SettingsModulesSearchRoute(),
        SettingsModulesSearchAddRoute.ROUTE_NAME: (context) => SettingsModulesSearchAddRoute(),
        SettingsModulesSearchEditRoute.ROUTE_NAME: (context) => SettingsModulesSearchEditRoute(),
        SettingsModulesSonarrRoute.ROUTE_NAME: (context) => SettingsModulesSonarrRoute(),
        SettingsModulesTautulliRoute.ROUTE_NAME: (context) => SettingsModulesTautulliRoute(),
        SettingsModulesWakeOnLANRoute.ROUTE_NAME: (context) => SettingsModulesWakeOnLANRoute(),
        // Profiles
        SettingsProfilesRoute.ROUTE_NAME: (context) => SettingsProfilesRoute(),
        // Backup & Restore
        SettingsBackupRestoreRoute.ROUTE_NAME: (context) => SettingsBackupRestoreRoute(),
        // Donations
        SettingsDonationsRoute.ROUTE_NAME: (context) => SettingsDonationsRoute(),
        SettingsDonationsThankYouRoute.ROUTE_NAME: (context) => SettingsDonationsThankYouRoute(),
        // Logs
        SettingsLogsRoute.ROUTE_NAME: (context) => SettingsLogsRoute(),
        SettingsLogsDetailsRoute.ROUTE_NAME: (context) => SettingsLogsDetailsRoute(),
        // Resources
        SettingsResourcesRoute.ROUTE_NAME: (context) => SettingsResourcesRoute(),
        // System
        SettingsSystemRoute.ROUTE_NAME: (context) => SettingsSystemRoute(),
    };
}
