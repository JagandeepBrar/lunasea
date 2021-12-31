import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditRouter extends RadarrPageRouter {
  RadarrMoviesEditRouter() : super('/radarr/editmovie/:movieid');

  @override
  Widget widget([
    int movieId = -1,
  ]) {
    return _Widget(movieId: movieId);
  }

  @override
  Future<void> navigateTo(
    BuildContext context, [
    int movieId = -1,
  ]) async {
    LunaRouter.router.navigateTo(context, route(movieId));
  }

  @override
  String route([
    int movieId = -1,
  ]) {
    return fullRoute.replaceFirst(':movieid', movieId.toString());
  }

  @override
  void defineRoute(
    FluroRouter router,
  ) {
    super.withParameterRouteDefinition(router, (context, params) {
      int movieId = params['movieid'] == null || params['movieid']!.isEmpty
          ? -1
          : (int.tryParse(params['movieid']![0]) ?? -1);
      return _Widget(movieId: movieId);
    });
  }
}

class _Widget extends StatefulWidget {
  final int movieId;

  const _Widget({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget>
    with LunaLoadCallbackMixin, LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Future<void> loadCallback() async {
    context.read<RadarrState>().fetchTags();
    context.read<RadarrState>().fetchQualityProfiles();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movieId <= 0) {
      return LunaInvalidRoute(
        title: 'radarr.EditMovie'.tr(),
        message: 'radarr.MovieNotFound'.tr(),
      );
    }
    return ChangeNotifierProvider(
        create: (_) => RadarrMoviesEditState(),
        builder: (context, _) {
          LunaLoadingState state =
              context.select<RadarrMoviesEditState, LunaLoadingState>(
                  (state) => state.state);
          return LunaScaffold(
            scaffoldKey: _scaffoldKey,
            appBar: _appBar() as PreferredSizeWidget?,
            body:
                state == LunaLoadingState.ERROR ? _bodyError() : _body(context),
            bottomNavigationBar: state == LunaLoadingState.ERROR
                ? null
                : const RadarrEditMovieActionBar(),
          );
        });
  }

  Widget _appBar() {
    return LunaAppBar(
      scrollControllers: [scrollController],
      title: 'radarr.EditMovie'.tr(),
    );
  }

  Widget _bodyError() {
    return LunaMessage.goBack(
      context: context,
      text: 'lunasea.AnErrorHasOccurred'.tr(),
    );
  }

  Widget _body(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        context.select<RadarrState, Future<List<RadarrMovie>>?>(
            (state) => state.movies)!,
        context.select<RadarrState, Future<List<RadarrQualityProfile>>?>(
            (state) => state.qualityProfiles)!,
        context.select<RadarrState, Future<List<RadarrTag>>?>(
            (state) => state.tags)!,
      ]),
      builder: (context, AsyncSnapshot<List<Object>> snapshot) {
        if (snapshot.hasError) {
          return LunaMessage.error(onTap: loadCallback);
        }
        if (snapshot.hasData) {
          RadarrMovie? movie =
              (snapshot.data![0] as List<RadarrMovie>).firstWhereOrNull(
            (movie) => movie.id == widget.movieId,
          );
          if (movie == null) return const LunaLoader();
          return _list(
            context,
            movie: movie,
            qualityProfiles: snapshot.data![1] as List<RadarrQualityProfile?>?,
            tags: snapshot.data![2] as List<RadarrTag>?,
          );
        }
        return const LunaLoader();
      },
    );
  }

  Widget _list(
    BuildContext context, {
    RadarrMovie? movie,
    List<RadarrQualityProfile?>? qualityProfiles,
    List<RadarrTag>? tags,
  }) {
    if (context.read<RadarrMoviesEditState>().movie == null) {
      context.read<RadarrMoviesEditState>().movie = movie;
      context
          .read<RadarrMoviesEditState>()
          .initializeQualityProfile(qualityProfiles!);
      context.read<RadarrMoviesEditState>().initializeTags(tags);
      context.read<RadarrMoviesEditState>().canExecuteAction = true;
    }
    return LunaListView(
      controller: scrollController,
      children: [
        const RadarrMoviesEditMonitoredTile(),
        const RadarrMoviesEditMinimumAvailabilityTile(),
        RadarrMoviesEditQualityProfileTile(profiles: qualityProfiles),
        const RadarrMoviesEditPathTile(),
        const RadarrMoviesEditTagsTile(),
      ],
    );
  }
}
