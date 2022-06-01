import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

class OverseerrRouter extends LunaModuleRouter {
  @override
  void defineAllRoutes(FluroRouter router) {
    OverseerrHomeRouter().defineRoute(router);
  }

  @override
  GoRoute getRoutes() {
    return GoRoute(path: '/overseerr');
  }
}

abstract class OverseerrPageRouter extends LunaPageRouter {
  OverseerrPageRouter(String route) : super(route);

  @override
  void noParameterRouteDefinition(
    FluroRouter router, {
    bool homeRoute = false,
  }) {
    router.define(
      fullRoute,
      handler: Handler(
        handlerFunc: (context, params) {
          if (!homeRoute && !context!.read<OverseerrState>().enabled) {
            return LunaNotEnabledRoute(module: LunaModule.OVERSEERR.title);
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
          if (!homeRoute && !context!.read<OverseerrState>().enabled) {
            return LunaNotEnabledRoute(module: LunaModule.OVERSEERR.title);
          }
          return handlerFunc(context, params);
        },
      ),
      transitionType: LunaRouter.transitionType,
    );
  }
}
