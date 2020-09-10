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
                    text: _createTitle('Daily Play $_placeholder'),
                    subtitle: 'Last ${TautulliDatabaseValue.GRAPHS_LINECHART_DAYS.data} Days',
                ),
                TautulliGraphsDailyPlayCountGraph(),
                LSHeader(
                    text: _createTitle('Monthly Play $_placeholder'),
                    subtitle: 'Last ${TautulliDatabaseValue.GRAPHS_MONTHS.data} Months',
                ),
                TautulliGraphsPlaysByMonthGraph(),
                LSHeader(
                    text: _createTitle('Play $_placeholder By Day Of Week'),
                    subtitle: 'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                ),
                TautulliGraphsPlayCountByDayOfWeekGraph(),
                LSHeader(
                    text: _createTitle('Play $_placeholder By Top Platforms'),
                    subtitle: 'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                ),
                TautulliGraphsPlayCountByTopPlatformsGraph(),
                LSHeader(
                    text: _createTitle('Play $_placeholder By Top Users'),
                    subtitle: 'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                ),
                TautulliGraphsPlayCountByTopUsersGraph(),
            ],
        ),
    );

    String _createTitle(String title) => Provider.of<TautulliState>(context).graphYAxis == TautulliGraphYAxis.PLAYS
        ? title.replaceFirst(_placeholder, 'Count')
        : title.replaceFirst(_placeholder, 'Duration');
}