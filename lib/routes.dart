import 'package:flutter/material.dart';
//Cleanup below imports
import 'package:lunasea/routes/home/routes.dart';
import 'package:lunasea/routes/settings/routes.dart';
import 'package:lunasea/routes/search/routes.dart';
import 'package:lunasea/routes/lidarr/routes.dart';
import './routes/nzbget/nzbget.dart';
import './routes/radarr/radarr.dart';
import './routes/sonarr/sonarr.dart';
import './routes/sabnzbd/sabnzbd.dart';

class Routes {
    Routes._();

    static Map<String, WidgetBuilder> getRoutes() {
        return <String, WidgetBuilder> {
            ..._home,
            ..._settings,
            ..._search,
            ..._lidarr,
            ..._radarr,
            ..._sonarr,
            ..._sabnzbd,
            ..._nzbget,
        };
    }

    static Map<String, WidgetBuilder> get _home => <String, WidgetBuilder> {
        //  /
        Home.ROUTE_NAME: (BuildContext context) => Home(),
        //  /home/*
        HomeCalendar.ROUTE_NAME: (BuildContext context) => HomeCalendar(refreshIndicatorKey: null),
        HomeQuickAccess.ROUTE_NAME: (BuildContext context) => HomeQuickAccess(),
    };

    static Map<String, WidgetBuilder> get _settings => <String, WidgetBuilder> {
        //  /settings
        Settings.ROUTE_NAME: (BuildContext context) => Settings(),
        //  /settings/*
        SettingsIndexers.ROUTE_NAME: (BuildContext context) => SettingsIndexers(),
        SettingsClients.ROUTE_NAME: (BuildContext context) => SettingsClients(),
        SettingsGeneral.ROUTE_NAME: (BuildContext context) => SettingsGeneral(),
        SettingsAutomation.ROUTE_NAME: (BuildContext context) => SettingsAutomation(),
        //  /settings/indexers/*
        SettingsIndexersAdd.ROUTE_NAME: (BuildContext context) => SettingsIndexersAdd(),
        SettingsIndexerEdit.ROUTE_NAME: (BuildContext context) => SettingsIndexerEdit(),
        //  /settings/general/logs/*
        SettingsGeneralLogsTypes.ROUTE_NAME: (BuildContext context) => SettingsGeneralLogsTypes(),
        SettingsGeneralLogsView.ROUTE_NAME: (BuildContext context) => SettingsGeneralLogsView(),
        SettingsGeneralLogsDetails.ROUTE_NAME: (BuildContext context) => SettingsGeneralLogsDetails(),
    };

    static Map<String, WidgetBuilder> get _search => <String, WidgetBuilder> {
        //  /search
        Search.ROUTE_NAME: (BuildContext context) => Search(),
        //  /search/*
        SearchSearch.ROUTE_NAME: (BuildContext context) => SearchSearch(),
        SearchCategories.ROUTE_NAME: (BuildContext context) => SearchCategories(),
        SearchSubcategories.ROUTE_NAME: (BuildContext context) => SearchSubcategories(),
        SearchResults.ROUTE_NAME: (BuildContext context) => SearchResults(),
        SearchDetails.ROUTE_NAME: (BuildContext context) => SearchDetails(),
    };

    static Map<String, WidgetBuilder> get _lidarr => <String, WidgetBuilder> {
        //  /lidarr
        Lidarr.ROUTE_NAME: (BuildContext context) => Lidarr(),
        //  /lidarr/*
        LidarrCatalogue.ROUTE_NAME: (BuildContext context) => LidarrCatalogue(refreshIndicatorKey: null),
        LidarrMissing.ROUTE_NAME: (BuildContext context) => LidarrMissing(refreshIndicatorKey: null),
        LidarrHistory.ROUTE_NAME: (BuildContext context) => LidarrHistory(refreshIndicatorKey: null),
        //  /lidarr/add/*
        LidarrAddSearch.ROUTE_NAME: (BuildContext context) => LidarrAddSearch(),
        LidarrAddDetails.ROUTE_NAME: (BuildContext context) => LidarrAddDetails(),
        //  /lidarr/edit/*
        LidarrEditArtist.ROUTE_NAME: (BuildContext context) => LidarrEditArtist(),
        //  /lidarr/details/*
        LidarrDetailsAlbum.ROUTE_NAME: (BuildContext context) => LidarrDetailsAlbum(),
        LidarrDetailsArtist.ROUTE_NAME: (BuildContext context) => LidarrDetailsArtist(),
        //  /lidarr/search/*
        LidarrSearchDetails.ROUTE_NAME: (BuildContext context) => LidarrSearchDetails(),
        LidarrSearchResults.ROUTE_NAME: (BuildContext context) => LidarrSearchResults(),
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