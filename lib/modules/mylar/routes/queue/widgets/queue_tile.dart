import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/router/routes/mylar.dart';

enum MylarQueueTileType {
  ALL,
  EPISODE,
}

class MylarQueueTile extends StatefulWidget {
  final MylarQueueRecord queueRecord;
  final MylarQueueTileType type;

  const MylarQueueTile({
    Key? key,
    required this.queueRecord,
    required this.type,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MylarQueueTile> {
  @override
  Widget build(BuildContext context) {
    return LunaExpandableListTile(
      title: widget.queueRecord.title!,
      collapsedSubtitles: [
        if (widget.type == MylarQueueTileType.ALL) _subtitle1(),
        if (widget.type == MylarQueueTileType.ALL) _subtitle2(),
        _subtitle3(),
        _subtitle4(),
      ],
      expandedTableContent: _expandedTableContent(),
      expandedHighlightedNodes: _expandedHighlightedNodes(),
      expandedTableButtons: _tableButtons(),
      collapsedTrailing: _collapsedTrailing(),
      onLongPress: _onLongPress,
    );
  }

  Future<void> _onLongPress() async {
    switch (widget.type) {
      case MylarQueueTileType.ALL:
        MylarRoutes.SERIES.go(params: {
          'series': widget.queueRecord.seriesId!.toString(),
        });
        break;
      case MylarQueueTileType.EPISODE:
        MylarRoutes.QUEUE.go();
        break;
    }
  }

  Widget _collapsedTrailing() {
    Tuple3<String, IconData, Color> _status =
        widget.queueRecord.lunaStatusParameters();
    return LunaIconButton(
      icon: _status.item2,
      color: _status.item3,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      text: widget.queueRecord.series!.title ?? LunaUI.TEXT_EMDASH,
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        TextSpan(
            text: widget.queueRecord.episode?.lunaSeasonEpisode() ??
                LunaUI.TEXT_EMDASH),
        const TextSpan(text: ': '),
        TextSpan(
            text: widget.queueRecord.episode!.title ?? LunaUI.TEXT_EMDASH,
            style: const TextStyle(fontStyle: FontStyle.italic)),
      ],
    );
  }

  TextSpan _subtitle3() {
    return TextSpan(
      children: [
        TextSpan(
          text: widget.queueRecord.quality?.quality?.name ?? LunaUI.TEXT_EMDASH,
        ),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        if (widget.queueRecord.language != null)
          TextSpan(
            text: widget.queueRecord.language?.name ?? LunaUI.TEXT_EMDASH,
          ),
        if (widget.queueRecord.language != null)
          TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        TextSpan(
          text: widget.queueRecord.lunaTimeLeft(),
        ),
      ],
    );
  }

  TextSpan _subtitle4() {
    Tuple3<String, IconData, Color> _params =
        widget.queueRecord.lunaStatusParameters(canBeWhite: false);
    return TextSpan(
      style: TextStyle(
        color: _params.item3,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
      children: [
        TextSpan(text: widget.queueRecord.lunaPercentage()),
        TextSpan(text: LunaUI.TEXT_EMDASH.pad()),
        TextSpan(text: _params.item1),
      ],
    );
  }

  List<LunaHighlightedNode> _expandedHighlightedNodes() {
    Tuple3<String, IconData, Color> _status =
        widget.queueRecord.lunaStatusParameters(canBeWhite: false);
    return [
      LunaHighlightedNode(
        text: widget.queueRecord.protocol!.lunaReadable(),
        backgroundColor: widget.queueRecord.protocol!.lunaProtocolColor(),
      ),
      LunaHighlightedNode(
        text: widget.queueRecord.lunaPercentage(),
        backgroundColor: _status.item3,
      ),
      LunaHighlightedNode(
        text: widget.queueRecord.status!.lunaStatus(),
        backgroundColor: _status.item3,
      ),
    ];
  }

  List<LunaTableContent> _expandedTableContent() {
    return [
      if (widget.type == MylarQueueTileType.ALL)
        LunaTableContent(
          title: 'mylar.Series'.tr(),
          body: widget.queueRecord.series?.title ?? LunaUI.TEXT_EMDASH,
        ),
      if (widget.type == MylarQueueTileType.ALL)
        LunaTableContent(
          title: 'mylar.Episode'.tr(),
          body: widget.queueRecord.episode?.lunaSeasonEpisode() ??
              LunaUI.TEXT_EMDASH,
        ),
      if (widget.type == MylarQueueTileType.ALL)
        LunaTableContent(
          title: 'mylar.Title'.tr(),
          body: widget.queueRecord.episode?.title ?? LunaUI.TEXT_EMDASH,
        ),
      if (widget.type == MylarQueueTileType.ALL)
        LunaTableContent(title: '', body: ''),
      LunaTableContent(
        title: 'mylar.Quality'.tr(),
        body: widget.queueRecord.quality?.quality?.name ?? LunaUI.TEXT_EMDASH,
      ),
      if (widget.queueRecord.language != null)
        LunaTableContent(
          title: 'mylar.Language'.tr(),
          body: widget.queueRecord.language?.name ?? LunaUI.TEXT_EMDASH,
        ),
      LunaTableContent(
        title: 'mylar.Client'.tr(),
        body: widget.queueRecord.downloadClient ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'mylar.Size'.tr(),
        body: widget.queueRecord.size?.floor().asBytes() ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'mylar.TimeLeft'.tr(),
        body: widget.queueRecord.lunaTimeLeft(),
      ),
    ];
  }

  List<LunaButton> _tableButtons() {
    return [
      if ((widget.queueRecord.statusMessages ?? []).isNotEmpty)
        LunaButton.text(
          icon: Icons.messenger_outline_rounded,
          color: LunaColours.orange,
          text: 'mylar.Messages'.tr(),
          onTap: () async {
            MylarDialogs().showQueueStatusMessages(
              context,
              widget.queueRecord.statusMessages!,
            );
          },
        ),
      // if (widget.queueRecord.status == MylarQueueStatus.COMPLETED &&
      //     widget.queueRecord?.trackedDownloadStatus ==
      //         MylarTrackedDownloadStatus.WARNING)
      //   LunaButton.text(
      //     icon: Icons.download_done_rounded,
      //     text: 'mylar.Import'.tr(),
      //     onTap: () async {},
      //   ),
      LunaButton.text(
        icon: Icons.delete_rounded,
        color: LunaColours.red,
        text: 'lunasea.Remove'.tr(),
        onTap: () async {
          bool result = await MylarDialogs().removeFromQueue(context);
          if (result) {
            MylarAPIController()
                .removeFromQueue(
              context: context,
              queueRecord: widget.queueRecord,
            )
                .then((_) {
              switch (widget.type) {
                case MylarQueueTileType.ALL:
                  context.read<MylarQueueState>().fetchQueue(
                        context,
                        hardCheck: true,
                      );
                  break;
                case MylarQueueTileType.EPISODE:
                  context.read<MylarSeasonDetailsState>().fetchState(
                        context,
                        shouldFetchEpisodes: false,
                        shouldFetchFiles: false,
                      );
                  break;
              }
            });
          }
        },
      ),
    ];
  }
}
