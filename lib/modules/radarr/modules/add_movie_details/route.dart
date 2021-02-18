import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class _RadarrAddMovieDetailsArguments {
    final RadarrMovie movie;
    final bool isDiscovery;

    _RadarrAddMovieDetailsArguments({
        @required this.movie,
        @required this.isDiscovery,
    }) {
        assert(movie != null);
        assert(isDiscovery != null);
    }
}

class RadarrAddMovieDetailsRouter extends LunaPageRouter {
    RadarrAddMovieDetailsRouter() : super('/radarr/addmovie/details');

    @override
    Future<void> navigateTo(BuildContext context, {
        @required RadarrMovie movie,
        @required bool isDiscovery,
    }) => LunaRouter.router.navigateTo(
        context,
        route(),
        routeSettings: RouteSettings(arguments: _RadarrAddMovieDetailsArguments(movie: movie, isDiscovery: isDiscovery)),
    );
    
    @override
    void defineRoute(FluroRouter router) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) => _RadarrMoviesAddDetailsRoute()),
        transitionType: LunaRouter.transitionType,
    );
    
}

class _RadarrMoviesAddDetailsRoute extends StatefulWidget {
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
        _RadarrAddMovieDetailsArguments arguments = ModalRoute.of(context).settings.arguments;
        if(arguments == null || arguments.movie == null) return LunaInvalidRoute(
            title: 'Add Movie',
            message: 'Movie Not Found',
        );
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
                context.watch<RadarrState>().rootFolders,
                context.watch<RadarrState>().qualityProfiles,
                context.watch<RadarrState>().tags,
            ]),
            builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                if(snapshot.hasError) return LunaMessage.error(onTap: _refreshKey.currentState.show);
                if(snapshot.hasData) {
                    return _content(snapshot.data[0], snapshot.data[1], snapshot.data[2]);
                }
                return LunaLoader();
            },
        );
    }

    Widget _content(List<RadarrRootFolder> rootFolders, List<RadarrQualityProfile> qualityProfiles, List<RadarrTag> tags) {
        _RadarrAddMovieDetailsArguments arguments = ModalRoute.of(context).settings.arguments;
        return ChangeNotifierProvider(
            create: (_) => RadarrAddMovieDetailsState(
                movie: arguments.movie,
                isDiscovery: arguments.isDiscovery,
                rootFolders: rootFolders,
                qualityProfiles: qualityProfiles,
                tags: tags,
            ),
            builder: (context, _) => LunaListView(
                children: [
                    RadarrAddMovieSearchResultTile(
                        movie: context.read<RadarrAddMovieDetailsState>().movie,
                        onTapShowOverview: true,
                        exists: false,
                        isExcluded: false,
                    ),
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
