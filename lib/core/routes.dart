import 'package:flutter/material.dart';
import 'package:lunasea/routes.dart';

class Routes {
    Routes._();

    static Map<String, WidgetBuilder> getRoutes() {
        return <String, WidgetBuilder> {
            '/': (BuildContext context) => Home(),
            '/settings': (BuildContext context) => Settings(),
            '/lidarr': (BuildContext context) => Lidarr(),
            '/radarr': (BuildContext context) => Radarr(),
            '/sonarr': (BuildContext context) => Sonarr(),
            '/nzbget': (BuildContext context) => NZBGet(),
            '/sabnzbd': (BuildContext context) => SABnzbd(),
        };
    }
}