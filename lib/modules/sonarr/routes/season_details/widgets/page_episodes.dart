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
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  late AnimationController _hideController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _hideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: LunaUI.ANIMATION_SPEED),
    );
    context.read<SonarrSeasonDetailsState>().addListener(_updateFabListener);
  }

  @override
  void dispose() {
    _hideController.dispose();
    super.dispose();
  }

  void _updateFabListener() {
    final state = context.read<SonarrSeasonDetailsState>();
    if (state.selectedEpisodes.isNotEmpty) {
      _hideController.forward();
    } else {
      _hideController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget? _floatingActionButton() {
    final state = context.watch<SonarrSeasonDetailsState>();
    return ScaleTransition(
      scale: _hideController,
      child: LunaFloatingActionButton(
        icon: LunaIcons.EDIT,
        label: state.selectedEpisodes.length > 1
            ? 'sonarr.EpisodesCount'
                .tr(args: [state.selectedEpisodes.length.toString()])
            : 'sonarr.OneEpisode'.tr(),
        onPressed: () async {
          final result = await SonarrDialogs().episodeMultiSettings(
            context,
            state.selectedEpisodes.length,
          );

          if (result.item1) {
            final eps = (await state.episodes)!
                .values
                .filter((ep) => state.selectedEpisodes.contains(ep.id!))
                .toList();
            result.item2!.execute(
              context,
              eps,
            );
            state.clearSelectedEpisodes();
          }
        },
      ),
    );
  }

  Future<void> _refresh() async {
    await context.read<SonarrSeasonDetailsState>().fetchState(
          context,
          shouldFetchHistory: false,
          shouldFetchMostRecentEpisodeHistory: false,
        );
    await Future.wait([
      context.read<SonarrSeasonDetailsState>().episodes!,
      context.read<SonarrSeasonDetailsState>().files!,
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
            state.episodes!,
            state.files!,
            state.queue,
          ]),
          builder: (
            context,
            AsyncSnapshot<List<Object>> snapshot,
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
                episodes: snapshot.data![0] as Map<int, SonarrEpisode>,
                episodeFiles: snapshot.data![1] as Map<int, SonarrEpisodeFile>,
                queue: snapshot.data![2] as List<SonarrQueueRecord>,
              );
            return const LunaLoader();
          },
        ),
      ),
    );
  }

  Widget _list({
    required Map<int, SonarrEpisode> episodes,
    required Map<int, SonarrEpisodeFile> episodeFiles,
    required List<SonarrQueueRecord> queue,
  }) {
    if (episodes.isEmpty) {
      return LunaMessage(
        text: 'sonarr.NoEpisodesFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    }

    List<Widget> _widgets = _buildSeasonWidgets(
      episodes: episodes,
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
