import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrReleasesTile extends StatefulWidget {
  final ReadarrRelease release;

  const ReadarrReleasesTile({
    required this.release,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ReadarrReleasesTile> {
  LunaLoadingState _downloadState = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return LunaExpandableListTile(
      title: widget.release.title!,
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

  Widget _trailing() {
    return LunaIconButton(
      icon: widget.release.lunaTrailingIcon,
      color: widget.release.lunaTrailingColor,
      onPressed: () async =>
          widget.release.rejected! ? _showWarnings() : _startDownload(),
      onLongPress: _startDownload,
      loadingState: _downloadState,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      children: [
        TextSpan(
          text: widget.release.lunaProtocol,
          style: TextStyle(
            color: widget.release.protocol!.lunaProtocolColor(
              release: widget.release,
            ),
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: widget.release.lunaIndexer),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: widget.release.lunaAge),
      ],
    );
  }

  TextSpan _subtitle2() {
    String? _preferredWordScore =
        widget.release.lunaPreferredWordScore(nullOnEmpty: true);
    return TextSpan(
      children: [
        if (_preferredWordScore != null)
          TextSpan(
            text: _preferredWordScore,
            style: const TextStyle(
              color: LunaColours.purple,
              fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            ),
          ),
        if (_preferredWordScore != null)
          TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: widget.release.lunaQuality),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: widget.release.lunaSize),
      ],
    );
  }

  List<LunaHighlightedNode> _highlightedNodes() {
    return [
      LunaHighlightedNode(
        text: widget.release.protocol!.lunaReadable(),
        backgroundColor: widget.release.protocol!.lunaProtocolColor(
          release: widget.release,
        ),
      ),
      if (widget.release.lunaPreferredWordScore(nullOnEmpty: true) != null)
        LunaHighlightedNode(
          text: widget.release.lunaPreferredWordScore()!,
          backgroundColor: LunaColours.purple,
        ),
    ];
  }

  List<LunaTableContent> _tableContent() {
    return [
      LunaTableContent(
        title: 'readarr.Age'.tr(),
        body: widget.release.lunaAge,
      ),
      LunaTableContent(
        title: 'readarr.Indexer'.tr(),
        body: widget.release.lunaIndexer,
      ),
      LunaTableContent(
        title: 'readarr.Size'.tr(),
        body: widget.release.lunaSize,
      ),
      LunaTableContent(
        title: 'readarr.Quality'.tr(),
        body: widget.release.lunaQuality,
      ),
      if (widget.release.seeders != null)
        LunaTableContent(
          title: 'readarr.Seeders'.tr(),
          body: '${widget.release.seeders}',
        ),
      if (widget.release.leechers != null)
        LunaTableContent(
          title: 'readarr.Leechers'.tr(),
          body: '${widget.release.leechers}',
        ),
    ];
  }

  List<LunaButton> _tableButtons() {
    return [
      LunaButton(
        type: LunaButtonType.TEXT,
        text: 'readarr.Download'.tr(),
        icon: Icons.download_rounded,
        onTap: _startDownload,
        loadingState: _downloadState,
      ),
      if (widget.release.rejected!)
        LunaButton.text(
          text: 'readarr.Rejected'.tr(),
          icon: Icons.report_outlined,
          color: LunaColours.red,
          onTap: _showWarnings,
        ),
    ];
  }

  Future<void> _startDownload() async {
    Future<void> setDownloadState(LunaLoadingState state) async {
      if (this.mounted) setState(() => _downloadState = state);
    }

    setDownloadState(LunaLoadingState.ACTIVE);
    ReadarrAPIController()
        .downloadRelease(
          context: context,
          release: widget.release,
        )
        .whenComplete(() async => setDownloadState(LunaLoadingState.INACTIVE));
  }

  Future<void> _showWarnings() async => await LunaDialogs()
      .showRejections(context, widget.release.rejections ?? []);
}
