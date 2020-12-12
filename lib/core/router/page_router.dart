import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

abstract class LunaPageRouter {
    /// Use [FluroRouter] to navigate to the page
    Future<void> navigateTo(BuildContext context);

    /// Get a string representation of the route
    /// 
    /// Use the parameters list to pull out the parameters
    String route(List parameters);

    /// Define the routes in the passed in router
    void defineRoutes(FluroRouter router);
}
