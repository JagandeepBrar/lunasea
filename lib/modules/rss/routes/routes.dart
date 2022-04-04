import 'package:flutter/material.dart';
import 'package:lunasea/modules/rss/routes/results/route.dart';

import '../../../core/router/module_router.dart';
import '../../../core/router/page_router.dart';
import '../../../core/router/router.dart';
import '../../../vendor.dart';
import 'feeds/route.dart';

enum Routes {
  HOME,
  RESULT
}

extension RoutesExtension on Routes {
  String get path {
    switch (this) {
      case Routes.HOME:
        return '/rss';
      case Routes.RESULT:
        return '/rss/result';
    }
  }

  RssPageRouter get router {
    switch (this) {
      case Routes.HOME:
        return RssHomeRouter();
      case Routes.RESULT:
        return RssResultRouter();
    }
  }
}

class RssRouter extends LunaModuleRouter {
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

abstract class RssPageRouter extends LunaPageRouter {
  RssPageRouter(String route) : super(route);

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
