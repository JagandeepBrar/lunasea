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

class _State extends State<_RadarrMoviesAddDetailsRoute> with LunaLoadCallbackMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    Future<void> loadCallback() async {
        context.read<RadarrState>().fetchQualityProfiles();
        context.read<RadarrState>().fetchRootFolders();
        context.read<RadarrState>().fetchTags();
    }

    @override
    Widget build(BuildContext context) {
        if(widget.tmdbId <= 0) return LunaInvalidRoute(title: 'Add Movie', message: 'Movie Not Found');
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(context),
        );
    }

    Widget _appBar() => LunaAppBar(title: 'Add Movie', state: context.read<RadarrState>());

    Widget _body(BuildContext context) {
        return FutureBuilder(
            future: Future.wait([
                context.watch<RadarrState>().lookup,
                context.watch<RadarrState>().rootFolders,
                context.watch<RadarrState>().qualityProfiles,
                context.watch<RadarrState>().tags,
            ]),
            builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                if(snapshot.hasError) return LunaMessage.error(onTap: _refreshKey.currentState.show);
                if(snapshot.hasData) {
                    RadarrMovie _movie = (snapshot.data[0] as List<RadarrMovie>)?.firstWhere((movie) => movie.tmdbId == widget.tmdbId, orElse: () => null);
                    if(_movie == null) return LunaLoader();
                    return _content(_movie, snapshot.data[1], snapshot.data[2], snapshot.data[3]);
                }
                return LunaLoader();
            },
        );
    }

    Widget _content(RadarrMovie movie, List<RadarrRootFolder> rootFolders, List<RadarrQualityProfile> qualityProfiles, List<RadarrTag> tags) {
        return ChangeNotifierProvider(
            create: (_) => RadarrAddMovieDetailsState(
                movie: movie,
                rootFolders: rootFolders,
                qualityProfiles: qualityProfiles,
                tags: tags,
            ),
            builder: (context, _) => LunaListView(
                scrollController: context.read<RadarrState>().scrollController,
                children: [
                    RadarrAddMovieSearchResultTile(movie: movie, onTapShowOverview: true, exists: false, isExcluded: false),
                    RadarrAddMovieDetailsMonitoredTile(),
                    RadarrAddMovieDetailsRootFolderTile(),
                    RadarrAddMovieDetailsMinimumAvailabilityTile(),
                    RadarrAddMovieDetailsQualityProfileTile(),
                    RadarrAddMovieDetailsTagsTile(),
                    LunaButtonContainer(
                        children: [
                            RadarrAddMovieDetailsAddButton(searchOnAdd: false),
                            RadarrAddMovieDetailsAddButton(searchOnAdd: true),
                        ],
                    ),
                ],
            ),
        );
    }
}
