import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/router/routes/radarr.dart';

class RadarrHistoryTile extends StatelessWidget {
  final RadarrHistoryRecord history;
  final bool movieHistory;
  final String title;

  /// If [movieHistory] is false (default), you must supply a title or else a dash will be shown.
  const RadarrHistoryTile({
    Key? key,
    required this.history,
    this.movieHistory = false,
    this.title = LunaUI.TEXT_EMDASH,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaExpandableListTile(
      title: movieHistory ? history.sourceTitle! : title,
      collapsedSubtitles: [
        TextSpan(
          text: [
            history.date?.asAge() ?? LunaUI.TEXT_EMDASH,
            history.date?.asDateTime() ?? LunaUI.TEXT_EMDASH,
          ].join(LunaUI.TEXT_BULLET.pad()),
        ),
        TextSpan(
          text: history.eventType?.lunaReadable(history) ?? LunaUI.TEXT_EMDASH,
          style: TextStyle(
            color: history.eventType?.lunaColour ?? LunaColours.blueGrey,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
      ],
      expandedHighlightedNodes: [
        LunaHighlightedNode(
          text: history.eventType!.readable!,
          backgroundColor: history.eventType!.lunaColour,
        ),
        ...history.customFormats!
            .map<LunaHighlightedNode>((format) => LunaHighlightedNode(
                  text: format.name!,
                  backgroundColor: LunaColours.blueGrey,
                )),
      ],
      expandedTableContent: history.eventType?.lunaTableContent(
            history,
            movieHistory: movieHistory,
          ) ??
          [],
      onLongPress: movieHistory
          ? null
          : () => RadarrRoutes.MOVIE.go(params: {
                'movie': history.movieId!.toString(),
              }),
    );
  }
}
