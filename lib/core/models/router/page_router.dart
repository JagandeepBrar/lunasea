import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

abstract class LunaPageRouter {    
    /// The full string representation of the route without the named parameters being swapped out
    final String fullRoute;

    /// Use [FluroRouter] to navigate to the page
    Future<void> navigateTo(BuildContext context) => LunaRouter.router.navigateTo(context, fullRoute);

    /// Get a string representation of the route with any named parameters inserted
    String route() => fullRoute;

    /// Used to define the route in the passed in router.
    /// 
    /// If the route requires no parameters, call [noParameterRouteDefinition] with the route as the [Widget] parameter.
    void defineRoute(FluroRouter router);

    /// Define the route in the passed in router without any parameters required.
    /// 
    /// Already has a definition that:
    /// - Calls [FluroRouter.define] with the [fullRoute]
    /// - Creates a basic [Handler]
    /// - Sets the transition type to [LunaRouter.transitionType]
    void noParameterRouteDefinition(FluroRouter router, Widget widget) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) => widget),
        transitionType: LunaRouter.transitionType,
    );

    LunaPageRouter(this.fullRoute);
}
