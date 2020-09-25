import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliStatisticsRouter {
    static const String ROUTE_NAME = '/tautulli/statistics/list';

    static Future<void> navigateTo(BuildContext context) async => TautulliRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliStatisticsRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliStatisticsRouter._();
}

class _TautulliStatisticsRoute extends StatefulWidget {
    @override
    State<_TautulliStatisticsRoute> createState() => _State();
}

class _State extends State<_TautulliStatisticsRoute> {
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

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Statistics',
        popUntil: '/tautulli',
        actions: [
            TautulliStatisticsTypeButton(),
            TautulliStatisticsTimeRangeButton(),
        ],
    );

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
                            LunaLogger.error(
                                '_TautulliStatisticsRoute',
                                '_body',
                                'Unable to fetch Tautulli statistics',
                                snapshot.error,
                                StackTrace.current,
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
