import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';

class DashboardRouter extends LunaModuleRouter {
    @override
    void defineAllRoutes(FluroRouter router) {
        DashboardHomeRouter().defineRoute(router);
    }
}

abstract class DashboardPageRouter extends LunaPageRouter {
    DashboardPageRouter(String route) : super(route);

    @override
    void noParameterRouteDefinition(FluroRouter router, Widget widget, { bool homeRoute = false }) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) => widget),
        transitionType: LunaRouter.transitionType,
    );

    @override
    void withParameterRouteDefinition(
        FluroRouter router,
        Widget Function(BuildContext, Map<String, List<String>>) handlerFunc,
        { bool homeRoute = false }
    ) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) => handlerFunc(context, params)),
        transitionType: LunaRouter.transitionType,
    );
}
