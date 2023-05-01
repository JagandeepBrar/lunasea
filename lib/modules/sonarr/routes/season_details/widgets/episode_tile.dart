import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/router/routes/sonarr.dart';

class SonarrEpisodeTile extends StatefulWidget {
  final SonarrEpisode episode;
  final SonarrEpisodeFile? episodeFile;
  final List<SonarrQueueRecord>? queueRecords;

  const SonarrEpisodeTile({
    Key? key,
    required this.episode,
    this.episodeFile,
    this.queueRecords,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrEpisodeTile> {
  LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      disabled: !widget.episode.monitored!,
      title: widget.episode.title,
      body: _body(),
      leading: _leading(),
      trailing: _trailing(),
      onTap: _onTap,
      onLongPress: _onLongPress,
      backgroundColor: context
              .read<SonarrSeasonDetailsState>()
              .selectedEpisodes
              .contains(widget.episode.id)
          ? LunaColours.accent.selected()
          : null,
    );
  }

  Future<void> _onTap() async {
    SonarrEpisodeDetailsSheet(
      context: context,
      episode: widget.episode,
      episodeFile: widget.episodeFile,
      queueRecords: widget.queueRecords,
    ).show();
  }

  Future<void> _onLongPress() async {
    Tuple2<bool, SonarrEpisodeSettingsType?> results = await SonarrDialogs()
        .episodeSettings(context: context, episode: widget.episode);
    if (results.item1) {
      results.item2!.execute(
        context: context,
        episode: widget.episode,
        episodeFile: widget.episodeFile,
      );
    }
  }

  List<TextSpan> _body() {
    return [
      TextSpan(text: widget.episode.lunaAirDate()),
      TextSpan(
        text: widget.episode.lunaDownloadedQuality(
          widget.episodeFile,
          widget.queueRecords?.isNotEmpty ?? false
              ? widget.queueRecords!.first
              : null,
        ),
        style: TextStyle(
          color: widget.episode.lunaDownloadedQualityColor(
            widget.episodeFile,
            widget.queueRecords?.isNotEmpty ?? false
                ? widget.queueRecords!.first
                : null,
          ),
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        ),
      ),
    ];
  }

  Widget _leading() {
    return LunaIconButton(
      text: widget.episode.episodeNumber.toString(),
      textSize: LunaUI.FONT_SIZE_H4,
      onPressed: () {
        context
            .read<SonarrSeasonDetailsState>()
            .toggleSelectedEpisode(widget.episode);
      },
    );
  }

  Widget _trailing() {
    Future<void> setLoadingState(LunaLoadingState state) async {
      if (this.mounted) setState(() => _loadingState = state);
    }

    return LunaIconButton(
      icon: Icons.search_rounded,
      loadingState: _loadingState,
      onPressed: () async {
        setLoadingState(LunaLoadingState.ACTIVE);
        SonarrAPIController()
            .episodeSearch(
              context: context,
              episode: widget.episode,
            )
            .whenComplete(() => setLoadingState(LunaLoadingState.INACTIVE));
      },
      onLongPress: () async {
        SonarrRoutes.RELEASES.go(queryParams: {
          'episode': widget.episode.id!.toString(),
        });
      },
    );
  }
}
