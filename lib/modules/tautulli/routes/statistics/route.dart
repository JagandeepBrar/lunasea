import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliStatisticsRouter extends TautulliPageRouter {
    TautulliStatisticsRouter() : super('/tautulli/statistics');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _TautulliStatisticsRoute());
}

class _TautulliStatisticsRoute extends StatefulWidget {
    @override
    State<_TautulliStatisticsRoute> createState() => _State();
}

class _State extends State<_TautulliStatisticsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        context.read<TautulliState>().resetStatistics();
        await context.read<TautulliState>().statistics;
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

    Widget get _appBar => LunaAppBar(
        title: 'Statistics',
        actions: [
            TautulliStatisticsTypeButton(),
            TautulliStatisticsTimeRangeButton(),
        ],
    );

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<TautulliState, Future<List<TautulliHomeStats>>>(
            selector: (_, state) => state.statistics,
            builder: (context, stats, _) => FutureBuilder(
                future: stats,
                builder: (context, AsyncSnapshot<List<TautulliHomeStats>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger().error('Unable to fetch Tautulli statistics', snapshot.error, StackTrace.current);
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

    List<Widget> _builder(TautulliHomeStats stats) => stats.data.length > 0
        ? [
            LSHeader(text: stats.title),
            ...List.generate(
                stats.data.length,
                (index) {
                    switch(stats.id) {
                        case 'top_movies': 
                        case 'popular_movies': return TautulliStatisticsMediaTile(
                            data: stats.data[index],
                            mediaType: TautulliMediaType.MOVIE,
                        );
                        case 'top_tv':
                        case 'popular_tv': return TautulliStatisticsMediaTile(
                            data: stats.data[index],
                            mediaType: TautulliMediaType.SHOW,
                        );
                        case 'top_music': 
                        case 'popular_music': return TautulliStatisticsMediaTile(
                            data: stats.data[index],
                            mediaType: TautulliMediaType.ARTIST,
                        );
                        case 'last_watched': return TautulliStatisticsRecentlyWatchedTile(data: stats.data[index]);
                        case 'top_users': return TautulliStatisticsUserTile(data: stats.data[index]);
                        case 'top_platforms': return TautulliStatisticsPlatformTile(data: stats.data[index]);
                        case 'most_concurrent': return TautulliStatisticsStreamTile(data: stats.data[index]);
                        default: return Container();
                    }
                }
            )
        ]
        : [];
}
