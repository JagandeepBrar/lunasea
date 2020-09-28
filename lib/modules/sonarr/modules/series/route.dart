import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:tuple/tuple.dart';

class SonarrSeriesRoute extends StatefulWidget {
    final ScrollController scrollController;

    SonarrSeriesRoute({
        Key key,
        @required this.scrollController,
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
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
        _state.resetSeries();
        _state.resetQualityProfiles();
        await Future.wait([
            _state.series,
            _state.qualityProfiles,
        ]);
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<SonarrState, Tuple2<Future<List<SonarrSeries>>, Future<List<SonarrQualityProfile>>>>(
            selector: (_, state) => Tuple2(state.series, state.qualityProfiles),
            builder: (context, tuple, _) => FutureBuilder(
                future: Future.wait([
                    tuple.item1,
                    tuple.item2,
                ]),
                builder: (context, AsyncSnapshot<List<Object>> snapshot) {
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
                        : _series(snapshot.data[0], snapshot.data[1]);
                    return LSLoader();
                },
            ),
        ),
    );
    
    List<SonarrSeries> _filterAndSort(List<SonarrSeries> series, List<SonarrQualityProfile> profiles, String query) {
        if(series == null || series.length == 0) return series;
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
        List<SonarrSeries> _filtered = new List<SonarrSeries>.from(series);
        // Filter
        _filtered = _filtered.where((show) {
            if(query != null && query.isNotEmpty) return show.title.toLowerCase().contains(query.toLowerCase());
            return show != null;
        }).toList();
        _filtered = _state.seriesHidingType.filter(_filtered);
        // Sort
        _filtered = _state.seriesSortType.sort(_filtered, _state.seriesSortAscending);
        return _filtered;
    }

    Widget _series(List<SonarrSeries> series, List<SonarrQualityProfile> profiles) => Selector<SonarrLocalState, String>(
        selector: (_, state) => state.homeSearchQuery,
        builder: (context, query, _) {
            List<SonarrSeries> _filtered = _filterAndSort(series, profiles, query);
            return LSListView(
                controller: widget.scrollController,
                children: _filtered.length == 0
                    ? [_noSeries(showButton: false)]
                    : List.generate(
                        _filtered.length,
                        (index) => SonarrSeriesTile(
                            series: _filtered[index],
                            profile: profiles.firstWhere((element) => element.id == _filtered[index].profileId, orElse: null),
                        ),
                    ),
            );
        },
    );

    Widget _noSeries({ bool showButton = true }) => LSGenericMessage(
        text: 'No Series Found',
        showButton: showButton,
        buttonText: 'Refresh',
        onTapHandler: () async => _refreshKey.currentState.show(),
    );
}
