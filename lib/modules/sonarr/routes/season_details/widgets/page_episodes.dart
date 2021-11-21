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
    context.read<SonarrSeasonDetailsState>().fetchEpisodes(context);
    context.read<SonarrSeasonDetailsState>().fetchFiles(context);
    await Future.wait([
      context.read<SonarrSeasonDetailsState>().episodes,
      context.read<SonarrSeasonDetailsState>().files,
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
            state.files,
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

    List<Widget> _widgets = _buildSeasonWidgets(
      episodes: episodes,
      episodeFiles: episodeFiles,
    );

    return LunaListViewBuilder(
      controller: SonarrSeasonDetailsNavigationBar.scrollControllers[0],
      itemCount: _widgets.length,
      itemBuilder: (context, index) => _widgets[index],
    );
  }

  List<Widget> _buildSeasonWidgets({
    @required List<SonarrEpisode> episodes,
    @required Map<int, SonarrEpisodeFile> episodeFiles,
  }) {
    Map<int, List<SonarrEpisode>> _seasons =
        episodes.groupBy<int, SonarrEpisode>((e) => e.seasonNumber);
    if (_seasons.length == 1) {
      return episodes
          .map((episode) => SonarrEpisodeTile(
                episode: episode,
                episodeFile: episode.hasFile && episodeFiles != null
                    ? episodeFiles[episode.episodeFileId]
                    : null,
              ))
          .toList();
    }
    List<Widget> _widgets = [];
    _seasons.keys.forEach((key) {
      _widgets.add(SonarrSeasonHeader(seasonNumber: key));
      _seasons[key].forEach((episode) {
        _widgets.add(SonarrEpisodeTile(
          episode: episode,
          episodeFile: episode.hasFile && episodeFiles != null
              ? episodeFiles[episode.episodeFileId]
              : null,
        ));
      });
    });
    return _widgets;
  }
}
