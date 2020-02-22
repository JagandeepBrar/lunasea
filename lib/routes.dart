import 'package:flutter/material.dart';
import 'package:lunasea/routes/settings/routes.dart';
//Cleanup below imports
import './routes/home/home.dart';
import './routes/settings/settings.dart';
import './routes/lidarr/lidarr.dart';
import './routes/nzbget/nzbget.dart';
import './routes/radarr/radarr.dart';
import './routes/sonarr/sonarr.dart';
import './routes/sabnzbd/sabnzbd.dart';

class Routes {
    Routes._();

    static Map<String, WidgetBuilder> getRoutes() {
        return <String, WidgetBuilder> {
            Home.ROUTE_NAME: (BuildContext context) => Home(),
            ..._settings,
            ..._lidarr,
            ..._radarr,
            ..._sonarr,
            ..._sabnzbd,
            ..._nzbget,
        };
    }

    static Map<String, WidgetBuilder> get _settings => <String, WidgetBuilder> {
        //  /settings
        Settings.ROUTE_NAME: (BuildContext context) => Settings(),
        //  /settings/indexers/*
        SettingsIndexersAdd.ROUTE_NAME: (BuildContext context) => SettingsIndexersAdd(),
        //  /settings/general/logs/*
        SettingsGeneralLogsTypes.ROUTE_NAME: (BuildContext context) => SettingsGeneralLogsTypes(),
    };

    static Map<String, WidgetBuilder> get _lidarr => <String, WidgetBuilder> {
        //  /lidarr
        '/lidarr': (BuildContext context) => Lidarr(),
    };

    static Map<String, WidgetBuilder> get _radarr => <String, WidgetBuilder> {
        //  /radarr
        '/radarr': (BuildContext context) => Radarr(),
    };

    static Map<String, WidgetBuilder> get _sonarr => <String, WidgetBuilder> {
        //  /sonarr
        '/sonarr': (BuildContext context) => Sonarr(),
    };

    static Map<String, WidgetBuilder> get _sabnzbd => <String, WidgetBuilder> {
        //  /sabnzbd
        '/sabnzbd': (BuildContext context) => SABnzbd(),
    };

    static Map<String, WidgetBuilder> get _nzbget => <String, WidgetBuilder> {
        //  /nzbget
        '/nzbget': (BuildContext context) => NZBGet(),
    };
}