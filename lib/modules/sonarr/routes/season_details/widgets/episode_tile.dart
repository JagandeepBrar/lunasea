import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrEpisodeTile extends StatefulWidget {
  final SonarrEpisode episode;
  final SonarrEpisodeFile episodeFile;
  final List<SonarrQueueRecord> queueRecords;

  const SonarrEpisodeTile({
    Key key,
    @required this.episode,
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
    return LunaListTile(
      context: context,
      title: LunaText.title(
        text: widget.episode.title,
        darken: !widget.episode.monitored,
      ),
      subtitle: _collapsedSubtitle(),
      leading: _leading(context),
      trailing: _trailing(context),
      contentPadding: true,
      onTap: _onTap,
      onLongPress: _onLongPress,
    );
  }

  Future<void> _onTap() async {
    SonarrEpisodeDetailsSheet(
      context: context,
      episode: widget.episode,
      episodeFile: widget.episodeFile,
      queueRecords: widget.queueRecords,
    ).showModal(context: context);
  }

  Future<void> _onLongPress() async {
    Tuple2<bool, SonarrEpisodeSettingsType> results = await SonarrDialogs()
        .episodeSettings(context: context, episode: widget.episode);
    if (results.item1) {
      results.item2.execute(
        context: context,
        episode: widget.episode,
        episodeFile: widget.episodeFile,
      );
    }
  }

  Widget _collapsedSubtitle() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: widget.episode.monitored ? Colors.white70 : Colors.white30,
          fontSize: LunaUI.FONT_SIZE_H3,
        ),
        children: [
          TextSpan(text: widget.episode.lunaAirDate()),
          const TextSpan(text: '\n'),
          TextSpan(
            text: widget.episode.lunaDownloadedQuality(
              widget.episodeFile,
              widget.queueRecords?.isNotEmpty ?? false
                  ? widget.queueRecords.first
                  : null,
            ),
            style: TextStyle(
              color: widget.episode.monitored
                  ? widget.episode.lunaDownloadedQualityColor(
                      widget.episodeFile,
                      widget.queueRecords?.isNotEmpty ?? false
                          ? widget.queueRecords.first
                          : null,
                    )
                  : widget.episode
                      .lunaDownloadedQualityColor(
                        widget.episodeFile,
                        widget.queueRecords?.isNotEmpty ?? false
                            ? widget.queueRecords.first
                            : null,
                      )
                      .withOpacity(0.30),
              fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            ),
          ),
        ],
      ),
      maxLines: 2,
      softWrap: false,
      overflow: TextOverflow.fade,
    );
  }

  Widget _leading(BuildContext context) {
    return LunaIconButton(
      text: widget.episode.episodeNumber.toString(),
      color: widget.episode.monitored ? Colors.white : Colors.white30,
    );
  }

  Widget _trailing(BuildContext context) {
    Future<void> setLoadingState(LunaLoadingState state) async {
      if (this.mounted) setState(() => _loadingState = state);
    }

    return LunaIconButton(
      icon: Icons.search_rounded,
      color: widget.episode.monitored ? Colors.white : Colors.white30,
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
      onLongPress: () async => SonarrReleasesRouter().navigateTo(
        context,
        episodeId: widget.episode.id,
      ),
    );
  }
}
