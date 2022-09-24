import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrReleasesTile extends StatefulWidget {
  final RadarrRelease release;

  const RadarrReleasesTile({
    required this.release,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrReleasesTile> {
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
            color: widget.release.lunaProtocolColor,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        TextSpan(text: widget.release.lunaIndexer),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        TextSpan(text: widget.release.lunaAge),
      ],
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        TextSpan(text: widget.release.lunaQuality),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        TextSpan(text: widget.release.lunaSize),
      ],
    );
  }

  List<LunaHighlightedNode> _highlightedNodes() {
    return [
      LunaHighlightedNode(
        text: widget.release.protocol!.readable!,
        backgroundColor: widget.release.lunaProtocolColor,
      ),
      if (widget.release.lunaCustomFormatScore(nullOnEmpty: true) != null)
        LunaHighlightedNode(
          text: widget.release.lunaCustomFormatScore()!,
          backgroundColor: LunaColours.purple,
        ),
      ...widget.release.customFormats!.map<LunaHighlightedNode>((custom) =>
          LunaHighlightedNode(
              text: custom.name!, backgroundColor: LunaColours.blueGrey)),
    ];
  }

  List<LunaTableContent> _tableContent() {
    return [
      LunaTableContent(title: 'age', body: widget.release.lunaAge),
      LunaTableContent(title: 'indexer', body: widget.release.lunaIndexer),
      LunaTableContent(title: 'size', body: widget.release.lunaSize),
      LunaTableContent(
          title: 'language',
          body: widget.release.languages
                  ?.map<String>(
                      (language) => language.name ?? LunaUI.TEXT_EMDASH)
                  .join('\n') ??
              LunaUI.TEXT_EMDASH),
      LunaTableContent(title: 'quality', body: widget.release.lunaQuality),
      if (widget.release.seeders != null)
        LunaTableContent(title: 'seeders', body: '${widget.release.seeders}'),
      if (widget.release.leechers != null)
        LunaTableContent(title: 'leechers', body: '${widget.release.leechers}'),
    ];
  }

  List<LunaButton> _tableButtons() {
    return [
      LunaButton(
        type: LunaButtonType.TEXT,
        text: 'Download',
        icon: Icons.download_rounded,
        onTap: _startDownload,
        loadingState: _downloadState,
      ),
      if (widget.release.infoUrl?.isNotEmpty ?? false)
        LunaButton.text(
          text: 'Indexer',
          icon: Icons.info_outline_rounded,
          color: LunaColours.blue,
          onTap: widget.release.infoUrl!.openLink,
        ),
      if (widget.release.rejected!)
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
    RadarrAPIHelper()
        .pushRelease(context: context, release: widget.release)
        .then((value) {
      if (mounted)
        setState(() => _downloadState =
            value ? LunaLoadingState.INACTIVE : LunaLoadingState.ERROR);
    });
  }

  Future<void> _showWarnings() async => await LunaDialogs()
      .showRejections(context, widget.release.rejections ?? []);
}
