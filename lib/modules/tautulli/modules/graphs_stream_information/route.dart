import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliGraphsStreamInformationRoute extends StatefulWidget {
    TautulliGraphsStreamInformationRoute({
        Key key,
    }): super(key: key);

    @override
    State<TautulliGraphsStreamInformationRoute> createState() => _State();
}

class _State extends State<TautulliGraphsStreamInformationRoute> with AutomaticKeepAliveClientMixin {
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
        _state.resetAllStreamInformationGraphs(context);
        await Future.wait([
            _state.dailyStreamTypeBreakdownGraph,
            _state.playCountBySourceResolutionGraph,
            _state.playCountByStreamResolutionGraph,
            _state.playCountByPlatformStreamTypeGraph,
            _state.playCountByUserStreamTypeGraph,
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
                    text: 'Daily Stream Type Breakdown',
                    subtitle: [
                        'Last ${TautulliDatabaseValue.GRAPHS_LINECHART_DAYS.data} Days',
                        '\n\n',
                        'The total play count or duration of television, movies, and music by the transcode decision.',
                    ].join(),
                ),
                TautulliGraphsDailyStreamTypeBreakdownGraph(),
                LSHeader(
                    text: 'By Source Resolution',
                    subtitle: [
                        'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                        '\n\n',
                        'The combined total of television and movies by their original resolution (pre-transcoding).',
                    ].join(),
                ),
                TautulliGraphsPlayCountBySourceResolutionGraph(),
                LSHeader(
                    text: 'By Stream Resolution',
                    subtitle: [
                        'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                        '\n\n',
                        'The combined total of television and movies by their original resolution (pre-transcoding).',
                    ].join(),
                ),
                TautulliGraphsPlayCountByStreamResolutionGraph(),
                LSHeader(
                    text: 'By Platform Stream Type',
                    subtitle: [
                        'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                        '\n\n',
                        'The combined total of television and movies by their original resolution (pre-transcoding).',
                    ].join(),
                ),
                TautulliGraphsPlayCountByPlatformStreamTypeGraph(),
                LSHeader(
                    text: 'By User Stream Type',
                    subtitle: [
                        'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                        '\n\n',
                        'The combined total of television and movies by their original resolution (pre-transcoding).',
                    ].join(),
                ),
                TautulliGraphsPlayCountByUserStreamTypeGraph(),
            ],
        ),
    );
}
