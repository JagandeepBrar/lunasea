import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchRouter extends LunaModuleRouter {
  @override
  void defineAllRoutes(FluroRouter router) {
    SearchHomeRouter().defineRoute(router);
    SearchCategoriesRouter().defineRoute(router);
    SearchSubcategoriesRouter().defineRoute(router);
    SearchResultsRouter().defineRoute(router);
    SearchSearchRouter().defineRoute(router);
  }
}

abstract class SearchPageRouter extends LunaPageRouter {
  SearchPageRouter(String route) : super(route);

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
    Widget Function(BuildContext, Map<String, List<String>>) handlerFunc, {
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
