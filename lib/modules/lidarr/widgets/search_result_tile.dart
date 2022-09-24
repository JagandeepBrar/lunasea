import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/double/time.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/router/router.dart';

class LidarrReleasesTile extends StatefulWidget {
  final LidarrReleaseData release;

  const LidarrReleasesTile({
    Key? key,
    required this.release,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LidarrReleasesTile> {
  LunaLoadingState _downloadState = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return LunaExpandableListTile(
      title: widget.release.title,
      collapsedSubtitles: [
        _subtitle1(),
        _subtitle2(),
      ],
      collapsedTrailing: _trailing(),
      expandedHighlightedNodes: _highlightedNodes(),
      expandedTableContent: _tableContent(),
      expandedTableButtons: _tableButtons(),
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(children: [
      TextSpan(
        style: TextStyle(
          color: lunaProtocolColor,
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        ),
        text: widget.release.protocol.toTitleCase(),
      ),
      if (widget.release.isTorrent)
        TextSpan(
          text: ' (${widget.release.seeders}/${widget.release.leechers})',
          style: TextStyle(
            color: lunaProtocolColor,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
      TextSpan(text: LunaUI.TEXT_BULLET.pad()),
      TextSpan(text: widget.release.indexer),
      TextSpan(text: LunaUI.TEXT_BULLET.pad()),
      TextSpan(text: widget.release.ageHours.asTimeAgo()),
    ]);
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        TextSpan(text: widget.release.quality),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        TextSpan(text: widget.release.size.asBytes()),
      ],
    );
  }

  Widget _trailing() {
    return LunaIconButton(
      icon: widget.release.approved
          ? Icons.file_download_rounded
          : Icons.report_outlined,
      color: widget.release.approved ? Colors.white : LunaColours.red,
      onPressed: () async =>
          widget.release.approved ? _startDownload() : _showWarnings(),
      onLongPress: _startDownload,
      loadingState: _downloadState,
    );
  }

  List<LunaHighlightedNode> _highlightedNodes() {
    return [
      LunaHighlightedNode(
        text: widget.release.protocol.toTitleCase(),
        backgroundColor: lunaProtocolColor,
      ),
    ];
  }

  List<LunaTableContent> _tableContent() {
    return [
      LunaTableContent(
          title: 'source', body: widget.release.protocol.toTitleCase()),
      LunaTableContent(title: 'age', body: widget.release.ageHours.asTimeAgo()),
      LunaTableContent(title: 'indexer', body: widget.release.indexer),
      LunaTableContent(title: 'size', body: widget.release.size.asBytes()),
      LunaTableContent(title: 'quality', body: widget.release.quality),
      if (widget.release.protocol == 'torrent' &&
          widget.release.seeders != null)
        LunaTableContent(title: 'seeders', body: '${widget.release.seeders}'),
      if (widget.release.protocol == 'torrent' &&
          widget.release.leechers != null)
        LunaTableContent(title: 'leechers', body: '${widget.release.leechers}'),
    ];
  }

  Color get lunaProtocolColor {
    if (!widget.release.isTorrent) return LunaColours.accent;
    int seeders = widget.release.seeders ?? 0;
    if (seeders > 10) return LunaColours.blue;
    if (seeders > 0) return LunaColours.orange;
    return LunaColours.red;
  }

  List<LunaButton> _tableButtons() {
    return [
      LunaButton(
        type: LunaButtonType.TEXT,
        icon: Icons.download_rounded,
        text: 'Download',
        onTap: _startDownload,
        loadingState: _downloadState,
      ),
      if (widget.release.infoUrl.isNotEmpty)
        LunaButton.text(
          text: 'Indexer',
          icon: Icons.info_outline_rounded,
          color: LunaColours.blue,
          onTap: widget.release.infoUrl.openLink,
        ),
      if (!widget.release.approved)
        LunaButton.text(
          text: 'Rejected',
          icon: Icons.report_outlined,
          color: LunaColours.red,
          onTap: _showWarnings,
        ),
    ];
  }

  Future<void> _startDownload() async {
    setState(() => _downloadState = LunaLoadingState.ACTIVE);
    LidarrAPI _api = LidarrAPI.from(LunaProfile.current);
    await _api
        .downloadRelease(widget.release.guid, widget.release.indexerId)
        .then((_) {
      showLunaSuccessSnackBar(
        title: 'Downloading...',
        message: widget.release.title,
        showButton: true,
        buttonText: 'Back',
        buttonOnPressed: LunaRouter().popToRootRoute,
      );
    }).catchError((error, stack) {
      showLunaErrorSnackBar(
        title: 'Failed to Start Downloading',
        error: error,
      );
    });
    setState(() => _downloadState = LunaLoadingState.INACTIVE);
  }

  Future<void> _showWarnings() async => await LunaDialogs().showRejections(
        context,
        widget.release.rejections.cast<String>(),
      );
}
