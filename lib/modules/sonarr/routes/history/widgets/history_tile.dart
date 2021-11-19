import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrHistoryTile extends StatelessWidget {
  final SonarrHistoryRecord history;
  final SonarrSeries series;
  final SonarrEpisode episode;
  final bool seriesHistory;

  const SonarrHistoryTile({
    Key key,
    @required this.history,
    this.series,
    this.episode,
    this.seriesHistory = false,
  }) : super(key: key);

  bool _hasEpisodeInfo() {
    if (history.episode != null || episode != null) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return LunaExpandableListTile(
      title: seriesHistory
          ? history.sourceTitle
          : series?.title ?? LunaUI.TEXT_EMDASH,
      collapsedSubtitle1: _hasEpisodeInfo() ? _subtitle1() : _subtitle2(),
      collapsedSubtitle2: _hasEpisodeInfo() ? _subtitle2() : _subtitle3(),
      collapsedSubtitle3: _hasEpisodeInfo() ? _subtitle3() : null,
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
        if (episode?.seasonNumber != null)
          LunaHighlightedNode(
            text: 'sonarr.SeasonNumber'.tr(
              args: [episode?.seasonNumber.toString()],
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
        if (episode?.episodeNumber != null)
          LunaHighlightedNode(
            text: 'sonarr.EpisodeNumber'.tr(
              args: [episode?.episodeNumber.toString()],
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
                seriesId: history?.series?.id ?? series?.id ?? -1,
              ),
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(children: [
      TextSpan(
        text: history?.lunaSeasonEpisode() ??
            episode?.lunaSeasonEpisode() ??
            LunaUI.TEXT_EMDASH,
      ),
      const TextSpan(text: ': '),
      TextSpan(
        text: history?.episode?.title ?? episode?.title ?? LunaUI.TEXT_EMDASH,
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
