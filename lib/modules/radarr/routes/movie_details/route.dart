import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesDetailsRouter extends RadarrPageRouter {
  RadarrMoviesDetailsRouter() : super('/radarr/movie/:movieid');

  @override
  Widget widget({
    @required int movieId,
  }) {
    return _Widget(movieId: movieId);
  }

  @override
  Future<void> navigateTo(
    BuildContext context, {
    @required int movieId,
  }) async {
    LunaRouter.router.navigateTo(context, route(movieId: movieId));
  }

  @override
  String route({
    @required int movieId,
  }) {
    return fullRoute.replaceFirst(
      ':movieid',
      movieId.toString(),
    );
  }

  @override
  void defineRoute(FluroRouter router) {
    super.withParameterRouteDefinition(
      router,
      (context, params) {
        int movieId = params['movieid'] == null || params['movieid'].isEmpty
            ? -1
            : (int.tryParse(params['movieid'][0]) ?? -1);
        return _Widget(movieId: movieId);
      },
    );
  }
}

class _Widget extends StatefulWidget {
  final int movieId;

  const _Widget({
    Key key,
    @required this.movieId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> with LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RadarrMovie movie;
  PageController _pageController;

  @override
  Future<void> loadCallback() async {
    if (widget.movieId > 0) {
      RadarrMovie result = _findMovie(await context.read<RadarrState>().movies);
      setState(() => movie = result);
      context.read<RadarrState>().fetchQualityProfiles();
      context.read<RadarrState>().fetchTags();
      await context.read<RadarrState>().resetSingleMovie(widget.movieId);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS.data,
    );
  }

  RadarrMovie _findMovie(List<RadarrMovie> movies) {
    return movies.firstWhere(
      (movie) => movie.id == widget.movieId,
      orElse: () => null,
    );
  }

  List<RadarrTag> _findTags(List<int> tagIds, List<RadarrTag> tags) {
    return tags.where((tag) => tagIds.contains(tag.id)).toList();
  }

  RadarrQualityProfile _findQualityProfile(
      int profileId, List<RadarrQualityProfile> profiles) {
    return profiles.firstWhere(
      (profile) => profile.id == profileId,
      orElse: () => null,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movieId <= 0)
      return LunaInvalidRoute(
        title: 'Movie Details',
        message: 'Movie Not Found',
      );
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      bottomNavigationBar:
          context.watch<RadarrState>().enabled ? _bottomNavigationBar() : null,
      body: _body(),
    );
  }

  Widget _appBar() {
    List<Widget> _actions = movie == null
        ? null
        : [
            LunaIconButton(
              iconSize: LunaUI.ICON_SIZE,
              icon: Icons.edit_rounded,
              onPressed: () async => RadarrMoviesEditRouter()
                  .navigateTo(context, movieId: widget.movieId),
            ),
            RadarrAppBarMovieSettingsAction(movieId: widget.movieId),
          ];
    return LunaAppBar(
      pageController: _pageController,
      scrollControllers: RadarrMovieDetailsNavigationBar.scrollControllers,
      title: 'Movie Details',
      actions: _actions,
    );
  }

  Widget _bottomNavigationBar() {
    if (movie == null) return null;
    return RadarrMovieDetailsNavigationBar(
      pageController: _pageController,
      movie: movie,
    );
  }

  Widget _body() {
    return Consumer<RadarrState>(
      builder: (context, state, _) => FutureBuilder(
        future: Future.wait([
          state.qualityProfiles,
          state.tags,
          state.movies,
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              LunaLogger().error(
                'Unable to pull Radarr movie details',
                snapshot.error,
                snapshot.stackTrace,
              );
            return LunaMessage.error(onTap: loadCallback);
          }
          if (snapshot.hasData) {
            movie = _findMovie(snapshot.data[2]);
            if (movie == null)
              return LunaMessage.goBack(
                text: 'Movie Not Found',
                context: context,
              );
            RadarrQualityProfile qualityProfile =
                _findQualityProfile(movie.qualityProfileId, snapshot.data[0]);
            List<RadarrTag> tags = _findTags(movie.tags, snapshot.data[1]);
            return _pages(qualityProfile, tags);
          }
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _pages(RadarrQualityProfile qualityProfile, List<RadarrTag> tags) {
    return ChangeNotifierProvider(
      create: (context) =>
          RadarrMovieDetailsState(context: context, movie: movie),
      builder: (context, _) => PageView(
        controller: _pageController,
        children: [
          RadarrMovieDetailsOverviewPage(
            movie: movie,
            qualityProfile: qualityProfile,
            tags: tags,
          ),
          const RadarrMovieDetailsFilesPage(),
          RadarrMovieDetailsHistoryPage(movie: movie),
          RadarrMovieDetailsCastCrewPage(movie: movie),
        ],
      ),
    );
  }
}
