import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/widgets/pages/not_enabled.dart';

class SonarrRouter extends LunaModuleRouter {
  @override
  void defineAllRoutes(FluroRouter router) {
    SonarrHomeRouter().defineRoute(router);
    // Series
    SonarrAddSeriesRouter().defineRoute(router);
    SonarrAddSeriesDetailsRouter().defineRoute(router);
    SonarrEditSeriesRouter().defineRoute(router);
    SonarrSeriesDetailsRouter().defineRoute(router);
    SonarrSeasonDetailsRouter().defineRoute(router);
    // Other
    SonarrHistoryRouter().defineRoute(router);
    SonarrQueueRouter().defineRoute(router);
    SonarrReleasesRouter().defineRoute(router);
    SonarrTagsRouter().defineRoute(router);
  }

  @override
  GoRoute getRoutes() {
    return GoRoute(path: '/sonarr');
  }
}

abstract class SonarrPageRouter extends LunaPageRouter {
  SonarrPageRouter(String route) : super(route);

  @override
  void noParameterRouteDefinition(
    FluroRouter router, {
    bool homeRoute = false,
  }) {
    router.define(
      fullRoute,
      handler: Handler(
        handlerFunc: (context, params) {
          if (!homeRoute && !context!.read<SonarrState>().enabled) {
            return NotEnabledPage(module: 'Sonarr');
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
    Widget Function(BuildContext?, Map<String, List<String>>) handlerFunc, {
    bool homeRoute = false,
  }) {
    router.define(
      fullRoute,
      handler: Handler(
        handlerFunc: (context, params) {
          if (!homeRoute && !context!.read<SonarrState>().enabled) {
            return NotEnabledPage(module: 'Sonarr');
          }
          return handlerFunc(context, params);
        },
      ),
      transitionType: LunaRouter.transitionType,
    );
  }
}
