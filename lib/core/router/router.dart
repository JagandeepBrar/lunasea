import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:lunasea/modules/home/routes.dart';
import 'package:lunasea/modules/search/routes.dart';
import 'package:lunasea/modules/lidarr/routes.dart';
import 'package:lunasea/modules/nzbget/routes.dart';
import 'package:lunasea/modules/sabnzbd/routes.dart';
import 'package:lunasea/modules.dart' show OmbiRouter, SettingsRouter, RadarrRouter, SonarrRouter, TautulliRouter;

class LunaRouter {
    static FluroRouter router = FluroRouter();
    static TransitionType get transitionType => TransitionType.native;

    /// Calls `defineAllRoutes()` on all module routers that implement [LunaModuleRouter].
    static void intialize() {
        SettingsRouter().defineAllRoutes(router);
        RadarrRouter().defineAllRoutes(router);
        SonarrRouter().defineAllRoutes(router);
        OmbiRouter().defineAllRoutes(router);
        TautulliRouter().defineAllRoutes(router);
    }

    /// **Will be removed when all module routers are integrated.**
    /// 
    /// Returns a map of all module routes.
    static Map<String, WidgetBuilder> get routes => <String, WidgetBuilder> {
        Home.ROUTE_NAME: (context) => Home(),
        ..._search,
        ..._lidarr,
        ..._sabnzbd,
        ..._nzbget,
    };

    static Map<String, WidgetBuilder> get _search => <String, WidgetBuilder> {
        //  /search
        Search.ROUTE_NAME: (context) => Search(),
        //  /search/*
        SearchSearch.ROUTE_NAME: (context) => SearchSearch(),
        SearchCategories.ROUTE_NAME: (context) => SearchCategories(),
        SearchSubcategories.ROUTE_NAME: (context) => SearchSubcategories(),
        SearchResults.ROUTE_NAME: (context) => SearchResults(),
    };

    static Map<String, WidgetBuilder> get _lidarr => <String, WidgetBuilder> {
        //  /lidarr
        Lidarr.ROUTE_NAME: (context) => Lidarr(),
        //  /lidarr/add/*
        LidarrAddSearch.ROUTE_NAME: (context) => LidarrAddSearch(),
        LidarrAddDetails.ROUTE_NAME: (context) => LidarrAddDetails(),
        //  /lidarr/edit/*
        LidarrEditArtist.ROUTE_NAME: (context) => LidarrEditArtist(),
        //  /lidarr/details/*
        LidarrDetailsAlbum.ROUTE_NAME: (context) => LidarrDetailsAlbum(),
        LidarrDetailsArtist.ROUTE_NAME: (context) => LidarrDetailsArtist(),
        //  /lidarr/search/*
        LidarrSearchResults.ROUTE_NAME: (context) => LidarrSearchResults(),
    };

    static Map<String, WidgetBuilder> get _nzbget => <String, WidgetBuilder> {
        NZBGet.ROUTE_NAME: (context) => NZBGet(),
        NZBGetStatistics.ROUTE_NAME: (context) => NZBGetStatistics(),
    };

    static Map<String, WidgetBuilder> get _sabnzbd => <String, WidgetBuilder> {
        SABnzbd.ROUTE_NAME: (context) => SABnzbd(),
        SABnzbdStatistics.ROUTE_NAME: (context) => SABnzbdStatistics(),
        SABnzbdHistoryStages.ROUTE_NAME: (context) => SABnzbdHistoryStages(),
    };
}
