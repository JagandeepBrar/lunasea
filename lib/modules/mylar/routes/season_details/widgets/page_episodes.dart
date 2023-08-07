import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeasonDetailsEpisodesPage extends StatefulWidget {
  const MylarSeasonDetailsEpisodesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MylarSeasonDetailsEpisodesPage>
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
    context.read<MylarSeasonDetailsState>().addListener(_updateFabListener);
  }

  @override
  void dispose() {
    _hideController.dispose();
    super.dispose();
  }

  void _updateFabListener() {
    final state = context.read<MylarSeasonDetailsState>();
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
    final state = context.watch<MylarSeasonDetailsState>();
    return ScaleTransition(
      scale: _hideController,
      child: LunaFloatingActionButton(
        icon: LunaIcons.EDIT,
        label: state.selectedEpisodes.length > 1
            ? 'mylar.EpisodesCount'
                .tr(args: [state.selectedEpisodes.length.toString()])
            : 'mylar.OneEpisode'.tr(),
        onPressed: () async {
          final result = await MylarDialogs().episodeMultiSettings(
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
    await context.read<MylarSeasonDetailsState>().fetchState(
          context,
          shouldFetchHistory: false,
          shouldFetchMostRecentEpisodeHistory: false,
        );
    await Future.wait([
      context.read<MylarSeasonDetailsState>().episodes!,
      context.read<MylarSeasonDetailsState>().files!,
      context.read<MylarSeasonDetailsState>().queue,
    ]);
  }

  List<MylarQueueRecord> _findQueueRecords(
    List<MylarQueueRecord> records,
    int? episodeId,
  ) {
    return records.where((q) => q.episodeId == episodeId).toList();
  }

  Widget _body() {
    return LunaRefreshIndicator(
      key: _refreshKey,
      context: context,
      onRefresh: _refresh,
      child: Consumer<MylarSeasonDetailsState>(
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
                'Unable to fetch Mylar episode files',
                snapshot.error,
                snapshot.stackTrace,
              );
              return LunaMessage.error(
                onTap: _refreshKey.currentState!.show,
              );
            }
            if (snapshot.hasData)
              return _list(
                episodes: snapshot.data![0] as Map<int, MylarEpisode>,
                episodeFiles: snapshot.data![1] as Map<int, MylarEpisodeFile>,
                queue: snapshot.data![2] as List<MylarQueueRecord>,
              );
            return const LunaLoader();
          },
        ),
      ),
    );
  }

  Widget _list({
    required Map<int, MylarEpisode> episodes,
    required Map<int, MylarEpisodeFile> episodeFiles,
    required List<MylarQueueRecord> queue,
  }) {
    if (episodes.isEmpty) {
      return LunaMessage(
        text: 'mylar.NoEpisodesFound'.tr(),
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
      controller: MylarSeasonDetailsNavigationBar.scrollControllers[0],
      itemCount: _widgets.length,
      itemBuilder: (context, index) => _widgets[index],
    );
  }

  List<Widget> _buildSeasonWidgets({
    required Map<int, MylarEpisode> episodes,
    required Map<int, MylarEpisodeFile>? episodeFiles,
    required List<MylarQueueRecord>? queue,
  }) {
    List<MylarEpisode> _episodes = episodes.values.toList()
      ..sort((a, b) {
        int _season = b.seasonNumber!.compareTo(a.seasonNumber!);
        if (_season != 0) return _season;
        return b.episodeNumber!.compareTo(a.episodeNumber!);
      });

    Map<int?, List<MylarEpisode>> _seasons =
        _episodes.groupBy<int?, MylarEpisode>((e) => e.seasonNumber);
    if (_seasons.length == 1) {
      return _episodes
          .map((episode) => MylarEpisodeTile(
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
      _widgets.add(MylarSeasonHeader(
        seriesId: context.read<MylarSeasonDetailsState>().seriesId,
        seasonNumber: key,
      ));
      _seasons[key]!.forEach((episode) {
        _widgets.add(MylarEpisodeTile(
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
