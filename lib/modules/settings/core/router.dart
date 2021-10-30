import 'package:flutter/material.dart';
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
    SettingsConfigurationDrawerRouter().defineRoute(router);
    SettingsConfigurationLocalizationRouter().defineRoute(router);
    SettingsConfigurationQuickActionsRouter().defineRoute(router);
    // Configuration/Dashboard
    SettingsConfigurationDashboardRouter().defineRoute(router);
    SettingsConfigurationDashboardCalendarSettingsRouter().defineRoute(router);
    // Configuration/External Modules
    SettingsConfigurationExternalModulesRouter().defineRoute(router);
    SettingsConfigurationExternalModulesAddRouter().defineRoute(router);
    SettingsConfigurationExternalModulesEditRouter().defineRoute(router);
    // Configuration/Lidarr
    SettingsConfigurationLidarrRouter().defineRoute(router);
    SettingsConfigurationLidarrConnectionDetailsRouter().defineRoute(router);
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
    SettingsConfigurationSearchAddHeadersRouter().defineRoute(router);
    SettingsConfigurationSearchEditRouter().defineRoute(router);
    SettingsConfigurationSearchEditHeadersRouter().defineRoute(router);
    // Configuration/Sonarr
    SettingsConfigurationSonarrRouter().defineRoute(router);
    SettingsConfigurationSonarrConnectionDetailsRouter().defineRoute(router);
    SettingsConfigurationSonarrDefaultPagesRouter().defineRoute(router);
    SettingsConfigurationSonarrDefaultSortingRouter().defineRoute(router);
    SettingsConfigurationSonarrHeadersRouter().defineRoute(router);
    // Configuration/Overseerr
    SettingsConfigurationOverseerrRouter().defineRoute(router);
    SettingsConfigurationOverseerrConnectionDetailsRouter().defineRoute(router);
    SettingsConfigurationOverseerrHeadersRouter().defineRoute(router);
    // Configuration/Tautulli
    SettingsConfigurationTautulliRouter().defineRoute(router);
    SettingsConfigurationTautulliConnectionDetailsRouter().defineRoute(router);
    SettingsConfigurationTautulliDefaultPagesRouter().defineRoute(router);
    SettingsConfigurationTautulliHeadersRouter().defineRoute(router);
    // Configuration/Wake-on-LAN
    SettingsConfigurationWakeOnLANRouter().defineRoute(router);
    // Other
    SettingsDebugMenuRouter().defineRoute(router);
    SettingsDonationsRouter().defineRoute(router);
    SettingsDonationsThankYouRouter().defineRoute(router);
    SettingsNotificationsRouter().defineRoute(router);
    SettingsProfilesRouter().defineRoute(router);
    SettingsResourcesRouter().defineRoute(router);
    SettingsSystemRouter().defineRoute(router);
    SettingsSystemLogsRouter().defineRoute(router);
    SettingsSystemLogsDetailsRouter().defineRoute(router);
  }
}

abstract class SettingsPageRouter extends LunaPageRouter {
  SettingsPageRouter(String route) : super(route);

  @override
  void noParameterRouteDefinition(
    FluroRouter router, {
    bool homeRoute = false,
  }) {
    router.define(
      fullRoute,
      handler: Handler(
        handlerFunc: (context, params) => widget(),
      ),
      transitionType: LunaRouter.transitionType,
    );
  }

  @override
  void withParameterRouteDefinition(
    FluroRouter router,
    Widget Function(BuildContext, Map<String, List<String>>) handlerFunc, {
    bool homeRoute = false,
  }) {
    router.define(
      fullRoute,
      handler: Handler(
        handlerFunc: (context, params) => handlerFunc(context, params),
      ),
      transitionType: LunaRouter.transitionType,
    );
  }
}
