import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesDetailsRouter extends LunaPageRouter {
    RadarrMoviesDetailsRouter() : super('/radarr/movie/:movieid');

    @override
    Future<void> navigateTo(BuildContext context, { @required int movieId }) async => LunaRouter.router.navigateTo(context, route(movieId: movieId));

    @override
    String route({ @required int movieId }) => fullRoute.replaceFirst(':movieid', movieId.toString());

    @override
    void defineRoute(FluroRouter router) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) {
            int movieid = params['movieid'] == null || params['movieid'].length == 0 ? -1 : (int.tryParse(params['movieid'][0]) ?? -1); 
            return _RadarrMoviesDetailsRoute(movieId: movieid);
        }),
        transitionType: LunaRouter.transitionType,
    );
}

class _RadarrMoviesDetailsRoute extends StatefulWidget {
    final int movieId;

    _RadarrMoviesDetailsRoute({
        Key key,
        @required this.movieId,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_RadarrMoviesDetailsRoute> with LunaLoadCallbackMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    RadarrMovie movie;
    PageController _pageController;

    @override
    Future<void> loadCallback() async {
        if(widget.movieId > 0) {
            _findMovie(await context.read<RadarrState>().movies);
            context.read<RadarrState>().fetchQualityProfiles();
            context.read<RadarrState>().fetchTags();
            await context.read<RadarrState>().resetSingleMovie(widget.movieId);
            _findMovie(await context.read<RadarrState>().movies);
        }
    }

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS.data);
    }

    void _findMovie(List<RadarrMovie> movies) {
        RadarrMovie _movie = movies.firstWhere(
            (movie) => movie.id == widget.movieId,
            orElse: () => null,
        );
        if(mounted) setState(() => movie = _movie);
    }

    List<RadarrTag> _findTags(List<int> tagIds, List<RadarrTag> tags) {
        return tags.where((tag) => tagIds.contains(tag.id)).toList();
    }

    RadarrQualityProfile _findQualityProfile(int profileId, List<RadarrQualityProfile> profiles) {
        return profiles.firstWhere(
            (profile) => profile.id == profileId,
            orElse: () => null,
        );
    }

    @override
    Widget build(BuildContext context) {
        if(widget.movieId <= 0) return LunaInvalidRoute(title: 'Movie Details', message: 'Movie Not Found');
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            bottomNavigationBar: _bottomNavigationBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        List<Widget> _actions = movie == null ? null : [RadarrAppBarMovieSettingsAction(movieId: widget.movieId)];
        return LunaAppBar(
            pageController: _pageController,
            scrollControllers: RadarrMovieDetailsNavigationBar.scrollControllers,
            title: 'Movie Details',
            actions: _actions,
        );
    }

    Widget _bottomNavigationBar() {
        if(movie == null) return null;
        return RadarrMovieDetailsNavigationBar(pageController: _pageController);
    }

    Widget _body() {
        return Consumer<RadarrState>(
            builder: (context, state, _) => FutureBuilder(
                future: Future.wait([state.qualityProfiles, state.tags]),
                builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) LunaLogger().error(
                            'Unable to pull Radarr movie details',
                            snapshot.error,
                            snapshot.stackTrace,
                        );
                        return LunaMessage.error(onTap: loadCallback);
                    }
                    if(snapshot.hasData) {
                        if(movie == null) return LunaLoader();
                        RadarrQualityProfile qualityProfile = _findQualityProfile(movie.qualityProfileId, snapshot.data[0]);
                        List<RadarrTag> tags = _findTags(movie.tags, snapshot.data[1]);
                        return _pages(qualityProfile, tags);
                    }
                    return LunaLoader();
                },
            ),
        );
    }

    Widget _pages(RadarrQualityProfile qualityProfile, List<RadarrTag> tags) {
        return ChangeNotifierProvider(
            create: (context) => RadarrMovieDetailsState(context: context, movie: movie),
            builder: (context, _) => PageView(
                controller: _pageController,
                children: [
                    RadarrMovieDetailsOverviewPage(movie: movie, qualityProfile: qualityProfile, tags: tags),
                    RadarrMovieDetailsFilesPage(),
                    RadarrMovieDetailsHistoryPage(movie: movie),
                    RadarrMovieDetailsCastCrewPage(movie: movie),
                ],
            ),
        );
    }
}
