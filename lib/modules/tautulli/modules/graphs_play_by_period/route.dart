import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliGraphsPlayByPeriodRoute extends StatefulWidget {
    TautulliGraphsPlayByPeriodRoute({
        Key key,
    }): super(key: key);

    @override
    State<TautulliGraphsPlayByPeriodRoute> createState() => _State();
}

class _State extends State<TautulliGraphsPlayByPeriodRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    final String _placeholder = '<<!title!>>';

    @override
    bool get wantKeepAlive => true;
    
    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        TautulliLocalState _state = Provider.of<TautulliLocalState>(context, listen: false);
        _state.resetAllPlayPeriodGraphs(context);
        await Future.wait([
            _state.dailyPlayCountGraph,
            _state.playsByMonthGraph,
            _state.playCountByDayOfWeekGraph,
            _state.playCountByTopPlatformsGraph,
            _state.playCountByTopUsersGraph,
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
        child: LSListView(
            children: [
                LSHeader(
                    text: _createTitle('Daily $_placeholder'),
                    subtitle: [
                        'Last ${TautulliDatabaseValue.GRAPHS_LINECHART_DAYS.data} Days',
                        '\n\n',
                        'The total play count or duration of television, movies, and music played per day.'
                    ].join(),
                ),
                TautulliGraphsDailyPlayCountGraph(),
                LSHeader(
                    text: _createTitle('Monthly $_placeholder'),
                    subtitle: [
                        'Last ${TautulliDatabaseValue.GRAPHS_MONTHS.data} Months',
                        '\n\n',
                        'The combined total of television, movies, and music by month.',
                    ].join(),
                ),
                TautulliGraphsPlaysByMonthGraph(),
                LSHeader(
                    text: _createTitle('$_placeholder By Day Of Week'),
                    subtitle: [
                        'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                        '\n\n',
                        'The combined total of television, movies, and music played per day of the week.',
                    ].join(),
                ),
                TautulliGraphsPlayCountByDayOfWeekGraph(),
                LSHeader(
                    text: _createTitle('$_placeholder By Top Platforms'),
                    subtitle: [
                        'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                        '\n\n',
                        'The combined total of television, movies, and music played by the top most active platforms.',
                    ].join(),
                ),
                TautulliGraphsPlayCountByTopPlatformsGraph(),
                LSHeader(
                    text: _createTitle('$_placeholder By Top Users'),
                    subtitle: [
                        'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                        '\n\n',
                        'The combined total of television, movies, and music played by the top most active users.',
                    ].join(),
                ),
                TautulliGraphsPlayCountByTopUsersGraph(),
            ],
        ),
    );

    String _createTitle(String title) => Provider.of<TautulliState>(context).graphYAxis == TautulliGraphYAxis.PLAYS
        ? title.replaceFirst(_placeholder, 'Plays')
        : title.replaceFirst(_placeholder, 'Duration');
}