import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeasonDetailsHistoryPage extends StatefulWidget {
  const MylarSeasonDetailsHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MylarSeasonDetailsHistoryPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

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
      onRefresh: () async =>
          context.read<MylarSeasonDetailsState>().fetchHistory(context),
      child: FutureBuilder(
        future: Future.wait([
          context.select<MylarSeasonDetailsState,
              Future<List<MylarHistoryRecord>>?>((s) => s.history)!,
          context.select<MylarSeasonDetailsState,
              Future<Map<int?, MylarEpisode>>?>((s) => s.episodes)!,
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasError) {
            LunaLogger().error(
              'Unable to fetch Mylar series history for season',
              snapshot.error,
              snapshot.stackTrace,
            );
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData)
            return _list(
              history: snapshot.data![0] as List<MylarHistoryRecord>,
              episodes: snapshot.data![1] as Map<int, MylarEpisode>,
            );
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list({
    required List<MylarHistoryRecord> history,
    required Map<int, MylarEpisode> episodes,
  }) {
    if (history.isEmpty)
      return LunaMessage(
        text: 'mylar.NoHistoryFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    return LunaListViewBuilder(
      controller: MylarSeasonDetailsNavigationBar.scrollControllers[1],
      itemCount: history.length,
      itemBuilder: (context, index) => MylarHistoryTile(
        history: history[index],
        episode: episodes[history[index].episodeId!],
        type: MylarHistoryTileType.SEASON,
      ),
    );
  }
}
