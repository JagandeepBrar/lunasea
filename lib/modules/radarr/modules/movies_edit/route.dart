import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class RadarrMoviesEditRouter extends LunaPageRouter {
    RadarrMoviesEditRouter() : super('/radarr/movies/edit/:movieid');

    @override
    Future<void> navigateTo(BuildContext context, { @required int movieId }) async => LunaRouter.router.navigateTo(context, route(movieId: movieId));

    @override
    String route({ @required int movieId }) => fullRoute.replaceFirst(':movieid', movieId.toString());

    @override
    void defineRoute(FluroRouter router) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) => _RadarrMoviesEditRoute(movieId: int.tryParse(params['movieid'][0]) ?? -1)),
        transitionType: LunaRouter.transitionType,
    );
}

class _RadarrMoviesEditRoute extends StatefulWidget {
    final int movieId;

    _RadarrMoviesEditRoute({
        Key key,
        @required this.movieId,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_RadarrMoviesEditRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: LSLoader(),
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Edit Movie',
    );
}