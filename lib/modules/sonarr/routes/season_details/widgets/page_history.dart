import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeasonDetailsHistoryPage extends StatefulWidget {
  const SonarrSeasonDetailsHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrSeasonDetailsHistoryPage>
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
          context.read<SonarrSeasonDetailsState>().fetchHistory(context),
      child: FutureBuilder(
        future: Future.wait([
          context.select<SonarrSeasonDetailsState,
              Future<List<SonarrHistoryRecord>>?>((s) => s.history)!,
          context.select<SonarrSeasonDetailsState,
              Future<Map<int?, SonarrEpisode>>?>((s) => s.episodes)!,
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasError) {
            LunaLogger().error(
              'Unable to fetch Sonarr series history for season',
              snapshot.error,
              snapshot.stackTrace,
            );
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData)
            return _list(
              history: snapshot.data![0] as List<SonarrHistoryRecord>,
              episodes: snapshot.data![1] as Map<int, SonarrEpisode>,
            );
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list({
    required List<SonarrHistoryRecord> history,
    required Map<int, SonarrEpisode> episodes,
  }) {
    if (history.isEmpty)
      return LunaMessage(
        text: 'sonarr.NoHistoryFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    return LunaListViewBuilder(
      controller: SonarrSeasonDetailsNavigationBar.scrollControllers[1],
      itemCount: history.length,
      itemBuilder: (context, index) => SonarrHistoryTile(
        history: history[index],
        episode: episodes[history[index].episodeId!],
        type: SonarrHistoryTileType.SEASON,
      ),
    );
  }
}
