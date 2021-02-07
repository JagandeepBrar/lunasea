import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:tuple/tuple.dart';

class RadarrMoviesAddSearchResults extends StatefulWidget {
    @override
    State<RadarrMoviesAddSearchResults> createState() => _State();
}

class _State extends State<RadarrMoviesAddSearchResults> {
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        if(context.read<RadarrState>().addSearchQuery.isNotEmpty) {
            context.read<RadarrState>().resetExclusions();
            context.read<RadarrState>().fetchMoviesLookup();
        }
    }

    @override
    Widget build(BuildContext context) => Selector<RadarrState, Tuple3<
        Future<List<RadarrMovie>>,
        Future<List<RadarrMovie>>,
        Future<List<RadarrExclusion>>
    >>(
        selector: (_, state) => Tuple3(state.moviesLookup, state.movies, state.exclusions),
        builder: (context, futures, _) {
            if(futures.item1 == null) return Container();
            return _futureBuilder(context, lookup: futures.item1, movies: futures.item2, exclusions: futures.item3);
        },
    );

    Widget _futureBuilder(BuildContext context, {
        @required Future<List<RadarrMovie>> lookup,
        @required Future<List<RadarrMovie>> movies,
        @required Future<List<RadarrExclusion>> exclusions,
    }) => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: Future.wait([
                lookup,
                movies,
                exclusions,
            ]),
            builder: (context, AsyncSnapshot<List> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        LunaLogger().error('Unable to fetch Radarr movie lookup', snapshot.error, StackTrace.current);
                    }
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                if(snapshot.connectionState == ConnectionState.none) return Container();
                if(snapshot.connectionState == ConnectionState.done && snapshot.hasData)
                    return _results(snapshot.data[0], snapshot.data[1], snapshot.data[2]);
                return LSLoader();
            },
        ),
    );

    Widget _results(List<RadarrMovie> results, List<RadarrMovie> movies, List<RadarrExclusion> exclusions) {
        if((results?.length ?? 0) == 0) return LunaListView(
            children: [LSGenericMessage(text: 'No Results Found')],
        );
        return LunaListViewBuilder(
            itemCount: results.length,
            itemBuilder: (context, index) {
                RadarrExclusion exclusion = exclusions?.firstWhere((exclusion) => exclusion.tmdbId == results[index].tmdbId, orElse: () => null);
                return RadarrMoviesAddSearchResultTile(
                    movie: results[index],
                    exists: results[index].id != null,
                    isExcluded: !(exclusion == null),
                );
            },
        );
    }
}
