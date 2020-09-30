
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
        SonarrLocalState _state = Provider.of<SonarrLocalState>(context, listen: false);
        if(_state.addSearchQuery.isNotEmpty) _state.fetchseriesLookup(context);
    }

    @override
    Widget build(BuildContext context) => Selector<SonarrLocalState, Future<List<SonarrSeriesLookup>>>(
        selector: (_, state) => state.seriesLookup,
        builder: (context, future, _) {
            if(future == null) return Container();
            return _futureBuilder(future);
        },
    );

    Widget _futureBuilder(Future<List<SonarrSeriesLookup>> future) => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<List<SonarrSeriesLookup>> snapshot) {
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
                        if(snapshot.hasData) return _results(snapshot.data);
                        break;
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    default: break;
                }
                return LSLoader(); 
            },
        ),
    );

    Widget _results(List<SonarrSeriesLookup> results) => LSListView(
        children: results.length == 0
            ? [ LSGenericMessage(text: 'No Results Found') ]
            : List<Widget>.generate(
                results.length,
                (index) => SonarrSeriesAddSearchResultTile(series: results[index]),
            ),
    );
}
