import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliGraphsRoute extends StatefulWidget {
    static const String ROUTE_NAME = '/tautulli/graphs/:profile';

    TautulliGraphsRoute({
        Key key,
    }) : super(key: key);

    @override
    State<TautulliGraphsRoute> createState() => _State();

    static String route({ String profile }) {
        if(profile == null) return '/tautulli/graphs/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}';
        return '/tautulli/graphs/$profile';
    }
}

class _State extends State<TautulliGraphsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        TautulliLocalState _state = Provider.of<TautulliLocalState>(context, listen: false);
        _state.resetAllGraphs(context);
        await _state.playCountByDateGraph;
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

    Widget get _appBar => LSAppBar(
        title: 'Graphs',
        actions: [
            TautulliGraphsTypeButton(),
        ],
    );

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