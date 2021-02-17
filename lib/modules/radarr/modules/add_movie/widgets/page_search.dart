import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieSearchPage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrAddMovieSearchPage> with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    bool get wantKeepAlive => true;

    @override
    Future<void> loadCallback() async {
        if(context.read<RadarrAddMovieState>().searchQuery.isNotEmpty) {
            context.read<RadarrAddMovieState>().executeSearch(context);
            await context.read<RadarrState>()?.lookup;
            await context.read<RadarrAddMovieState>()?.exclusions;
        }
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar.empty(
            child: RadarrAddMovieSearchSearchBar(scrollController: context.watch<RadarrState>().scrollController),
            height: 62.0,
        );
    }

    Widget _body() {
        return Selector<RadarrState, Future<List<RadarrMovie>>>(
            selector: (_, state) => state.movies,
            builder: (context, movies, _) => Selector<RadarrAddMovieState, Future<List<RadarrExclusion>>>(
                selector: (_, state) => state.exclusions,
                builder: (context, exclusions, _) => Selector<RadarrState, Future<List<RadarrMovie>>>(
                    selector: (_, state) => state.lookup,
                    builder: (context, lookup, _) {
                        if(lookup == null) return Container();
                        return _builder(movies, lookup, exclusions);
                    },
                ),
            ),
        );
    }

    Widget _builder(Future<List<RadarrMovie>> movies, Future<List<RadarrMovie>> lookup, Future<List<RadarrExclusion>> exclusions) {
        return LunaRefreshIndicator(
            context: context,
            key: _refreshKey,
            onRefresh: loadCallback,
            child: FutureBuilder(
                future: Future.wait([movies, lookup, exclusions]),
                builder: (context, AsyncSnapshot<List> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) LunaLogger().error(
                            'Unable to fetch Radarr movie lookup',
                            snapshot.error,
                            snapshot.stackTrace,
                        );
                        return LunaMessage.error(onTap: _refreshKey.currentState.show);
                    }
                    if(snapshot.hasData) return _results(snapshot.data[0], snapshot.data[1], snapshot.data[2]);
                    return LunaLoader();
                },
            ),
        );
    }

    Widget _results(List<RadarrMovie> movies, List<RadarrMovie> results, List<RadarrExclusion> exclusions) {
        if((results?.length ?? 0) == 0) return LunaListView(children: [LunaMessage.inList(text: 'No Results Found')]);
        return LunaListViewBuilder(
            scrollController: RadarrAddMovieNavigationBar.scrollControllers[0],
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
