import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeasonDetailsEpisodeTile extends StatefulWidget {
    final SonarrEpisode episode;

    SonarrSeasonDetailsEpisodeTile({
        Key key,
        @required this.episode,
    }) : super(key: key);

    @override
    State<SonarrSeasonDetailsEpisodeTile> createState() => _State();
}

class _State extends State<SonarrSeasonDetailsEpisodeTile> {
    @override
    Widget build(BuildContext context) {
        return FutureBuilder(
            future: context.select<SonarrState, Future<List<SonarrQueueRecord>>>((state) => state.queue),
            builder: (context, snapshot) {
                SonarrQueueRecord queue;
                if(snapshot.hasData) queue = snapshot.data.firstWhere(
                    (record) => (record?.episode?.id ?? -1) == (widget?.episode?.id ?? -99),
                    orElse: () => null,
                );
                return LunaExpandableListTile(
                    title: widget.episode.title,
                    collapsedSubtitle1: _subtitle1(),
                    collapsedSubtitle2: _subtitle2(queue),
                    collapsedTrailing: _trailing(),
                    collapsedLeading: _leading(),
                    expandedTableContent: _tableContent(queue),
                    expandedHighlightedNodes: _highlightedNodes(queue),
                    expandedTableButtons: _tableButtons(),
                    onLongPress: () async => _handleEpisodeSettings(),
                    backgroundColor: context.watch<SonarrState>().selectedEpisodes.contains(widget.episode.id)
                        ? LunaColours.accent.withOpacity(0.15)
                        : null,
                );
            },
        );
    }

    TextSpan _subtitle1() {
        return TextSpan(text: widget.episode.airDateUtc == null
            ? 'Unknown Date'
            : DateFormat.yMMMMd().format(widget.episode.airDateUtc.toLocal()),
        );
    }

    TextSpan _subtitle2(SonarrQueueRecord queue) {
        return TextSpan(
            children: [
                if(queue != null) TextSpan(
                    style: TextStyle(
                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                        color: LunaColours.purple,
                    ),
                    children: [
                        TextSpan(text: queue?.quality?.quality?.name ?? LunaUI.TEXT_EMDASH),
                        TextSpan(text: Constants.TEXT_EMDASH.lunaPad()),
                        TextSpan(text: '${queue.lunaPercentageComplete}%'),
                    ],
                ),
                if(queue == null && widget.episode.hasFile) TextSpan(
                    style: TextStyle(
                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                        color: widget.episode.episodeFile.qualityCutoffNotMet
                            ? widget.episode.monitored ? LunaColours.orange : LunaColours.orange.withOpacity(0.30)
                            : widget.episode.monitored ? LunaColours.accent : LunaColours.accent.withOpacity(0.30),
                    ),
                    children: [
                        TextSpan(text: widget.episode.episodeFile.quality.quality.name),
                        TextSpan(text: Constants.TEXT_EMDASH.lunaPad()),
                        TextSpan(text: widget.episode.episodeFile.size.lunaBytesToString()),
                    ],
                ),
                if(queue == null && !widget.episode.hasFile && (widget.episode?.airDateUtc?.toLocal()?.isAfter(DateTime.now()) ?? true)) TextSpan(
                    style: TextStyle(
                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                        color: widget.episode.monitored ? LunaColours.blue : LunaColours.blue.withOpacity(0.30),
                    ),
                    text: 'Unaired',
                ),
                if(queue == null && !widget.episode.hasFile && (widget.episode?.airDateUtc?.toLocal()?.isBefore(DateTime.now()) ?? false)) TextSpan(
                    style: TextStyle(
                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                        color: widget.episode.monitored ? LunaColours.red : LunaColours.red.withOpacity(0.30),
                    ),
                    text: 'Missing',
                ),
            ],
        );
    }

    List<LunaTableContent> _tableContent(SonarrQueueRecord queue) {
        return [
            LunaTableContent(
                title: 'air date',
                body: widget.episode.airDateUtc == null
                    ? 'Unknown Date'
                    : DateFormat.yMMMMd().format(widget.episode.airDateUtc.toLocal()),
            ),
            if(widget.episode.hasFile) LunaTableContent(title: 'size', body: widget.episode.episodeFile.size?.lunaBytesToString() ?? LunaUI.TEXT_EMDASH),
            LunaTableContent(
                title: 'overview',
                body: widget.episode.overview == null || widget.episode.overview.isEmpty
                    ? LunaUI.TEXT_EMDASH
                    : widget.episode.overview,
            ),
        ];
    }

    List<LunaHighlightedNode> _highlightedNodes(SonarrQueueRecord queue) {
        return [
            if(!widget.episode.monitored) LunaHighlightedNode(
                text: 'Unmonitored',
                backgroundColor: LunaColours.red,
            ),
            if(queue != null) LunaHighlightedNode(
                text: '${queue?.quality?.quality?.name ?? LunaUI.TEXT_EMDASH} ${LunaUI.TEXT_EMDASH} ${queue.lunaPercentageComplete}%',
                backgroundColor: LunaColours.purple,
            ),
            if(queue == null && widget.episode.hasFile) LunaHighlightedNode(
                backgroundColor: widget.episode.episodeFile.qualityCutoffNotMet ? LunaColours.orange : LunaColours.accent,
                text: widget.episode.episodeFile.quality?.quality?.name ?? LunaUI.TEXT_EMDASH,
            ),
            if(queue == null && !widget.episode.hasFile && (widget.episode?.airDateUtc?.toLocal()?.isAfter(DateTime.now()) ?? true)) LunaHighlightedNode(
                backgroundColor: LunaColours.blue,
                text: 'Unaired',
            ),
            if(queue == null && !widget.episode.hasFile && (widget.episode?.airDateUtc?.toLocal()?.isBefore(DateTime.now()) ?? false)) LunaHighlightedNode(
                backgroundColor: LunaColours.red,
                text: 'Missing',
            ),
            LunaHighlightedNode(
                text: widget.episode.seasonNumber == 0 ? 'Specials' : 'Season ${widget.episode.seasonNumber}',
                backgroundColor: LunaColours.blueGrey,
            ),
            LunaHighlightedNode(
                text: 'Episode ${widget.episode.episodeNumber}',
                backgroundColor: LunaColours.blueGrey,
            ),
        ];
    }

    List<LunaButton> _tableButtons() {
        return [
            LunaButton.text(
                text: 'Automatic',
                onTap: _automaticSearch,
            ),
            LunaButton.text(
                text: 'Interactive',
                backgroundColor: LunaColours.orange,
                onTap: _interactiveSearch,
            ),
        ];
    }

    Widget _leading() {
        return IconButton(
            icon: context.watch<SonarrState>().selectedEpisodes.contains(widget.episode.id)
                ? Icon(Icons.check)
                : Text(
                    widget.episode.episodeNumber?.toString() ?? LunaUI.TEXT_EMDASH,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: widget.episode.monitored ? Colors.white : Colors.white30,
                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                        fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                    ),
                ),
            onPressed: () => context.read<SonarrState>().toggleSelectedEpisode(widget.episode.id),
        );
    }

    Widget _trailing() {
        return LunaIconButton(
            icon: Icons.search,
            color: widget.episode.monitored ? Colors.white : Colors.white30,
            onPressed: _automaticSearch,
            onLongPress: _interactiveSearch,
        );
    }

    Future<void> _automaticSearch() async {
        Provider.of<SonarrState>(context, listen: false).api.command.episodeSearch(episodeIds: [widget.episode.id])
        .then((_) => showLunaSuccessSnackBar(
            title: 'Searching for Episode...',
            message: widget.episode.title,
        ))
        .catchError((error, stack) {
            LunaLogger().error('Failed to search for episode: ${widget.episode.id}', error, stack);
            showLunaErrorSnackBar(
                title: 'Failed to Search',
                error: error,
            );
        });
    }

    Future<void> _interactiveSearch() async => SonarrReleasesRouter().navigateTo(
        context,
        episodeId: widget.episode.id,
    );

    Future<void> _handleEpisodeSettings() async {
        List _values = await SonarrDialogs.episodeSettings(context, widget.episode);
        if(_values[0]) switch((_values[1] as SonarrEpisodeSettingsType)) {
            case SonarrEpisodeSettingsType.MONITORED: _handleToggleMonitored(); break;
            case SonarrEpisodeSettingsType.AUTOMATIC_SEARCH: _automaticSearch(); break;
            case SonarrEpisodeSettingsType.INTERACTIVE_SEARCH: _interactiveSearch(); break;
            case SonarrEpisodeSettingsType.DELETE_FILE: _handleDeleteFile(); break;
        }
    }

    Future<void> _handleDeleteFile() async {
        List _values = await SonarrDialogs.confirmDeleteEpisodeFile(context);
        if(_values[0] && context.read<SonarrState>().api != null) context.read<SonarrState>().api.episodeFile.deleteEpisodeFile(
            episodeFileId: widget.episode.episodeFileId,
        ).then((_) {
            setState(() => widget.episode.hasFile = false);
            showLunaSuccessSnackBar(
                title: 'Deleted Episode File',
                message: widget.episode.title,
            );
        })
        .catchError((error, stack) {
            LunaLogger().error('Failed to delete episode file: ${widget.episode.episodeFileId}', error, stack);
            showLunaErrorSnackBar(
                title: 'Failed to Delete Episode File',
                error: error,
            );
        });
    }

    Future<void> _handleToggleMonitored() async {
        SonarrEpisode _episode = widget.episode.clone();
        _episode.monitored = !_episode.monitored;
        if(context.read<SonarrState>().api != null) context.read<SonarrState>().api.episode.updateEpisode(episode: _episode)
        .then((_) {
            setState(() => widget.episode.monitored = _episode.monitored);
            showLunaSuccessSnackBar(
                title: _episode.monitored ? 'Monitoring' : 'No Longer Monitoring',
                message: _episode.title,
            );
        })
        .catchError((error, stack) {
            LunaLogger().error('Failed to set episode monitored state: ${_episode.id}, ${_episode.monitored}', error, stack);
            showLunaErrorSnackBar(
                title: _episode.monitored ? 'Failed to Start Monitoring' : 'Failed to Stop Monitoring',
                error: error,
            );
        });
    }
}
