import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsRouter extends LunaPageRouter {
    RadarrAddMovieDetailsRouter() : super('/radarr/addmovie/:tmdbid');

    @override
    Future<void> navigateTo(BuildContext context, { @required int tmdbId }) => LunaRouter.router.navigateTo(context, route(tmdbId: tmdbId));
    
    @override
    String route({ @required int tmdbId }) => fullRoute.replaceFirst(':tmdbid', tmdbId.toString());
    
    @override
    void defineRoute(FluroRouter router) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) {
            int tmdbId = params['tmdbid'] == null || params['tmdbid'].length == 0 ? -1 : (int.tryParse(params['tmdbid'][0]) ?? -1);
            return _RadarrMoviesAddDetailsRoute(tmdbId: tmdbId);
        }),
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
    Widget build(BuildContext context) {
        if(widget.tmdbId <= 0) return _unknown();
        return ChangeNotifierProvider(
            create: (_) => RadarrAddMovieDetailsState(),
            builder: (context, _) => Scaffold(
                key: _scaffoldKey,
                appBar: _appBar(),
                body: _body(context),
            ),
        );
    }

    Widget _appBar() {
        return LunaAppBar(title: 'Add Movie', state: context.read<RadarrState>());
    }

    Widget _body(BuildContext context) {
        return FutureBuilder(
            future: context.read<RadarrState>().lookup,
            builder: (context, AsyncSnapshot<List<RadarrMovie>> snapshot) {
                if(snapshot.hasError) return _unknown();
                if(snapshot.connectionState != ConnectionState.none && snapshot.hasData) {
                    RadarrMovie _movie = snapshot.data?.firstWhere((movie) => movie.tmdbId == widget.tmdbId, orElse: () => null);
                    if(_movie == null) return _unknown();
                    return _content(_movie);
                }
                return LSLoader();
            },
        );
    }

    Widget _content(RadarrMovie movie) {
        return LunaListView(
            scrollController: context.read<RadarrState>().scrollController,
            children: [
                RadarrAddMovieSearchResultTile(movie: movie, onTapShowOverview: true, exists: false, isExcluded: false),
            ],
        );
    }

    Widget _unknown() => LunaInvalidRoute(title: 'Add Movie', message: 'Movie Not Found');
}
