import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliGraphsPlayByPeriodRoute extends StatefulWidget {
  const TautulliGraphsPlayByPeriodRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<TautulliGraphsPlayByPeriodRoute> createState() => _State();
}

class _State extends State<TautulliGraphsPlayByPeriodRoute>
    with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> loadCallback() async {
    context.read<TautulliState>().resetAllPlayPeriodGraphs();
    await Future.wait([
      context.read<TautulliState>().dailyPlayCountGraph!,
      context.read<TautulliState>().playsByMonthGraph!,
      context.read<TautulliState>().playCountByDayOfWeekGraph!,
      context.read<TautulliState>().playCountByTopPlatformsGraph!,
      context.read<TautulliState>().playCountByTopUsersGraph!,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
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
              'Last ${TautulliDatabase.GRAPHS_LINECHART_DAYS.read()} Days',
              '\n\n',
              'The total play count or duration of television, movies, and music played per day.'
            ].join(),
          ),
          const TautulliGraphsDailyPlayCountGraph(),
          LunaHeader(
            text: 'Monthly',
            subtitle: [
              'Last ${TautulliDatabase.GRAPHS_MONTHS.read()} Months',
              '\n\n',
              'The combined total of television, movies, and music by month.',
            ].join(),
          ),
          const TautulliGraphsPlaysByMonthGraph(),
          LunaHeader(
            text: 'By Day Of Week',
            subtitle: [
              'Last ${TautulliDatabase.GRAPHS_DAYS.read()} Days',
              '\n\n',
              'The combined total of television, movies, and music played per day of the week.',
            ].join(),
          ),
          const TautulliGraphsPlayCountByDayOfWeekGraph(),
          LunaHeader(
            text: 'By Top Platforms',
            subtitle: [
              'Last ${TautulliDatabase.GRAPHS_DAYS.read()} Days',
              '\n\n',
              'The combined total of television, movies, and music played by the top most active platforms.',
            ].join(),
          ),
          const TautulliGraphsPlayCountByTopPlatformsGraph(),
          LunaHeader(
            text: 'By Top Users',
            subtitle: [
              'Last ${TautulliDatabase.GRAPHS_DAYS.read()} Days',
              '\n\n',
              'The combined total of television, movies, and music played by the top most active users.',
            ].join(),
          ),
          const TautulliGraphsPlayCountByTopUsersGraph(),
        ],
      ),
    );
  }
}
