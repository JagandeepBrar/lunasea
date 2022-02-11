import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrRouter extends LunaModuleRouter {
  @override
  void defineAllRoutes(FluroRouter router) {
    ReadarrHomeRouter().defineRoute(router);
    // Series
    ReadarrAddSeriesRouter().defineRoute(router);
    ReadarrAddSeriesDetailsRouter().defineRoute(router);
    ReadarrEditAuthorRouter().defineRoute(router);
    ReadarrAuthorDetailsRouter().defineRoute(router);
    ReadarrBookDetailsRouter().defineRoute(router);
    // Other
    ReadarrHistoryRouter().defineRoute(router);
    ReadarrQueueRouter().defineRoute(router);
    ReadarrReleasesRouter().defineRoute(router);
    ReadarrTagsRouter().defineRoute(router);
  }
}

abstract class ReadarrPageRouter extends LunaPageRouter {
  ReadarrPageRouter(String route) : super(route);

  @override
  void noParameterRouteDefinition(
    FluroRouter router, {
    bool homeRoute = false,
  }) {
    router.define(
      fullRoute,
      handler: Handler(
        handlerFunc: (context, params) {
          if (!homeRoute && !context!.read<ReadarrState>().enabled) {
            return LunaNotEnabledRoute(module: 'Readarr');
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
          if (!homeRoute && !context!.read<ReadarrState>().enabled) {
            return LunaNotEnabledRoute(module: 'Readarr');
          }
          return handlerFunc(context, params);
        },
      ),
      transitionType: LunaRouter.transitionType,
    );
  }
}
