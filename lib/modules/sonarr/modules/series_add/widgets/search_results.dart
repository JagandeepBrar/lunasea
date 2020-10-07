
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddSearchResults extends StatefulWidget {
    @override
    State<SonarrSeriesAddSearchResults> createState() => _State();
}

class _State extends State<SonarrSeriesAddSearchResults> {
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        if(context.read<SonarrState>().addSearchQuery.isNotEmpty) context.read<SonarrState>().fetchSeriesLookup(context);
    }

    @override
    Widget build(BuildContext context) => Selector<SonarrState, Future<List<SonarrSeriesLookup>>>(
        selector: (_, state) => state.seriesLookup,
        builder: (context, future, _) {
            if(future == null) return Container();
            return _futureBuilder(future);
        },
    );

    Widget _futureBuilder(Future<List<SonarrSeriesLookup>> future) => Builder(
        builder: (context) => LSRefreshIndicator(
            refreshKey: _refreshKey,
            onRefresh: _refresh,
            child: FutureBuilder(
                future: Future.wait([
                    future,
                    context.watch<SonarrState>().series,
                ]),
                builder: (context, AsyncSnapshot<List> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger.error(
                                'SonarrSeriesAddSearchResults',
                                '_futureBuilder',
                                'Unable to fetch Sonarr series lookup',
                                snapshot.error,
                                null,
                                uploadToSentry: !(snapshot.error is DioError),
                            );
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    switch(snapshot.connectionState) {
                        case ConnectionState.none: return Container();
                        case ConnectionState.done:
                            if(snapshot.hasData) return _results(snapshot.data[0], snapshot.data[1]);
                            break;
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                        default: break;
                    }
                    return LSLoader(); 
                },
            ),
        ),
    );

    Widget _results(List<SonarrSeriesLookup> results, List<SonarrSeries> series) => LSListView(
        children: results.length == 0
            ? [ LSGenericMessage(text: 'No Results Found') ]
            : List<Widget>.generate(
                results.length,
                (index) => SonarrSeriesAddSearchResultTile(
                    series: results[index],
                    exists: series.indexWhere((series) => series.tvdbId == results[index].tvdbId) >= 0,
                ),
            ),
    );
}
