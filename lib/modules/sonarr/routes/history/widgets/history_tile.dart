import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrHistoryTile extends StatelessWidget {
  final SonarrHistoryRecord history;
  final SonarrSeries series;
  final bool seriesHistory;

  const SonarrHistoryTile({
    Key key,
    @required this.history,
    this.series,
    this.seriesHistory = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaExpandableListTile(
      title: seriesHistory
          ? history.sourceTitle
          : series?.title ?? LunaUI.TEXT_EMDASH,
      collapsedSubtitle1: seriesHistory ? _subtitle2() : _subtitle1(),
      collapsedSubtitle2: seriesHistory ? _subtitle3() : _subtitle2(),
      collapsedSubtitle3: seriesHistory ? null : _subtitle3(),
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
      expandedTableContent: history.eventType?.lunaTableContent(
            history,
            seriesHistory: seriesHistory,
          ) ??
          [],
      onLongPress: seriesHistory
          ? null
          : () async => SonarrSeriesDetailsRouter().navigateTo(
                context,
                seriesId: history?.series?.id ?? -1,
              ),
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(children: [
      TextSpan(text: history?.lunaSeasonEpisode() ?? LunaUI.TEXT_EMDASH),
      const TextSpan(text: ': '),
      TextSpan(
        text: history?.episode?.title ?? LunaUI.TEXT_EMDASH,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    ]);
  }

  TextSpan _subtitle2() {
    return TextSpan(
      text: [
        history?.date?.lunaAge ?? LunaUI.TEXT_EMDASH,
        history?.date?.lunaDateTimeReadable() ?? LunaUI.TEXT_EMDASH,
      ].join(LunaUI.TEXT_BULLET.lunaPad()),
    );
  }

  TextSpan _subtitle3() {
    return TextSpan(
      text: history?.eventType?.lunaReadable(history) ?? LunaUI.TEXT_EMDASH,
      style: TextStyle(
        color: history?.eventType?.lunaColour() ?? LunaColours.blueGrey,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
    );
  }
}
