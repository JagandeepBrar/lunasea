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
            _state.playCountByDateGraph,
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
                ..._dailyPlayCount,
                ..._playsByMonth,
                ..._playCountByDayOfWeek,
                ..._playCountByHourOfDay,
                ..._playCountByTopPlatforms,
                ..._playCountByTopUsers,
            ],
        ),
    );

    List<Widget> get _dailyPlayCount => [
        LSHeader(text: _createTitle('Daily Play $_placeholder')),
        TautulliGraphsPlayCountByDateGraph(),
    ];

    List<Widget> get _playsByMonth => [
        LSHeader(text: 'Plays By Month'),
    ];

    List<Widget> get _playCountByDayOfWeek => [
        LSHeader(text: _createTitle('Play $_placeholder By Day Of Week')),
    ];

    List<Widget> get _playCountByHourOfDay => [
        LSHeader(text: _createTitle('Play $_placeholder By Hour Of Day')),
    ];

    List<Widget> get _playCountByTopPlatforms => [
        LSHeader(text: _createTitle('Play $_placeholder By Top Platforms')),
    ];

    List<Widget> get _playCountByTopUsers => [
        LSHeader(text: _createTitle('Play $_placeholder By Top Users')),
    ];

    String _createTitle(String title) => Provider.of<TautulliState>(context).graphYAxis == TautulliGraphYAxis.PLAYS
        ? title.replaceFirst(_placeholder, 'Count')
        : title.replaceFirst(_placeholder, 'Duration');
}