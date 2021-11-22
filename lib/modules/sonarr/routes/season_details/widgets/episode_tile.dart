import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrEpisodeTile extends StatefulWidget {
  final SonarrEpisode episode;
  final SonarrEpisodeFile episodeFile;

  const SonarrEpisodeTile({
    Key key,
    @required this.episode,
    this.episodeFile,
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
    ).showModal(context: context);
  }

  Future<void> _onLongPress() async {
    Tuple2<bool, SonarrEpisodeSettingsType> results = await SonarrDialogs()
        .episodeSettings(context: context, episode: widget.episode);
    if (results.item1)
      results.item2
          .execute(
        context: context,
        episode: widget.episode,
        episodeFile: widget.episodeFile,
      )
          .then((_) {
        context.read<SonarrSeasonDetailsState>().initializeState(context);
        context
            .read<SonarrSeasonDetailsState>()
            .fetchEpisodeHistory(context, widget.episode.id);
      });
  }

  Widget _collapsedSubtitle() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: widget.episode.monitored ? Colors.white70 : Colors.white30,
          fontSize: LunaUI.FONT_SIZE_SUBTITLE,
        ),
        children: [
          TextSpan(text: widget.episode.lunaAirDate()),
          const TextSpan(text: '\n'),
          TextSpan(
            text: widget.episode.lunaDownloadedQuality(widget.episodeFile),
            style: TextStyle(
              color: widget.episode.monitored
                  ? widget.episode
                      .lunaDownloadedQualityColor(widget.episodeFile)
                  : widget.episode
                      .lunaDownloadedQualityColor(widget.episodeFile)
                      .withOpacity(0.30),
              fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            ),
          ),
        ],
      ),
    );
  }

  Widget _leading(BuildContext context) {
    return LunaIconButton(
      text: widget.episode.episodeNumber.toString(),
      textSize: LunaUI.FONT_SIZE_BUTTON,
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
