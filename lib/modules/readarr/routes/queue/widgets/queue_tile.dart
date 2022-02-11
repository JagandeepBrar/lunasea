import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

enum ReadarrQueueTileType {
  ALL,
  EPISODE,
}

class ReadarrQueueTile extends StatefulWidget {
  final ReadarrQueueRecord queueRecord;
  final ReadarrQueueTileType type;

  const ReadarrQueueTile({
    Key? key,
    required this.queueRecord,
    required this.type,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ReadarrQueueTile> {
  @override
  Widget build(BuildContext context) {
    return LunaExpandableListTile(
      title: widget.queueRecord.title!,
      collapsedSubtitles: [
        if (widget.type == ReadarrQueueTileType.ALL) _subtitle1(),
        if (widget.type == ReadarrQueueTileType.ALL) _subtitle2(),
        _subtitle3(),
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
      case ReadarrQueueTileType.ALL:
        ReadarrAuthorDetailsRouter().navigateTo(
          context,
          widget.queueRecord.authorId!,
        );
        break;
      case ReadarrQueueTileType.EPISODE:
        ReadarrQueueRouter().navigateTo(context);
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
          text: widget.queueRecord.quality?.quality?.name ?? LunaUI.TEXT_EMDASH,
        ),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(
          text: widget.queueRecord.lunaTimeLeft(),
        ),
      ],
    );
  }

  TextSpan _subtitle3() {
    Tuple3<String, IconData, Color> _params =
        widget.queueRecord.lunaStatusParameters(canBeWhite: false);
    return TextSpan(
      style: TextStyle(
        color: _params.item3,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
      children: [
        TextSpan(text: widget.queueRecord.lunaPercentage()),
        TextSpan(text: LunaUI.TEXT_EMDASH.lunaPad()),
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
      if (widget.type == ReadarrQueueTileType.ALL)
        LunaTableContent(
          title: 'readarr.Author'.tr(),
          body: widget.queueRecord.series?.title ?? LunaUI.TEXT_EMDASH,
        ),
      if (widget.type == ReadarrQueueTileType.ALL)
        LunaTableContent(
          title: 'readarr.Title'.tr(),
          body: widget.queueRecord.episode?.title ?? LunaUI.TEXT_EMDASH,
        ),
      if (widget.type == ReadarrQueueTileType.ALL)
        LunaTableContent(title: '', body: ''),
      LunaTableContent(
        title: 'readarr.Quality'.tr(),
        body: widget.queueRecord.quality?.quality?.name ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'readarr.Client'.tr(),
        body: widget.queueRecord.downloadClient ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'readarr.Size'.tr(),
        body: widget.queueRecord.size?.floor().lunaBytesToString() ??
            LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'readarr.TimeLeft'.tr(),
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
          text: 'readarr.Messages'.tr(),
          onTap: () async {
            ReadarrDialogs().showQueueStatusMessages(
              context,
              widget.queueRecord.statusMessages!,
            );
          },
        ),
      // if (widget.queueRecord.status == ReadarrQueueStatus.COMPLETED &&
      //     widget.queueRecord?.trackedDownloadStatus ==
      //         ReadarrTrackedDownloadStatus.WARNING)
      //   LunaButton.text(
      //     icon: Icons.download_done_rounded,
      //     text: 'readarr.Import'.tr(),
      //     onTap: () async {},
      //   ),
      LunaButton.text(
        icon: Icons.delete_rounded,
        color: LunaColours.red,
        text: 'lunasea.Remove'.tr(),
        onTap: () async {
          bool result = await ReadarrDialogs().removeFromQueue(context);
          if (result) {
            ReadarrAPIController()
                .removeFromQueue(
              context: context,
              queueRecord: widget.queueRecord,
            )
                .then((_) {
              switch (widget.type) {
                case ReadarrQueueTileType.ALL:
                  context.read<ReadarrQueueState>().fetchQueue(
                        context,
                        hardCheck: true,
                      );
                  break;
                case ReadarrQueueTileType.EPISODE:
                  /*context.read<ReadarrBookDetailsState>().fetchState(
                        context,
                        shouldFetchEpisodes: false,
                        shouldFetchFiles: false,
                      );*/
                  break;
              }
            });
          }
        },
      ),
    ];
  }
}
