import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrRouter extends LunaModuleRouter {
  @override
  void defineAllRoutes(FluroRouter router) {
    RadarrAddMovieRouter().defineRoute(router);
    RadarrAddMovieDetailsRouter().defineRoute(router);
    RadarrHomeRouter().defineRoute(router);
    RadarrHistoryRouter().defineRoute(router);
    RadarrManualImportRouter().defineRoute(router);
    RadarrManualImportDetailsRouter().defineRoute(router);
    RadarrMoviesDetailsRouter().defineRoute(router);
    RadarrMoviesEditRouter().defineRoute(router);
    RadarrReleasesRouter().defineRoute(router);
    RadarrQueueRouter().defineRoute(router);
    RadarrSystemStatusRouter().defineRoute(router);
    RadarrTagsRouter().defineRoute(router);
  }
}

abstract class RadarrPageRouter extends LunaPageRouter {
  RadarrPageRouter(String route) : super(route);

  @override
  void noParameterRouteDefinition(
    FluroRouter router, {
    bool homeRoute = false,
  }) {
    router.define(
      fullRoute,
      handler: Handler(
        handlerFunc: (context, params) {
          if (!homeRoute && !context.read<RadarrState>().enabled) {
            return LunaNotEnabledRoute(module: 'Radarr');
          }
          return widget();
        },
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
        handlerFunc: (context, params) {
          if (!homeRoute && !context.read<RadarrState>().enabled) {
            return LunaNotEnabledRoute(module: 'Radarr');
          }
          return handlerFunc(context, params);
        },
      ),
      transitionType: LunaRouter.transitionType,
    );
  }
}
