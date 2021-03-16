import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrRouter extends LunaModuleRouter {
    @override
    void defineAllRoutes(FluroRouter router) {
        SonarrHomeRouter().defineRoute(router);
        // Series
        SonarrSeriesAddRouter.defineRoutes(router);
        SonarrSeriesAddDetailsRouter.defineRoutes(router);
        SonarrSeriesEditRouter.defineRoutes(router);
        SonarrSeriesDetailsRouter().defineRoute(router);
        SonarrSeasonDetailsRouter().defineRoute(router);
        // Other
        SonarrQueueRouter().defineRoute(router);
        SonarrReleasesRouter.defineRoutes(router);
        SonarrTagsRouter().defineRoute(router);
    }
}

abstract class SonarrPageRouter extends LunaPageRouter {
    SonarrPageRouter(String route) : super(route);

    @override
    void noParameterRouteDefinition(FluroRouter router, Widget widget, { bool homeRoute = false }) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) {
            if(!homeRoute && !context.read<SonarrState>().enabled) return LunaNotEnabledRoute(module: 'Sonarr');
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
            if(!homeRoute && !context.read<SonarrState>().enabled) return LunaNotEnabledRoute(module: 'Sonarr');
            return handlerFunc(context, params);
        }),
        transitionType: LunaRouter.transitionType,
    );
}
