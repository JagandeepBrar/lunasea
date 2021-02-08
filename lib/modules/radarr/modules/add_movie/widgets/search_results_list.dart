import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:tuple/tuple.dart';

class RadarrAddMovieSearchResultsList extends StatefulWidget {
    @override
    State<RadarrAddMovieSearchResultsList> createState() => _State();
}

class _State extends State<RadarrAddMovieSearchResultsList> {
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        if(context.read<RadarrAddMovieState>().searchQuery.isNotEmpty) context.read<RadarrAddMovieState>().executeSearch(context);
        await context.read<RadarrAddMovieState>()?.lookup;
        await context.read<RadarrAddMovieState>()?.exclusions;

    }

    @override
    Widget build(BuildContext context) {
        return Selector<RadarrState, Future<List<RadarrMovie>>>(
            selector: (_, state) => state.movies,
            builder: (context, movies, _) => Selector<RadarrAddMovieState, Tuple2<Future<List<RadarrMovie>>, Future<List<RadarrExclusion>>>>(
                selector: (_, state) => Tuple2(state.lookup, state.exclusions),
                builder: (context, futures, _) {
                    if(futures.item1 == null) return Container();
                    return _builder(
                        context,
                        movies: movies,
                        lookup: futures.item1,
                        exclusions: futures.item2,
                    );
                }
            ),
        );
    }

    Widget _builder(BuildContext context, {
        @required Future<List<RadarrMovie>> lookup,
        @required Future<List<RadarrMovie>> movies,
        @required Future<List<RadarrExclusion>> exclusions,
    }) => LunaRefreshIndicator(
        context: context,
        key: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: Future.wait([lookup, movies, exclusions]),
            builder: (context, AsyncSnapshot<List> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) LunaLogger().error(
                        'Unable to fetch Radarr movie lookup',
                        snapshot.error,
                        StackTrace.current,
                    );
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) return _results(
                    results: snapshot.data[0],
                    movies: snapshot.data[1],
                    exclusions: snapshot.data[2],
                );
                return LSLoader();
            },
        ),
    );

    Widget _results({
        @required List<RadarrMovie> results,
        @required List<RadarrMovie> movies,
        @required List<RadarrExclusion> exclusions,
    }) {
        if((results?.length ?? 0) == 0) return LunaListView(children: [LSGenericMessage(text: 'No Results Found')]);
        return LunaListViewBuilder(
            scrollController: context.read<RadarrState>().scrollController,
            itemCount: results.length,
            itemBuilder: (context, index) {
                RadarrExclusion exclusion = exclusions?.firstWhere((exclusion) => exclusion.tmdbId == results[index].tmdbId, orElse: () => null);
                return RadarrAddMovieSearchResultTile(
                    movie: results[index],
                    exists: results[index].id != null,
                    isExcluded: !(exclusion == null),
                );
            },
        );
    }
}
