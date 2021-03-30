import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesReleaseTile extends StatefulWidget {
    final SonarrRelease release;
    final bool isSeasonRelease;

    SonarrReleasesReleaseTile({
        Key key,
        @required this.release,
        @required this.isSeasonRelease,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrReleasesReleaseTile> {
    LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

    @override
    Widget build(BuildContext context) {
        return LunaExpandableListTile(
            title: widget.release.title,
            collapsedSubtitle1: _subtitle1(),
            collapsedSubtitle2: _subtitle2(),
            collapsedTrailing: _trailing(),
            expandedTableButtons: _tableButtons(),
            expandedHighlightedNodes: _highlightedNodes(),
            expandedTableContent: _tableContent(),
        );
    }

    TextSpan _subtitle1() {
        return TextSpan(
            children: [
                TextSpan(
                    style: TextStyle(
                        color: widget.release.lunaProtocolColor,
                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                    ),
                    text: widget.release.protocol.lunaCapitalizeFirstLetters(),
                ),
                if(widget.release.protocol == 'torrent') TextSpan(
                    text: ' (${widget.release.seeders}/${widget.release.leechers})',
                    style: TextStyle(
                        color: widget.release.lunaProtocolColor,
                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                    ),
                ),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                TextSpan(text: widget.release.indexer ?? LunaUI.TEXT_EMDASH),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                TextSpan(text: widget.release?.ageHours?.lunaHoursToAge() ?? LunaUI.TEXT_EMDASH),
            ]
        );
    }

    TextSpan _subtitle2() {
        return TextSpan(
            children: [
                TextSpan(text: widget.release?.quality?.quality?.name ?? LunaUI.TEXT_EMDASH),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                TextSpan(text: widget.release?.size?.lunaBytesToString() ?? LunaUI.TEXT_EMDASH),
            ]
        );
    }

    Widget _trailing() {
        return LunaIconButton(
            icon: widget.release.approved ? Icons.file_download : Icons.report_outlined,
            color: widget.release.approved ? Colors.white : LunaColours.red,
            onPressed: () async => widget.release.rejected ? _showWarnings() : _startDownload(),
            onLongPress: _startDownload,
            loadingState: _loadingState,
        );
    }

    List<LunaButton> _tableButtons() {
        return [
            LunaButton(
                type: LunaButtonType.TEXT,
                text: 'Download',
                icon: Icons.download_rounded,
                onTap: _startDownload,
                loadingState: _loadingState,
            ),
            if(!widget.release.approved) LunaButton.text(
                text: 'Rejected',
                icon: Icons.report_outlined,
                color: LunaColours.red,
                onTap: _showWarnings,
            ),
        ];
    }

    List<LunaTableContent> _tableContent() {
        return [
            LunaTableContent(title: 'source', body: widget.release.protocol.lunaCapitalizeFirstLetters()),
            LunaTableContent(title: 'age', body: widget.release.ageHours?.lunaHoursToAge() ?? LunaUI.TEXT_EMDASH),
            LunaTableContent(title: 'indexer', body: widget.release.indexer ?? LunaUI.TEXT_EMDASH),
            LunaTableContent(title: 'size', body: widget.release.size?.lunaBytesToString() ?? LunaUI.TEXT_EMDASH),
            LunaTableContent(title: 'quality', body: widget.release.quality?.quality?.name ?? LunaUI.TEXT_EMDASH),
            if(widget.release.protocol == 'torrent' && widget.release.seeders != null) LunaTableContent(title: 'seeders', body: '${widget.release.seeders}'),
            if(widget.release.protocol == 'torrent' && widget.release.leechers != null) LunaTableContent(title: 'leechers', body: '${widget.release.leechers}'),
        ];
    }

    List<LunaHighlightedNode> _highlightedNodes() {
        return [
            LunaHighlightedNode(
                text: widget.release.protocol.lunaCapitalizeFirstLetters(),
                backgroundColor: widget.release.lunaProtocolColor,
            ),
        ];
    }

    Future<void> _startDownload() async {
        if(mounted) setState(() => _loadingState = LunaLoadingState.ACTIVE);
        if(context.read<SonarrState>().api != null) await context.read<SonarrState>().api.release.addRelease(
            guid: widget.release.guid,
            indexerId: widget.release.indexerId,
            useVersion3: widget.isSeasonRelease,
        )
        .then((_) => showLunaSuccessSnackBar(
            title: 'Downloading Release...',
            message: widget.release.title,
        ))
        .catchError((error, stack) {
            LunaLogger().error('Unable to download release: ${widget.release.guid}', error, stack);
            showLunaErrorSnackBar(
                title: 'Failed to Download Release',
                error: error,
            );
        });
        if(mounted) setState(() => _loadingState = LunaLoadingState.INACTIVE);
    }

    Future<void> _showWarnings() async => await LunaDialogs().showRejections(context, widget.release.rejections);
}
