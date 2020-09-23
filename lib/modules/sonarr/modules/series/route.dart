import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:sonarr/sonarr.dart';

class SonarrSeriesRoute extends StatefulWidget {
    SonarrSeriesRoute({
        Key key,
    }): super(key: key);

    @override
    State<SonarrSeriesRoute> createState() => _State();
}

class _State extends State<SonarrSeriesRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    Future<void> _refresh() async {
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
        _state.resetSeries();
        await _state.series;
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<SonarrState, Future<List<SonarrSeries>>>(
            selector: (_, state) => state.series,
            builder: (context, series, _) => FutureBuilder(
                future: series,
                builder: (context, AsyncSnapshot<List<SonarrSeries>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger.error(
                                'SonarrSeriesRoute',
                                '_body',
                                'Unable to fetch Sonarr series',
                                snapshot.error,
                                null,
                                uploadToSentry: !(snapshot.error is DioError),
                            );
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return snapshot.data.length == 0
                        ? _noSeries()
                        : _series(snapshot.data);
                    return LSLoader();
                },
            ),
        ),
    );
    
    void _filter(List<SonarrSeries> series) {
        if(series == null || series.length == 0) return;
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
        _state.seriesSortType.sort(series, _state.seriesSortAscending);
    }

    Widget _series(List<SonarrSeries> series) {
        _filter(series);
        return LSListView(
            children: List.generate(
                series.length,
                (index) => SonarrSeriesTile(series: series[index]),
            ),
        );
    }

    Widget _noSeries() => LSGenericMessage(
        text: 'No Series Found',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: () async => _refreshKey.currentState.show(),
    );
}
