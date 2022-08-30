import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/router/routes/radarr.dart';
import 'package:lunasea/types/list_view_option.dart';

class RadarrCatalogueRoute extends StatefulWidget {
  const RadarrCatalogueRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrCatalogueRoute>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  Future<void> _refresh() async {
    RadarrState _state = context.read<RadarrState>();
    _state.fetchMovies();
    _state.fetchQualityProfiles();
    _state.fetchTags();
    await Future.wait([
      _state.movies!,
      _state.qualityProfiles!,
      _state.tags!,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body(),
      appBar: _appBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar.empty(
      child: RadarrCatalogueSearchBar(
        scrollController: RadarrNavigationBar.scrollControllers[0],
      ),
      height: LunaTextInputBar.defaultAppBarHeight,
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: _refresh,
      child: Selector<
              RadarrState,
              Tuple2<Future<List<RadarrMovie>>?,
                  Future<List<RadarrQualityProfile>>?>>(
          selector: (_, state) => Tuple2(
                state.movies,
                state.qualityProfiles,
              ),
          builder: (context, tuple, _) {
            return FutureBuilder(
              future: Future.wait([
                tuple.item1!,
                tuple.item2!,
              ]),
              builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                if (snapshot.hasError) {
                  if (snapshot.connectionState != ConnectionState.waiting) {
                    LunaLogger().error(
                      'Unable to fetch Radarr movies',
                      snapshot.error,
                      snapshot.stackTrace,
                    );
                  }
                  return LunaMessage.error(
                    onTap: _refreshKey.currentState!.show,
                  );
                }
                if (snapshot.hasData)
                  return _movieList(
                    snapshot.data![0] as List<RadarrMovie>,
                    snapshot.data![1] as List<RadarrQualityProfile>,
                  );
                return const LunaLoader();
              },
            );
          }),
    );
  }

  List<RadarrMovie> _filterAndSort(
    List<RadarrMovie> movies,
    String query,
  ) {
    if (movies.isEmpty) return movies;
    RadarrMoviesSorting sorting = context.watch<RadarrState>().moviesSortType;
    RadarrMoviesFilter filter = context.watch<RadarrState>().moviesFilterType;
    bool ascending = context.watch<RadarrState>().moviesSortAscending;
    // Filter
    List<RadarrMovie> filtered = movies.where((movie) {
      if (query.isNotEmpty && movie.id != null)
        return movie.title!.toLowerCase().contains(query.toLowerCase());
      return movie.id != null;
    }).toList();
    filtered = filter.filter(filtered);
    // Sort
    filtered = sorting.sort(filtered, ascending);
    return filtered;
  }

  Widget _movieList(
    List<RadarrMovie> movies,
    List<RadarrQualityProfile> qualityProfiles,
  ) {
    if (movies.isEmpty)
      return LunaMessage(
        text: 'radarr.NoMoviesFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    return Selector<RadarrState, String>(
      selector: (_, state) => state.moviesSearchQuery,
      builder: (context, query, _) {
        List<RadarrMovie> _filtered = _filterAndSort(movies, query);
        if (_filtered.isEmpty)
          return LunaListView(
            controller: RadarrNavigationBar.scrollControllers[0],
            children: [
              LunaMessage.inList(text: 'radarr.NoMoviesFound'.tr()),
              if (query.isNotEmpty)
                LunaButtonContainer(
                  children: [
                    LunaButton.text(
                      icon: null,
                      text: query.length > 20
                          ? 'radarr.SearchFor'.tr(args: [
                              '"${query.substring(0, min(20, query.length))}${LunaUI.TEXT_ELLIPSIS}"'
                            ])
                          : 'radarr.SearchFor'.tr(args: ['"$query"']),
                      backgroundColor: LunaColours.accent,
                      onTap: () => RadarrRoutes.ADD_MOVIE.go(queryParams: {
                        'query': query,
                      }),
                    ),
                  ],
                ),
            ],
          );
        switch (context.read<RadarrState>().moviesViewType) {
          case LunaListViewOption.BLOCK_VIEW:
            return _blockView(_filtered, qualityProfiles);
          case LunaListViewOption.GRID_VIEW:
            return _gridView(_filtered, qualityProfiles);
          default:
            throw Exception('Invalid moviesViewType');
        }
      },
    );
  }

  Widget _blockView(
    List<RadarrMovie> movies,
    List<RadarrQualityProfile> qualityProfiles,
  ) {
    return LunaListViewBuilder(
      controller: RadarrNavigationBar.scrollControllers[0],
      itemCount: movies.length,
      itemExtent: RadarrCatalogueTile.itemExtent,
      itemBuilder: (context, index) => RadarrCatalogueTile(
        movie: movies[index],
        profile: qualityProfiles.firstWhereOrNull(
          (element) => element.id == movies[index].qualityProfileId,
        ),
      ),
    );
  }

  Widget _gridView(
    List<RadarrMovie> movies,
    List<RadarrQualityProfile> qualityProfiles,
  ) {
    return LunaGridViewBuilder(
      controller: RadarrNavigationBar.scrollControllers[0],
      sliverGridDelegate: LunaGridBlock.getMaxCrossAxisExtent(),
      itemCount: movies.length,
      itemBuilder: (context, index) => RadarrCatalogueTile.grid(
        movie: movies[index],
        profile: qualityProfiles.firstWhereOrNull(
          (element) => element.id == movies[index].qualityProfileId,
        ),
      ),
    );
  }
}
