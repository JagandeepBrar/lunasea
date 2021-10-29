import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrHistoryTile extends StatelessWidget {
  final SonarrHistoryRecord history;

  const SonarrHistoryTile({
    Key key,
    @required this.history,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaExpandableListTile(
      title: history?.lunaSeriesTitle() ?? LunaUI.TEXT_EMDASH,
      collapsedSubtitle1: TextSpan(children: [
        TextSpan(text: history?.lunaSeasonEpisode() ?? LunaUI.TEXT_EMDASH),
        const TextSpan(text: ': '),
        TextSpan(
          text: history?.episode?.title ?? LunaUI.TEXT_EMDASH,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ]),
      collapsedSubtitle2: TextSpan(
        text: [
          history?.date?.lunaAge ?? LunaUI.TEXT_EMDASH,
          history?.date?.lunaDateTimeReadable() ?? LunaUI.TEXT_EMDASH,
        ].join(LunaUI.TEXT_BULLET.lunaPad()),
      ),
      collapsedSubtitle3: TextSpan(
        text: history?.eventType?.lunaReadable(history) ?? LunaUI.TEXT_EMDASH,
        style: TextStyle(
          color: history?.eventType?.lunaColour() ?? LunaColours.blueGrey,
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        ),
      ),
      expandedHighlightedNodes: [
        LunaHighlightedNode(
          text: history.eventType?.readable ?? LunaUI.TEXT_EMDASH,
          backgroundColor: history.eventType?.lunaColour(),
        ),
        if (history?.episode?.seasonNumber != null)
          LunaHighlightedNode(
            text: 'sonarr.SeasonNumber'.tr(
              args: [history.episode.seasonNumber.toString()],
            ),
            backgroundColor: LunaColours.blueGrey,
          ),
        if (history?.episode?.episodeNumber != null)
          LunaHighlightedNode(
            text: 'sonarr.EpisodeNumber'.tr(
              args: [history.episode.episodeNumber.toString()],
            ),
            backgroundColor: LunaColours.blueGrey,
          ),
      ],
      expandedTableContent: history.eventType?.lunaTableContent(history) ?? [],
      onLongPress: () async => SonarrSeriesDetailsRouter().navigateTo(
        context,
        seriesId: history?.series?.id ?? -1,
      ),
    );
  }
}
