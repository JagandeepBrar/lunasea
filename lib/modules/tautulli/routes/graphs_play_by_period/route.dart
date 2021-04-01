import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliGraphsPlayByPeriodRoute extends StatefulWidget {
    TautulliGraphsPlayByPeriodRoute({
        Key key,
    }): super(key: key);

    @override
    State<TautulliGraphsPlayByPeriodRoute> createState() => _State();
}

class _State extends State<TautulliGraphsPlayByPeriodRoute> with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    bool get wantKeepAlive => true;

    Future<void> loadCallback() async {
        context.read<TautulliState>().resetAllPlayPeriodGraphs();
        await Future.wait([
            context.read<TautulliState>().dailyPlayCountGraph,
            context.read<TautulliState>().playsByMonthGraph,
            context.read<TautulliState>().playCountByDayOfWeekGraph,
            context.read<TautulliState>().playCountByTopPlatformsGraph,
            context.read<TautulliState>().playCountByTopUsersGraph,
        ]);
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body(),
        );
    }

    Widget _body() {
        return LunaRefreshIndicator(
            context: context,
            key: _refreshKey,
            onRefresh: loadCallback,
            child: LunaListView(
                controller: TautulliGraphsNavigationBar.scrollControllers[0],
                children: [
                    LunaHeader(
                        text: 'Daily',
                        subtitle: [
                            'Last ${TautulliDatabaseValue.GRAPHS_LINECHART_DAYS.data} Days',
                            '\n\n',
                            'The total play count or duration of television, movies, and music played per day.'
                        ].join(),
                    ),
                    TautulliGraphsDailyPlayCountGraph(),
                    LunaHeader(
                        text: 'Monthly',
                        subtitle: [
                            'Last ${TautulliDatabaseValue.GRAPHS_MONTHS.data} Months',
                            '\n\n',
                            'The combined total of television, movies, and music by month.',
                        ].join(),
                    ),
                    TautulliGraphsPlaysByMonthGraph(),
                    LunaHeader(
                        text: 'By Day Of Week',
                        subtitle: [
                            'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                            '\n\n',
                            'The combined total of television, movies, and music played per day of the week.',
                        ].join(),
                    ),
                    TautulliGraphsPlayCountByDayOfWeekGraph(),
                    LunaHeader(
                        text: 'By Top Platforms',
                        subtitle: [
                            'Last ${TautulliDatabaseValue.GRAPHS_DAYS.data} Days',
                            '\n\n',
                            'The combined total of television, movies, and music played by the top most active platforms.',
                        ].join(),
                    ),
                    TautulliGraphsPlayCountByTopPlatformsGraph(),
                    LunaHeader(
                        text: 'By Top Users',
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
    }
}
