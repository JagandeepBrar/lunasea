import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class RadarrMoviesAddDetailsRouter extends LunaPageRouter {
    RadarrMoviesAddDetailsRouter() : super('/radarr/movies/add/details/:tmdbid');

    @override
    Future<void> navigateTo(BuildContext context, { @required int tmdbId }) => LunaRouter.router.navigateTo(context, route(tmdbId: tmdbId));
    
    @override
    String route({ @required int tmdbId }) => fullRoute.replaceFirst(':tmdbid', tmdbId.toString());
    
    @override
    void defineRoute(FluroRouter router) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) => _RadarrMoviesAddDetailsRoute(tmdbId: int.tryParse(params['tmdbid'][0]) ?? -1)),
        transitionType: LunaRouter.transitionType,
    );
}

class _RadarrMoviesAddDetailsRoute extends StatefulWidget {
    final int tmdbId;

    _RadarrMoviesAddDetailsRoute({
        Key key,
        @required this.tmdbId,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_RadarrMoviesAddDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _unknown,
    );

    Widget get _appBar => LunaAppBar(context: context, title: 'Add Movie');

    Widget get _unknown => LSGenericMessage(text:'Movie Not Found');
}