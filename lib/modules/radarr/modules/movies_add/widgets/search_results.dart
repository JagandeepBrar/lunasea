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
        if(context.read<RadarrState>().addSearchQuery.isNotEmpty) context.read<RadarrState>().fetchMoviesLookup();
    }

    @override
    Widget build(BuildContext context) => Selector<RadarrState, Tuple2<
        Future<List<RadarrMovie>>,
        Future<List<RadarrMovie>>
    >>(
        selector: (_, state) => Tuple2(state.moviesLookup, state.movies),
        builder: (context, futures, _) {
            if(futures.item1 == null) return Container();
            return _futureBuilder(context, futures.item1, futures.item2);
        },
    );

    Widget _futureBuilder(BuildContext context, Future<List<RadarrMovie>> lookup, Future<List<RadarrMovie>> movies) => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: Future.wait([
                lookup,
                movies,
            ]),
            builder: (context, AsyncSnapshot<List> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        LunaLogger().error('Unable to fetch Radarr movie lookup', snapshot.error, StackTrace.current);
                    }
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                if(snapshot.connectionState == ConnectionState.none)
                    return Container();
                if(snapshot.connectionState == ConnectionState.done && snapshot.hasData)
                    return _results(snapshot.data[0], snapshot.data[1]);
                return LSLoader();
            },
        ),
    );

    Widget _results(List<RadarrMovie> results, List<RadarrMovie> movies) => LSListView(
        children: results.length == 0
            ? [ LSGenericMessage(text: 'No Results Found') ]
            : List<Widget>.generate(
                results.length,
                (index) => RadarrMoviesAddSearchResultTile(
                    movie: results[index],
                    exists: results[index].id != null,
                ),
            ),
    );
}
