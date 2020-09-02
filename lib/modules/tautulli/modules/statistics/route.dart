import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliStatisticsRoute extends StatefulWidget {
    TautulliStatisticsRoute({
        Key key,
    }) : super(key: key);

    @override
    State<TautulliStatisticsRoute> createState() => _State();
}

class _State extends State<TautulliStatisticsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        TautulliLocalState _state = Provider.of<TautulliLocalState>(context, listen: false);
        _state.resetStatistics(context);
        await _state.statistics;
    }

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Statistics');

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<TautulliLocalState, Future<List<TautulliHomeStats>>>(
            selector: (_, state) => state.statistics,
            builder: (context, stats, _) => FutureBuilder(
                future: stats,
                builder: (context, AsyncSnapshot<List<TautulliHomeStats>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            Logger.error(
                                'TautulliStatisticsRoute',
                                '_body',
                                'Unable to fetch Tautulli statistics',
                                snapshot.error,
                                null,
                                uploadToSentry: !(snapshot.error is DioError),
                            );
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return snapshot.data.length == 0
                        ? _noStatistics()
                        : _statistics(snapshot.data);
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _noStatistics() => LSGenericMessage(
        text: 'No Statistics Found',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: () async => _refreshKey.currentState.show(),
    );

    Widget _statistics(List<TautulliHomeStats> stats) {
        List<List<Widget>> list = [];
        stats.forEach((element) => list.add(_builder(element)));
        return LSListView(
            children: list.expand((e) => e).toList(),
        );
    }

    List<Widget> _builder(TautulliHomeStats stats) {
        switch(stats.id) {
            case 'top_movies': 
            case 'popular_movies':
            case 'top_tv':
            case 'popular_tv': return _media(stats);
            default: return [Container()];
        }
    }

    List<Widget> _media(TautulliHomeStats stats) => [
        LSHeader(text: stats.title),
        ...List.generate(
            stats.data.length,
            (index) => TautulliStatisticsMediaTile(data: stats.data[index]),
        ),
    ];
}