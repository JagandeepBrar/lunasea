import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

enum ReadarrHistoryTileType {
  ALL,
  SERIES,
  SEASON,
  EPISODE,
}

class ReadarrHistoryTile extends StatelessWidget {
  final ReadarrHistoryRecord history;
  final ReadarrHistoryTileType type;
  final ReadarrAuthor? author;
  final ReadarrBook? book;

  const ReadarrHistoryTile({
    Key? key,
    required this.history,
    required this.type,
    this.author,
    this.book,
  }) : super(key: key);

  bool _hasEpisodeInfo() {
    if (history.episode != null || book != null) return true;
    return false;
  }

  bool _hasLongPressAction() {
    switch (type) {
      case ReadarrHistoryTileType.ALL:
        return true;
      case ReadarrHistoryTileType.SERIES:
        return _hasEpisodeInfo();
      case ReadarrHistoryTileType.SEASON:
      case ReadarrHistoryTileType.EPISODE:
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isThreeLine =
        _hasEpisodeInfo() && type != ReadarrHistoryTileType.EPISODE;
    return LunaExpandableListTile(
      title: type != ReadarrHistoryTileType.ALL
          ? history.sourceTitle!
          : author?.title ?? LunaUI.TEXT_EMDASH,
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
        if (history.episode?.title != null)
          LunaHighlightedNode(
            text: history.episode!.title!,
            backgroundColor: LunaColours.blueGrey,
          ),
      ],
      expandedTableContent: history.eventType?.lunaTableContent(
            history: history,
            showSourceTitle: type != ReadarrHistoryTileType.ALL,
          ) ??
          [],
      onLongPress:
          _hasLongPressAction() ? () async => _onLongPress(context) : null,
    );
  }

  Future<void> _onLongPress(BuildContext context) async {
    switch (type) {
      case ReadarrHistoryTileType.ALL:
        return ReadarrAuthorDetailsRouter().navigateTo(
          context,
          history.series?.id ?? author?.id ?? -1,
        );
      case ReadarrHistoryTileType.SERIES:
        if (_hasEpisodeInfo()) {
          return ReadarrBookDetailsRouter().navigateTo(
              context, history.bookId ?? history.episode?.id ?? -1);
        }
        break;
      default:
        break;
    }
  }

  TextSpan _subtitle1() {
    return TextSpan(children: [
      TextSpan(
        text: history.episode?.title ?? book?.title ?? LunaUI.TEXT_EMDASH,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    ]);
  }

  TextSpan _subtitle2() {
    return TextSpan(
      text: [
        history.date?.lunaAge ?? LunaUI.TEXT_EMDASH,
        history.date?.lunaDateTimeReadable() ?? LunaUI.TEXT_EMDASH,
      ].join(LunaUI.TEXT_BULLET.lunaPad()),
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
