import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrEpisodeTile extends StatelessWidget {
  final SonarrEpisode episode;
  final SonarrEpisodeFile episodeFile;

  const SonarrEpisodeTile({
    Key key,
    @required this.episode,
    this.episodeFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(
        text: episode.title,
        darken: !episode.monitored,
      ),
      subtitle: _collapsedSubtitle(),
      leading: _leading(context),
      trailing: _trailing(context),
      contentPadding: true,
      color: context
              .watch<SonarrSeasonDetailsState>()
              .selectedEpisodes
              .contains(episode.id)
          ? LunaColours.accent.withOpacity(0.15)
          : null,
      onTap: () async => SonarrEpisodeDetailsSheet(
        context: context,
        episode: episode,
        episodeFile: episodeFile,
      ).showModal(context: context),
    );
  }

  Widget _collapsedSubtitle() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: episode.monitored ? Colors.white70 : Colors.white30,
          fontSize: LunaUI.FONT_SIZE_SUBTITLE,
        ),
        children: [
          TextSpan(text: episode.lunaAirDate()),
          const TextSpan(text: '\n'),
          TextSpan(
            text: episode.lunaDownloadedQuality(episodeFile),
            style: TextStyle(
              color: episode.monitored
                  ? episode.lunaDownloadedQualityColor(episodeFile)
                  : episode
                      .lunaDownloadedQualityColor(episodeFile)
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
      text: context
              .watch<SonarrSeasonDetailsState>()
              .selectedEpisodes
              .contains(episode.id)
          ? null
          : episode.episodeNumber.toString(),
      icon: context
              .watch<SonarrSeasonDetailsState>()
              .selectedEpisodes
              .contains(episode.id)
          ? Icons.check_rounded
          : null,
      textSize: LunaUI.FONT_SIZE_BUTTON,
      color: episode.monitored ? Colors.white : Colors.white30,
      onPressed: () =>
          context.read<SonarrSeasonDetailsState>().toggleSelected(episode.id),
    );
  }

  Widget _trailing(BuildContext context) {
    return LunaIconButton(
      icon: Icons.search_rounded,
      color: episode.monitored ? Colors.white : Colors.white30,
      onPressed: () async => SonarrAPIController().episodeSearch(
        context: context,
        episode: episode,
      ),
    );
  }
}
