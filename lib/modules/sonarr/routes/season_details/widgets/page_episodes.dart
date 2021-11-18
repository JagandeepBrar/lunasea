import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeasonDetailsEpisodesPage extends StatefulWidget {
  const SonarrSeasonDetailsEpisodesPage({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrSeasonDetailsEpisodesPage>
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

  Future<void> _refresh() async {
    int seriesId = context.read<SonarrSeasonDetailsState>().seriesId;
    context.read<SonarrSeasonDetailsState>().fetchEpisodes(context);
    context.read<SonarrState>().fetchEpisodeFiles(seriesId);
    await Future.wait([
      context.read<SonarrSeasonDetailsState>().episodes,
      context.read<SonarrState>().getEpisodeFiles(seriesId),
    ]);
  }

  Widget _body() {
    return LunaRefreshIndicator(
      key: _refreshKey,
      context: context,
      onRefresh: _refresh,
      child: Consumer<SonarrSeasonDetailsState>(
        builder: (context, state, _) => FutureBuilder(
          future: Future.wait([
            state.episodes,
            context.select<SonarrState, Future<Map<int, SonarrEpisodeFile>>>(
                (s) => s.getEpisodeFiles(state.seriesId)),
          ]),
          builder: (
            context,
            snapshot,
          ) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                LunaLogger().error(
                  'Unable to fetch Sonarr episode files',
                  snapshot.error,
                  snapshot.stackTrace,
                );
              }
              return LunaMessage.error(
                onTap: _refreshKey.currentState.show,
              );
            }
            if (snapshot.hasData)
              return _list(
                episodes: snapshot.data[0],
                episodeFiles: snapshot.data[1],
              );
            return const LunaLoader();
          },
        ),
      ),
    );
  }

  Widget _list({
    @required List<SonarrEpisode> episodes,
    @required Map<int, SonarrEpisodeFile> episodeFiles,
  }) {
    if (episodes?.isEmpty ?? true) {
      return LunaMessage(
        text: 'sonarr.NoEpisodesFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState.show,
      );
    }
    return LunaListViewBuilder(
      controller: SonarrSeasonDetailsNavigationBar.scrollControllers[0],
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        return SonarrEpisodeTile(
          episode: episodes[index],
          episodeFile: episodes[index].hasFile && episodeFiles != null
              ? episodeFiles[episodes[index].episodeFileId]
              : null,
        );
      },
    );
  }
}
