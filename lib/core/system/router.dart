import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';

class LunaRouter {
    static FluroRouter router = FluroRouter();
    static TransitionType get transitionType => TransitionType.native;

    /// Calls `defineAllRoutes()` on all module routers that implement [LunaModuleRouter].
    void intialize() {
        router.notFoundHandler = Handler(handlerFunc: (context, params) => LunaInvalidRoute());
        RadarrRouter().defineAllRoutes(router);
        SearchRouter().defineAllRoutes(router);
        SettingsRouter().defineAllRoutes(router);
        SonarrRouter().defineAllRoutes(router);
        TautulliRouter().defineAllRoutes(router);
    }

    /// **Will be removed when all module routers are integrated.**
    /// 
    /// Returns a map of all module routes.
    Map<String, WidgetBuilder> get routes => <String, WidgetBuilder> {
        Dashboard.ROUTE_NAME: (context) => Dashboard(),
        ..._search,
        ..._lidarr,
        ..._sabnzbd,
        ..._nzbget,
    };

    Map<String, WidgetBuilder> get _search => <String, WidgetBuilder> {
        //  /search/*
        SearchSearch.ROUTE_NAME: (context) => SearchSearch(),
        SearchResults.ROUTE_NAME: (context) => SearchResults(),
    };

    Map<String, WidgetBuilder> get _lidarr => <String, WidgetBuilder> {
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

    Map<String, WidgetBuilder> get _nzbget => <String, WidgetBuilder> {
        NZBGet.ROUTE_NAME: (context) => NZBGet(),
        NZBGetStatistics.ROUTE_NAME: (context) => NZBGetStatistics(),
    };

    Map<String, WidgetBuilder> get _sabnzbd => <String, WidgetBuilder> {
        SABnzbd.ROUTE_NAME: (context) => SABnzbd(),
        SABnzbdStatistics.ROUTE_NAME: (context) => SABnzbdStatistics(),
        SABnzbdHistoryStages.ROUTE_NAME: (context) => SABnzbdHistoryStages(),
    };
}
