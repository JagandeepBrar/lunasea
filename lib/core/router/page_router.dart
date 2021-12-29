import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

abstract class LunaPageRouter {
  /// The full string representation of the route without the named parameters being swapped out
  final String fullRoute;

  /// Use [FluroRouter] to navigate to the page
  Future<dynamic> navigateTo(BuildContext context) {
    return LunaRouter.router.navigateTo(context, fullRoute);
  }

  /// Get a string representation of the route with any named parameters inserted
  String route() => fullRoute;

  /// Used to define the route in the passed in router.
  ///
  /// If the route requires no parameters, call [noParameterRouteDefinition] with the route as the [Widget] parameter.
  void defineRoute(FluroRouter router);

  /// Return an instance of the actual route widget.
  Widget widget();

  /// Define the route in the passed in router without any parameters required.
  ///
  /// Already defines:
  /// - Calls [FluroRouter.define] with the [fullRoute]
  /// - Creates a basic [Handler]
  /// - Sets the transition type to [LunaRouter.transitionType]
  /// - Checks that the module is enabled, and if not returns a `[LunaNotEnabledRoute] instead of the intended route
  void noParameterRouteDefinition(
    FluroRouter router, {
    bool homeRoute = false,
  });

  /// Define the route in the passed in router with some parameters required.
  ///
  /// Already defines:
  /// - Calls [FluroRouter.define] with the [fullRoute]
  /// - Creates a basic [Handler]
  /// - Sets the transition type to [LunaRouter.transitionType]
  /// - Checks that the module is enabled, and if not returns a `[LunaNotEnabledRoute] instead of the intended route
  /// - Parses and injects the required parameters into the route for the handler
  void withParameterRouteDefinition(
    FluroRouter router,
    Widget Function(BuildContext?, Map<String, List<String>>) handlerFunc, {
    bool homeRoute = false,
  });

  LunaPageRouter(this.fullRoute);
}
