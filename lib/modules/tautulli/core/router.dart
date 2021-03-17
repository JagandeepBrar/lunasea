import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliRouter extends LunaModuleRouter {
    @override
    void defineAllRoutes(FluroRouter router) {
        TautulliHomeRouter().defineRoute(router);
        // Details
        TautulliActivityDetailsRouter().defineRoute(router);
        TautulliIPAddressDetailsRouter.defineRoutes(router);
        TautulliLibrariesDetailsRouter.defineRoutes(router);
        TautulliHistoryDetailsRouter.defineRoutes(router);
        TautulliUserDetailsRouter.defineRoutes(router);
        TautulliMediaDetailsRouter.defineRoutes(router);
        // More/*
        TautulliCheckForUpdatesRouter().defineRoute(router);
        TautulliSearchRouter.defineRoutes(router);
        TautulliGraphsRouter.defineRoutes(router);
        TautulliLibrariesRouter.defineRoutes(router);
        TautulliSyncedItemsRouter.defineRoutes(router);
        TautulliStatisticsRouter.defineRoutes(router);
        TautulliRecentlyAddedRouter.defineRoutes(router);
        // Logs
        TautulliLogsRouter.defineRoutes(router);
        TautulliLogsLoginsRouter.defineRoutes(router);
        TautulliLogsNewslettersRouter.defineRoutes(router);
        TautulliLogsNotificationsRouter.defineRoutes(router);
        TautulliLogsPlexMediaScannerRouter.defineRoutes(router);
        TautulliLogsPlexMediaServerRouter.defineRoutes(router);
        TautulliLogsTautulliRouter.defineRoutes(router);
    }
}

abstract class TautulliPageRouter extends LunaPageRouter {
    TautulliPageRouter(String route) : super(route);

    @override
    void noParameterRouteDefinition(FluroRouter router, Widget widget, { bool homeRoute = false }) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) {
            if(!homeRoute && !context.read<TautulliState>().enabled) return LunaNotEnabledRoute(module: 'Tautulli');
            return widget;
        }),
        transitionType: LunaRouter.transitionType,
    );

    @override
    void withParameterRouteDefinition(
        FluroRouter router,
        Widget Function(BuildContext, Map<String, List<String>>) handlerFunc,
        { bool homeRoute = false }
    ) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) {
            if(!homeRoute && !context.read<TautulliState>().enabled) return LunaNotEnabledRoute(module: 'Tautulli');
            return handlerFunc(context, params);
        }),
        transitionType: LunaRouter.transitionType,
    );
}
