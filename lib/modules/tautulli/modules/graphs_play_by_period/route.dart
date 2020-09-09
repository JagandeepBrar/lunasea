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
                ..._playCountByDate,
            ],
        ),
    );

    List<Widget> get _playCountByDate => [
        LSHeader(
            text: Provider.of<TautulliState>(context).graphYAxis == TautulliGraphYAxis.PLAYS
                ? 'Play Count by Date'
                : 'Play Duration by Date',
        ),
        TautulliGraphsPlayCountByDateGraph(),
    ];
}