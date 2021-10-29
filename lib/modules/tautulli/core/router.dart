import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliRouter extends LunaModuleRouter {
  @override
  void defineAllRoutes(FluroRouter router) {
    TautulliHomeRouter().defineRoute(router);
    // Details
    TautulliActivityDetailsRouter().defineRoute(router);
    TautulliIPAddressDetailsRouter().defineRoute(router);
    TautulliLibrariesDetailsRouter().defineRoute(router);
    TautulliHistoryDetailsRouter().defineRoute(router);
    TautulliUserDetailsRouter().defineRoute(router);
    TautulliMediaDetailsRouter().defineRoute(router);
    // More/*
    TautulliCheckForUpdatesRouter().defineRoute(router);
    TautulliSearchRouter().defineRoute(router);
    TautulliGraphsRouter().defineRoute(router);
    TautulliLibrariesRouter().defineRoute(router);
    TautulliSyncedItemsRouter().defineRoute(router);
    TautulliStatisticsRouter().defineRoute(router);
    TautulliRecentlyAddedRouter().defineRoute(router);
    // Logs
    TautulliLogsRouter().defineRoute(router);
    TautulliLogsLoginsRouter().defineRoute(router);
    TautulliLogsNewslettersRouter().defineRoute(router);
    TautulliLogsNotificationsRouter().defineRoute(router);
    TautulliLogsPlexMediaScannerRouter().defineRoute(router);
    TautulliLogsPlexMediaServerRouter().defineRoute(router);
    TautulliLogsTautulliRouter().defineRoute(router);
  }
}

abstract class TautulliPageRouter extends LunaPageRouter {
  TautulliPageRouter(String route) : super(route);

  @override
  void noParameterRouteDefinition(
    FluroRouter router, {
    bool homeRoute = false,
  }) =>
      router.define(
        fullRoute,
        handler: Handler(
          handlerFunc: (context, params) {
            if (!homeRoute && !context.read<TautulliState>().enabled) {
              return LunaNotEnabledRoute(module: 'Tautulli');
            }
            return widget();
          },
        ),
        transitionType: LunaRouter.transitionType,
      );

  @override
  void withParameterRouteDefinition(
    FluroRouter router,
    Widget Function(BuildContext, Map<String, List<String>>) handlerFunc, {
    bool homeRoute = false,
  }) =>
      router.define(
        fullRoute,
        handler: Handler(
          handlerFunc: (context, params) {
            if (!homeRoute && !context.read<TautulliState>().enabled) {
              return LunaNotEnabledRoute(module: 'Tautulli');
            }
            return handlerFunc(context, params);
          },
        ),
        transitionType: LunaRouter.transitionType,
      );
}
