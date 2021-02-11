import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:tuple/tuple.dart';

class RadarrCatalogueRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrCatalogueRoute> with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    
    @override
    bool get wantKeepAlive => true;

    @override
    Future<void> loadCallback() async {
        RadarrState _state = context.read<RadarrState>();
        _state.fetchMovies();
        _state.fetchQualityProfiles();
        _state.fetchTags();
        await Future.wait([_state.movies, _state.qualityProfiles, _state.tags]);
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body(),
            appBar: _appBar(),
        );
    }

    Widget _appBar() {
        return LunaAppBar.empty(
            child: RadarrCatalogueSearchBar(scrollController: RadarrNavigationBar.scrollControllers[0]),
            height: 62.0,
        );
    }

    Widget _body() {
        return LunaRefreshIndicator(
            context: context,
            key: _refreshKey,
            onRefresh: loadCallback,
            child: Selector<RadarrState, Tuple2<Future<List<RadarrMovie>>, Future<List<RadarrQualityProfile>>>>(
                selector: (_, state) => Tuple2(state.movies, state.qualityProfiles),
                builder: (context, tuple, _) {
                    return FutureBuilder(
                        future: Future.wait([tuple.item1, tuple.item2]),
                        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                            if(snapshot.hasError) {
                                if(snapshot.connectionState != ConnectionState.waiting) LunaLogger().error(
                                    'Unable to fetch Radarr movies',
                                    snapshot.error,
                                    StackTrace.current,
                                );
                                return LunaMessage.error(onTap: _refreshKey.currentState.show);
                            }
                            if(snapshot.hasData) return _movies(snapshot.data[0], snapshot.data[1]);
                            return LunaLoader();
                        },
                    );
                }
            ),
        );
    }

    Widget _noMovies({ bool showButton = true }) => LunaMessage(
        text: 'No Movies Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState.show,
    );

    Widget _movies(List<RadarrMovie> movies, List<RadarrQualityProfile> qualityProfiles) {
        if((movies?.length ?? 0) == 0) return _noMovies();
        return Selector<RadarrState, String>(
            selector: (_, state) => state.moviesSearchQuery,
            builder: (context, query, _) {
                List<RadarrMovie> _filtered = _filterAndSort(movies, query);
                return LunaListViewBuilder(
                    scrollController: RadarrNavigationBar.scrollControllers[0],
                    itemCount: (_filtered?.length ?? 0) == 0 ? 1 : _filtered.length,
                    itemBuilder: (context, index) {
                        if((_filtered.length ?? 0) == 0) return _noMovies(showButton: false);
                        return RadarrCatalogueTile(
                            movie: _filtered[index],
                            profile: qualityProfiles.firstWhere((element) => element.id == _filtered[index].qualityProfileId, orElse: null),
                        );
                    },
                );
            }
        );
    }

    List<RadarrMovie> _filterAndSort(List<RadarrMovie> movies, String query) {
        if(movies == null || movies.length == 0) return movies;
        // Pull values from state
        RadarrMoviesSorting sorting = context.read<RadarrState>().moviesSortType;
        RadarrMoviesFilter filter = context.read<RadarrState>().moviesFilterType;
        bool ascending = context.read<RadarrState>().moviesSortAscending;
        // Filter
        List<RadarrMovie> filtered = movies.where((movie) {
            if(query != null && query.isNotEmpty) return movie.title.toLowerCase().contains(query.toLowerCase());
            return movie != null;
        }).toList();
        filtered = filter.filter(filtered);
        // Sort
        sorting.sort(filtered, ascending);
        return filtered;
    }
}
