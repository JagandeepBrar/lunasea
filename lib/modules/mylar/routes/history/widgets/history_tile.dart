import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/router/routes/mylar.dart';

enum MylarHistoryTileType {
  ALL,
  SERIES,
  SEASON,
  EPISODE,
}

class MylarHistoryTile extends StatelessWidget {
  final MylarHistoryRecord history;
  final MylarHistoryTileType type;
  final MylarSeries? series;
  final MylarEpisode? episode;

  const MylarHistoryTile({
    Key? key,
    required this.history,
    required this.type,
    this.series,
    this.episode,
  }) : super(key: key);

  bool _hasEpisodeInfo() {
    if (history.episode != null || episode != null) return true;
    return false;
  }

  bool _hasLongPressAction() {
    switch (type) {
      case MylarHistoryTileType.ALL:
        return true;
      case MylarHistoryTileType.SERIES:
        return _hasEpisodeInfo();
      case MylarHistoryTileType.SEASON:
      case MylarHistoryTileType.EPISODE:
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isThreeLine =
        _hasEpisodeInfo() && type != MylarHistoryTileType.EPISODE;
    return LunaExpandableListTile(
      title: type != MylarHistoryTileType.ALL
          ? history.sourceTitle!
          : series?.title ?? LunaUI.TEXT_EMDASH,
      collapsedSubtitles: [
        if (_isThreeLine) _subtitle1(),
        _subtitle2(),
        _subtitle3(),
      ],
      expandedHighlightedNodes: [
        LunaHighlightedNode(
          text: history.eventType?.readable ?? LunaUI.TEXT_EMDASH,
          backgroundColor: history.eventType!.lunaColour(),
        ),
        if (history.lunaHasPreferredWordScore())
          LunaHighlightedNode(
            text: history.lunaPreferredWordScore(),
            backgroundColor: LunaColours.purple,
          ),
        if (history.episode?.seasonNumber != null)
          LunaHighlightedNode(
            text: 'mylar.SeasonNumber'.tr(
              args: [history.episode!.seasonNumber.toString()],
            ),
            backgroundColor: LunaColours.blueGrey,
          ),
        if (episode?.seasonNumber != null)
          LunaHighlightedNode(
            text: 'mylar.SeasonNumber'.tr(
              args: [episode?.seasonNumber?.toString() ?? LunaUI.TEXT_EMDASH],
            ),
            backgroundColor: LunaColours.blueGrey,
          ),
        if (history.episode?.episodeNumber != null)
          LunaHighlightedNode(
            text: 'mylar.EpisodeNumber'.tr(
              args: [history.episode!.episodeNumber.toString()],
            ),
            backgroundColor: LunaColours.blueGrey,
          ),
        if (episode?.episodeNumber != null)
          LunaHighlightedNode(
            text: 'mylar.EpisodeNumber'.tr(
              args: [episode?.episodeNumber?.toString() ?? LunaUI.TEXT_EMDASH],
            ),
            backgroundColor: LunaColours.blueGrey,
          ),
      ],
      expandedTableContent: history.eventType?.lunaTableContent(
            history: history,
            showSourceTitle: type != MylarHistoryTileType.ALL,
          ) ??
          [],
      onLongPress:
          _hasLongPressAction() ? () async => _onLongPress(context) : null,
    );
  }

  Future<void> _onLongPress(BuildContext context) async {
    switch (type) {
      case MylarHistoryTileType.ALL:
        final id = history.series?.id ?? series?.id ?? -1;
        return MylarRoutes.SERIES.go(params: {
          'series': id.toString(),
        });
      case MylarHistoryTileType.SERIES:
        if (_hasEpisodeInfo()) {
          final seriesId =
              history.seriesId ?? history.series?.id ?? series!.id ?? -1;
          final seasonNum =
              history.episode?.seasonNumber ?? episode?.seasonNumber ?? -1;
          return MylarRoutes.SERIES_SEASON.go(params: {
            'series': seriesId.toString(),
            'season': seasonNum.toString(),
          });
        }
        break;
      default:
        break;
    }
  }

  TextSpan _subtitle1() {
    return TextSpan(children: [
      TextSpan(
        text: history.lunaSeasonEpisode() ??
            episode?.lunaSeasonEpisode() ??
            LunaUI.TEXT_EMDASH,
      ),
      const TextSpan(text: ': '),
      TextSpan(
        text: history.episode?.title ?? episode?.title ?? LunaUI.TEXT_EMDASH,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    ]);
  }

  TextSpan _subtitle2() {
    return TextSpan(
      text: [
        history.date?.asAge() ?? LunaUI.TEXT_EMDASH,
        history.date?.asDateTime() ?? LunaUI.TEXT_EMDASH,
      ].join(LunaUI.TEXT_BULLET.pad()),
    );
  }

  TextSpan _subtitle3() {
    return TextSpan(
      text: history.eventType?.lunaReadable(history) ?? LunaUI.TEXT_EMDASH,
      style: TextStyle(
        color: history.eventType?.lunaColour() ?? LunaColours.blueGrey,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
    );
  }
}
