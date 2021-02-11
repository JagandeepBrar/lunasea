import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

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

class _State extends State<_RadarrMoviesEditRoute> with LunaLoadCallbackMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Future<void> loadCallback() async {
        context.read<RadarrState>().fetchTags();
        context.read<RadarrState>().fetchQualityProfiles();
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(),
        body: _body(),
    );

    Widget _appBar() {
        return LunaAppBar(title: 'Edit Movie', scrollControllers: [context.read<RadarrState>().scrollController]);
    }

    Widget _body() {
        return FutureBuilder(
            future: Future.wait([
                context.watch<RadarrState>().movies,
                context.watch<RadarrState>().qualityProfiles,
                context.watch<RadarrState>().tags,
            ]),
            builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                if(snapshot.hasError) return LSErrorMessage(onTapHandler: () => loadCallback());
                if(snapshot.hasData) {
                    RadarrMovie movie = (snapshot.data[0] as List<RadarrMovie>).firstWhere(
                        (movie) => movie?.id == widget.movieId,
                        orElse: () => null,
                    );
                    if(movie == null) return _unknown();
                    return _editList(movie, snapshot.data[1], snapshot.data[2]);
                }
                return LunaLoader();
            },
        );
    }

    Widget _editList(RadarrMovie movie, List<RadarrQualityProfile> qualityProfiles, List<RadarrTag> tags) {
        return ChangeNotifierProvider(
            create: (_) => RadarrMoviesEditState(movie: movie, qualityProfiles: qualityProfiles, tags: tags),
            builder: (context, _) {
                if(context.watch<RadarrMoviesEditState>().state == LunaLoadingState.ERROR)
                    return LunaMessage(text: 'An Error Has Occurred');
                return LunaListView(
                    children: [
                        RadarrMoviesEditMonitoredTile(),
                        RadarrMoviesEditMinimumAvailabilityTile(),
                        RadarrMoviesEditQualityProfileTile(profiles: qualityProfiles),
                        RadarrMoviesEditPathTile(),
                        RadarrMoviesEditTagsTile(),
                        RadarrMoviesEditUpdateMovieButton(movie: movie),
                    ],
                );
            }
        );
    }

    Widget _unknown() => LSGenericMessage(text: 'Movie Not Found');
}
