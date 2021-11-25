import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrQueueTile extends StatefulWidget {
  final SonarrQueueRecord queueRecord;
  final bool episodeQueue;

  const SonarrQueueTile({
    Key key,
    @required this.queueRecord,
    this.episodeQueue = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrQueueTile> {
  @override
  Widget build(BuildContext context) {
    return LunaExpandableListTile(
      title: widget.queueRecord.title,
      collapsedSubtitle1: _subtitle1(),
      collapsedSubtitle2: _subtitle2(),
      expandedTableContent: const [],
      expandedHighlightedNodes: _expandedHighlightedNodes(),
      collapsedTrailing: _collapsedTrailing(),
    );
  }

  Widget _collapsedTrailing() {
    Tuple3<String, IconData, Color> _status =
        widget.queueRecord.lunaStatusParameters();
    return LunaIconButton(
      icon: _status.item2,
      color: _status.item3,
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        TextSpan(
          text: widget.queueRecord.quality?.quality?.name ?? LunaUI.TEXT_EMDASH,
        ),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: '${widget.queueRecord.lunaPercentageComplete}%'),
      ],
      style: const TextStyle(
        color: LunaColours.accent,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      children: [
        TextSpan(
          text: widget.queueRecord.episode?.lunaSeasonEpisode() ??
              LunaUI.TEXT_EMDASH,
        ),
        const TextSpan(text: ': '),
        TextSpan(
          text: widget.queueRecord.episode?.title ?? LunaUI.TEXT_EMDASH,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  List<LunaHighlightedNode> _expandedHighlightedNodes() {
    Tuple3<String, IconData, Color> _status =
        widget.queueRecord.lunaStatusParameters();
    return [
      LunaHighlightedNode(
        text: widget.queueRecord.status.lunaStatus(),
        backgroundColor: _status.item3 == Colors.white
            ? LunaColours.blueGrey
            : _status.item3,
      ),
      LunaHighlightedNode(
        text: widget.queueRecord.protocol.lunaReadable(),
        backgroundColor: widget.queueRecord.protocol.lunaProtocolColor(),
      ),
      LunaHighlightedNode(
        text: widget.queueRecord.quality?.quality?.name ?? LunaUI.TEXT_EMDASH,
      ),
      LunaHighlightedNode(
        text: '${widget.queueRecord.lunaPercentageComplete}%',
        backgroundColor: LunaColours.blueGrey,
      ),
    ];
  }
}
