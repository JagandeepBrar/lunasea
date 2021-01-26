import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:tuple/tuple.dart';

class RadarrMoviesDetailsRouter extends LunaPageRouter {
    RadarrMoviesDetailsRouter() : super('/radarr/movies/details/:movieid');

    @override
    Future<void> navigateTo(BuildContext context, { @required int movieId }) async => LunaRouter.router.navigateTo(context, route(movieId: movieId));

    @override
    String route({ @required int movieId }) => fullRoute.replaceFirst(':movieid', movieId.toString());

    @override
    void defineRoute(FluroRouter router) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) => _RadarrMoviesDetailsRoute(movieId: int.tryParse(params['movieid'][0]) ?? -1)),
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

class _State extends State<_RadarrMoviesDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS.data);
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        RadarrState state = context.read<RadarrState>();
        RadarrMovie movie = await state.api.movie.get(movieId: widget.movieId);
        List<RadarrMovie> allMovies = await state.movies;
        int index = allMovies?.indexWhere((element) => element.id == widget.movieId) ?? -1;
        if(index >= 0) allMovies[index] = movie;
        state.notify();
        if(mounted) setState(() {});
    }

    RadarrMovie _findMovie(List<RadarrMovie> movies) => movies.firstWhere(
        (movie) => movie.id == widget.movieId,
        orElse: () => null,
    );

    RadarrQualityProfile _findQualityProfile(int profileId, List<RadarrQualityProfile> profiles) {
        return profiles.firstWhere(
            (profile) => profile.id == profileId,
            orElse: () => null,
        );
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        bottomNavigationBar: _bottomNavigationBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Movie Details',
        actions: [
            RadarrAppBarMovieSettingsAction(movieId: widget.movieId),
        ],
    );

    Widget get _bottomNavigationBar => RadarrMovieDetailsNavigationBar(pageController: _pageController);

    Widget get _body => Selector<RadarrState, Tuple2<
        Future<List<RadarrMovie>>,
        Future<List<RadarrQualityProfile>>
    >>(
        selector: (_, state) => Tuple2(
            state.movies,
            state.qualityProfiles,
        ),
        builder: (context, tuple, _) => FutureBuilder(
            future: Future.wait([
                tuple.item1,
                tuple.item2,
            ]),
            builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        LunaLogger().error('Unable to pull Radarr movie details', snapshot.error, StackTrace.current);
                    }
                    return LSErrorMessage(onTapHandler: () => _refresh());
                }
                if(snapshot.hasData) {
                    RadarrMovie movie = _findMovie(snapshot.data[0]);
                    if(movie != null) {
                        RadarrQualityProfile qualityProfile = _findQualityProfile(movie.qualityProfileId, snapshot.data[1]);
                        return movie == null ? _unknown() : _details(movie: movie, qualityProfile: qualityProfile);
                    }
                }
                return LSLoader();
            },
        ),
    );

    Widget _unknown() => LSGenericMessage(text: 'Movie Not Found');

    Widget _details({
        @required RadarrMovie movie,
        @required RadarrQualityProfile qualityProfile,
    }) => PageView(
        controller: _pageController,
        children: [
            RadarrMovieDetailsOverviewPage(movie: movie, qualityProfile: qualityProfile),
            RadarrMovieDetailsFilesPage(movie: movie),
            RadarrMovieDetailsHistoryPage(movie: movie),
            RadarrMovieDetailsCastCrewPage(movie: movie),
        ],
    );
}
