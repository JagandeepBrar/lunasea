import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieSearchPage extends StatefulWidget {
  final bool autofocusSearchBar;

  const RadarrAddMovieSearchPage({
    Key? key,
    required this.autofocusSearchBar,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrAddMovieSearchPage>
    with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> loadCallback() async {
    if (context.read<RadarrAddMovieState>().searchQuery.isNotEmpty) {
      context.read<RadarrAddMovieState>().fetchLookup(context);
      await context.read<RadarrAddMovieState>().lookup;
      await context.read<RadarrAddMovieState>().exclusions;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar.empty(
      child: RadarrAddMovieSearchSearchBar(
        query: context.read<RadarrAddMovieState>().searchQuery,
        autofocus: widget.autofocusSearchBar,
        scrollController: RadarrAddMovieNavigationBar.scrollControllers[0],
      ),
      height: LunaTextInputBar.defaultAppBarHeight,
    );
  }

  Widget _body() {
    return Selector<RadarrState, Future<List<RadarrMovie>>?>(
      selector: (_, state) => state.movies,
      builder: (context, movies, _) => Selector<RadarrAddMovieState,
          Tuple2<Future<List<RadarrMovie>>?, Future<List<RadarrExclusion>>?>>(
        selector: (_, state) => Tuple2(state.lookup, state.exclusions),
        builder: (context, tuple, _) {
          if (tuple.item1 == null) return Container();
          return _builder(movies, tuple.item1, tuple.item2);
        },
      ),
    );
  }

  Widget _builder(
      Future<List<RadarrMovie>>? movies,
      Future<List<RadarrMovie>>? lookup,
      Future<List<RadarrExclusion>>? exclusions) {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: Future.wait([movies!, lookup!, exclusions!]),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              LunaLogger().error(
                'Unable to fetch Radarr movie lookup',
                snapshot.error,
                snapshot.stackTrace,
              );
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData)
            return _list(
                snapshot.data![0], snapshot.data![1], snapshot.data![2]);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(
    List<RadarrMovie> movies,
    List<RadarrMovie> results,
    List<RadarrExclusion> exclusions,
  ) {
    if (results.isEmpty)
      return LunaListView(
        controller: RadarrAddMovieNavigationBar.scrollControllers[0],
        children: [
          LunaMessage.inList(text: 'radarr.NoResultsFound'.tr()),
        ],
      );
    return LunaListViewBuilder(
      controller: RadarrAddMovieNavigationBar.scrollControllers[0],
      itemCount: results.length,
      itemBuilder: (context, index) {
        RadarrExclusion? exclusion = exclusions.firstWhereOrNull(
            (exclusion) => exclusion.tmdbId == results[index].tmdbId);
        RadarrMovie? movie = movies
            .firstWhereOrNull((movie) => (movie.id ?? -1) == results[index].id);
        return RadarrAddMovieSearchResultTile(
          movie: results[index],
          exists: movie != null,
          isExcluded: exclusion != null,
        );
      },
    );
  }
}
