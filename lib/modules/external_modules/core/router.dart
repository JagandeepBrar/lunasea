import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/external_modules.dart';

class ExternalModulesRouter extends LunaModuleRouter {
  @override
  void defineAllRoutes(FluroRouter router) {
    ExternalModulesHomeRouter().defineRoute(router);
  }

  @override
  GoRoute getRoutes() {
    return GoRoute(path: '/external_modules');
  }
}

abstract class ExternalModulesPageRouter extends LunaPageRouter {
  ExternalModulesPageRouter(String route) : super(route);

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
    Widget Function(BuildContext?, Map<String, List<String>>) handlerFunc, {
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
