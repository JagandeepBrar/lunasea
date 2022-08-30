import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class StatisticsRoute extends StatefulWidget {
  const StatisticsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<StatisticsRoute> createState() => _State();
}

class _State extends State<StatisticsRoute>
    with LunaLoadCallbackMixin, LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final List<String> denylist = [
    'top_libraries',
    'popular_music',
    'top_music',
  ];

  @override
  Future<void> loadCallback() async {
    context.read<TautulliState>().resetStatistics();
    await context.read<TautulliState>().statistics;
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.TAUTULLI,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Statistics',
      scrollControllers: [scrollController],
      actions: const [
        TautulliStatisticsTypeButton(),
        TautulliStatisticsTimeRangeButton(),
      ],
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: Selector<TautulliState, Future<List<TautulliHomeStats>>>(
        selector: (_, state) => state.statistics!,
        builder: (context, stats, _) => FutureBuilder(
          future: stats,
          builder: (context, AsyncSnapshot<List<TautulliHomeStats>> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting)
                LunaLogger().error(
                  'Unable to fetch Tautulli statistics',
                  snapshot.error,
                  snapshot.stackTrace,
                );
              return LunaMessage.error(onTap: _refreshKey.currentState!.show);
            }
            if (snapshot.hasData) return _statistics(snapshot.data);
            return const LunaLoader();
          },
        ),
      ),
    );
  }

  Widget _statistics(List<TautulliHomeStats>? stats) {
    if ((stats?.length ?? 0) == 0)
      return LunaMessage(
        text: 'No Statistics Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState?.show,
      );
    List<List<Widget>> list = [];
    stats!.forEach((element) => list.add(_builder(element)));
    return LunaListView(
      controller: scrollController,
      children: list.expand((e) => e).toList(),
    );
  }

  List<Widget> _builder(TautulliHomeStats stats) {
    if ((stats.data ?? 0) == 0 || denylist.contains(stats.id)) return [];
    return [
      LunaHeader(text: stats.title),
      ...List.generate(stats.data!.length, (index) {
        switch (stats.id) {
          case 'top_movies':
          case 'popular_movies':
            return TautulliStatisticsMediaTile(
              data: stats.data![index],
              mediaType: TautulliMediaType.MOVIE,
            );
          case 'top_tv':
          case 'popular_tv':
            return TautulliStatisticsMediaTile(
              data: stats.data![index],
              mediaType: TautulliMediaType.SHOW,
            );
          case 'top_music':
          case 'popular_music':
            return TautulliStatisticsMediaTile(
              data: stats.data![index],
              mediaType: TautulliMediaType.ARTIST,
            );
          case 'last_watched':
            return TautulliStatisticsRecentlyWatchedTile(
                data: stats.data![index]);
          case 'top_users':
            return TautulliStatisticsUserTile(data: stats.data![index]);
          case 'top_platforms':
            return TautulliStatisticsPlatformTile(data: stats.data![index]);
          case 'most_concurrent':
            return TautulliStatisticsStreamTile(data: stats.data![index]);
          default:
            return Container();
        }
      })
    ];
  }
}
