import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrReleasesTile extends StatefulWidget {
    final RadarrRelease release;
    
    RadarrReleasesTile({
        @required this.release,
        Key key,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrReleasesTile> {
    LunaLoadingState _downloadState = LunaLoadingState.INACTIVE;

    @override
    Widget build(BuildContext context) => LunaExpandableListTile(
        title: widget.release.title,
        collapsedSubtitle1: _subtitle1(),
        collapsedSubtitle2: _subtitle2(),
        collapsedTrailing: _trailing(),
        expandedHighlightedNodes: _highlightedNodes(),
        expandedTableContent: _tableContent(),
        expandedTableButtons: _tableButtons(),
    );

    Widget _trailing() {
        return LunaIconButton(
            icon: widget.release.lunaTrailingIcon,
            color: widget.release.lunaTrailingColor,
            onPressed: () async => widget.release.rejected ? _showWarnings() : _startDownload(),
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
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                TextSpan(text: widget.release.lunaIndexer),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                TextSpan(text: widget.release.lunaAge),
            ],
        );
    }

    TextSpan _subtitle2() {
        return TextSpan(
            children: [
                TextSpan(text: widget.release.lunaQuality),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                TextSpan(text: widget.release.lunaSize),
            ],
        );
    }

    List<LunaHighlightedNode> _highlightedNodes() {
        return [
            LunaHighlightedNode(
                text: widget.release.lunaProtocol,
                backgroundColor: widget.release.lunaProtocolColor,
            ),
            if((widget.release.customFormatScore ?? 0) > 0) LunaHighlightedNode(text: '+${widget.release.customFormatScore}', backgroundColor: LunaColours.orange),
            ...widget.release.customFormats.map<LunaHighlightedNode>((custom) => LunaHighlightedNode(text: custom.name, backgroundColor: LunaColours.blueGrey)),
        ];
    }

    List<LunaTableContent> _tableContent() {
        return [
            LunaTableContent(title: 'source', body: widget.release.lunaProtocol),
            LunaTableContent(title: 'age', body: widget.release.lunaAge),
            LunaTableContent(title: 'indexer', body: widget.release.lunaIndexer),
            LunaTableContent(title: 'size', body: widget.release.lunaSize),
            LunaTableContent(title: 'language', body: widget.release.languages?.map<String>((language) => language?.name ?? LunaUI.TEXT_EMDASH)?.join('\n') ?? LunaUI.TEXT_EMDASH),
            LunaTableContent(title: 'quality', body: widget.release.lunaQuality),
        ];
    }

    List<LunaButton> _tableButtons() {
        return [
            LunaButton.slim(
                text: 'Download',
                onTap: _startDownload,
                loadingState: _downloadState,
            ),
            if(widget.release.rejected) LunaButton.slim(
                text: 'Rejected',
                backgroundColor: LunaColours.red,
                onTap: _showWarnings,
            ),
        ];
    }

    Future<void> _startDownload() async {
        setState(() => _downloadState = LunaLoadingState.ACTIVE);
        RadarrAPIHelper().pushRelease(context: context, release: widget.release)
        .then((value) {
            if(mounted) setState(() => _downloadState = value ? LunaLoadingState.INACTIVE : LunaLoadingState.ERROR);
        });
    }

    Future<void> _showWarnings() async {
        String rejections = '';
        for(var i=0; i<widget.release.rejections.length; i++) {
            rejections += '${i+1}. ${widget.release.rejections[i]}\n';
        }
        await LunaDialogs().textPreview(context, 'Rejection Reasons', rejections.trim());
    }
}
