import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

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
                    text: _createTitle('Daily Stream Type Breakdown'),
                    subtitle: [
                        'Last ${TautulliDatabaseValue.GRAPHS_LINECHART_DAYS.data} Days',
                        '\n\n',
                        'The total play count or duration of television, movies, and music by the transcode decision.',
                    ].join(),
                ),
                TautulliGraphsDailyStreamTypeBreakdownGraph(),
                LSHeader(
                    text: _createTitle('$_placeholder By Source Resolution'),
                    subtitle: [
                        'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                        '\n\n',
                        'The combined total of television and movies by their original resolution (pre-transcoding).',
                    ].join(),
                ),
                TautulliGraphsPlayCountBySourceResolutionGraph(),
                LSHeader(
                    text: _createTitle('$_placeholder By Stream Resolution'),
                    subtitle: [
                        'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                        '\n\n',
                        'The combined total of television and movies by their original resolution (pre-transcoding).',
                    ].join(),
                ),
                TautulliGraphsPlayCountByStreamResolutionGraph(),
                LSHeader(
                    text: _createTitle('$_placeholder By Platform Stream Type'),
                    subtitle: [
                        'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                        '\n\n',
                        'The combined total of television and movies by their original resolution (pre-transcoding).',
                    ].join(),
                ),
                TautulliGraphsPlayCountByPlatformStreamTypeGraph(),
                LSHeader(
                    text: _createTitle('$_placeholder By User Stream Type'),
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

    String _createTitle(String title) => Provider.of<TautulliState>(context).graphYAxis == TautulliGraphYAxis.PLAYS
        ? title.replaceFirst(_placeholder, 'Plays')
        : title.replaceFirst(_placeholder, 'Duration');
}