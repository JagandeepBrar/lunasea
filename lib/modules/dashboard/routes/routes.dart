import 'package:flutter/material.dart';

import 'package:lunasea/deprecated/router/module_router.dart';
import 'package:lunasea/deprecated/router/page_router.dart';
import 'package:lunasea/deprecated/router/router.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/modules/dashboard/routes/dashboard/route.dart';

enum Routes {
  HOME,
}

extension RoutesExtension on Routes {
  String get path {
    switch (this) {
      case Routes.HOME:
        return '/dashboard';
    }
  }

  DashboardPageRouter get router {
    switch (this) {
      case Routes.HOME:
        return HomeRouter();
    }
  }
}

class Router extends LunaModuleRouter {
  @override
  void defineAllRoutes(FluroRouter router) {
    Routes.values.forEach((r) => r.router.defineRoute(router));
  }

  @override
  GoRoute getRoutes() {
    return GoRoute(
      path: Routes.HOME.path,
      name: Routes.HOME.name,
      builder: (context, state) => const Home(),
    );
  }
}

abstract class DashboardPageRouter extends LunaPageRouter {
  DashboardPageRouter(String route) : super(route);

  @override
  void noParameterRouteDefinition(
    FluroRouter router, {
    bool homeRoute = false,
  }) {
    router.define(
      fullRoute,
      handler: Handler(handlerFunc: (context, params) => widget()),
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
