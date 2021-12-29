import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeasonDetailsEpisodesPage extends StatefulWidget {
  const SonarrSeasonDetailsEpisodesPage({
    Key? key,
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
    await context.read<SonarrSeasonDetailsState>().fetchState(
          context,
          shouldFetchHistory: false,
          shouldFetchMostRecentEpisodeHistory: false,
        );
    await Future.wait([
      context.read<SonarrSeasonDetailsState>().episodes.then((value) => value!),
      context.read<SonarrSeasonDetailsState>().files.then((value) => value!),
      context.read<SonarrSeasonDetailsState>().queue,
    ]);
  }

  List<SonarrQueueRecord> _findQueueRecords(
    List<SonarrQueueRecord> records,
    int? episodeId,
  ) {
    return records.where((q) => q.episodeId == episodeId).toList();
  }

  Widget _body() {
    return LunaRefreshIndicator(
      key: _refreshKey,
      context: context,
      onRefresh: _refresh,
      child: Consumer<SonarrSeasonDetailsState>(
        builder: (context, state, _) => FutureBuilder(
          future: Future.wait([
            state.episodes.then((value) => value!),
            state.files.then((value) => value!),
            state.queue,
          ]),
          builder: (
            context,
            snapshot,
          ) {
            if (snapshot.hasError) {
              LunaLogger().error(
                'Unable to fetch Sonarr episode files',
                snapshot.error,
                snapshot.stackTrace,
              );
              return LunaMessage.error(
                onTap: _refreshKey.currentState!.show,
              );
            }
            if (snapshot.hasData)
              return _list(
                episodes: snapshot.data[0],
                episodeFiles: snapshot.data[1],
                queue: snapshot.data[2],
              );
            return const LunaLoader();
          },
        ),
      ),
    );
  }

  Widget _list({
    required Map<int, SonarrEpisode>? episodes,
    required Map<int, SonarrEpisodeFile>? episodeFiles,
    required List<SonarrQueueRecord>? queue,
  }) {
    if (episodes?.isEmpty ?? true) {
      return LunaMessage(
        text: 'sonarr.NoEpisodesFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    }

    List<Widget> _widgets = _buildSeasonWidgets(
      episodes: episodes!,
      episodeFiles: episodeFiles,
      queue: queue,
    );

    return LunaListViewBuilder(
      controller: SonarrSeasonDetailsNavigationBar.scrollControllers[0],
      itemCount: _widgets.length,
      itemBuilder: (context, index) => _widgets[index],
    );
  }

  List<Widget> _buildSeasonWidgets({
    required Map<int, SonarrEpisode> episodes,
    required Map<int, SonarrEpisodeFile>? episodeFiles,
    required List<SonarrQueueRecord>? queue,
  }) {
    List<SonarrEpisode> _episodes = episodes.values.toList()
      ..sort((a, b) {
        int _season = b.seasonNumber!.compareTo(a.seasonNumber!);
        if (_season != 0) return _season;
        return b.episodeNumber!.compareTo(a.episodeNumber!);
      });

    Map<int?, List<SonarrEpisode>> _seasons =
        _episodes.groupBy<int?, SonarrEpisode>((e) => e.seasonNumber);
    if (_seasons.length == 1) {
      return _episodes
          .map((episode) => SonarrEpisodeTile(
                episode: episode,
                episodeFile: episode.hasFile! && episodeFiles != null
                    ? episodeFiles[episode.episodeFileId!]
                    : null,
                queueRecords: _findQueueRecords(queue!, episode.id),
              ))
          .toList();
    }
    List<Widget> _widgets = [];
    _seasons.keys.forEach((key) {
      _widgets.add(SonarrSeasonHeader(
        seriesId: context.read<SonarrSeasonDetailsState>().seriesId,
        seasonNumber: key,
      ));
      _seasons[key]!.forEach((episode) {
        _widgets.add(SonarrEpisodeTile(
          episode: episode,
          episodeFile: episode.hasFile! && episodeFiles != null
              ? episodeFiles[episode.episodeFileId!]
              : null,
          queueRecords: _findQueueRecords(queue!, episode.id),
        ));
      });
    });
    return _widgets;
  }
}
