import 'package:expandable/expandable.dart';
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
    final ExpandableController _controller = ExpandableController();

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
                return ExpandableNotifier(
                    controller: _controller,
                    child: Expandable(
                        collapsed: _collapsed(queue),
                        expanded: _expanded(queue),
                    ),
                );
            },
        );
    }

    Widget _collapsed(SonarrQueueRecord queue) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: widget.episode.title),
            subtitle: RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                        color: Colors.white70,
                    ),
                    children: [
                        _subtitle1(),
                        TextSpan(text: '\n'),
                        _subtitle2(queue),
                    ],
                ),
                maxLines: 2,
                overflow: TextOverflow.fade,
                softWrap: false,
            ),
            leading: _leading(),
            trailing: _trailing(),
            contentPadding: true,
            onTap: _controller.toggle,
            onLongPress: _handleEpisodeSettings,
            color: context.watch<SonarrState>().selectedEpisodes.contains(widget.episode.id)
                ? LunaColours.accent.withOpacity(0.15)
                : null,
        );
    }

    Widget _expanded(SonarrQueueRecord queue) {
        return LunaCard(
            context: context,
            child: InkWell(
                child: Row(
                    children: [
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Padding(
                                        child: LunaText.title(
                                            text: widget.episode.title,
                                            softWrap: true,
                                            maxLines: 12,
                                        ),
                                        padding: EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0, top: 10.0),
                                    ),
                                    Padding(
                                        child: Wrap(
                                            direction: Axis.horizontal,
                                            spacing: 6.0,
                                            runSpacing: 6.0,
                                            children: _highlightedNodes(queue),
                                        ),
                                        padding: EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0, top: 0.0),
                                    ),
                                    Padding(
                                        child: RichText(
                                            text: TextSpan(
                                                children: [
                                                    TextSpan(
                                                        text: widget.episode.seasonNumber == 0
                                                            ? 'Specials ${LunaUI.TEXT_EMDASH} Episode ${widget.episode.episodeNumber}'
                                                            : 'Season ${widget.episode.seasonNumber} ${LunaUI.TEXT_EMDASH} Episode ${widget.episode.episodeNumber}',
                                                        style: TextStyle(
                                                            color: LunaColours.accent,
                                                            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                                                            fontSize: LunaUI.FONT_SIZE_BUTTON,
                                                        ),
                                                    ),
                                                    TextSpan(text: '\n'),
                                                    TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.white70,
                                                            fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                                                        ),
                                                        text: widget.episode.airDateUtc == null
                                                            ? 'Unknown Date'
                                                            : DateFormat.yMMMMd().format(widget.episode.airDateUtc.toLocal()),
                                                    ),
                                                ],
                                            ),
                                        ),
                                        padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 4.0),
                                    ),
                                    Padding(
                                        child: RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                                                    fontStyle: FontStyle.italic,
                                                ),
                                                text: widget.episode.overview != null && widget.episode.overview.isNotEmpty
                                                    ? widget.episode.overview
                                                    : 'No summary is available.',
                                            ),
                                        ),
                                        padding: EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 4.0),
                                    ),
                                    LunaButtonContainer(
                                        padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 6.0),
                                        children: _buttons(),
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
                borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
                onTap: _controller.toggle,
                onLongPress: _handleEpisodeSettings,
            ),
            color: context.watch<SonarrState>().selectedEpisodes.contains(widget.episode.id)
                ? LunaColours.accent.withOpacity(0.15)
                : null,
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
                        TextSpan(text: LunaUI.TEXT_EMDASH.lunaPad()),
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
                        TextSpan(text: LunaUI.TEXT_EMDASH.lunaPad()),
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
            if(queue == null && widget.episode.hasFile) LunaHighlightedNode(
                backgroundColor: LunaColours.blueGrey,
                text: widget.episode.episodeFile.size?.lunaBytesToString() ?? LunaUI.TEXT_EMDASH,
            ),
            if(queue == null && !widget.episode.hasFile && (widget.episode?.airDateUtc?.toLocal()?.isAfter(DateTime.now()) ?? true)) LunaHighlightedNode(
                backgroundColor: LunaColours.blue,
                text: 'Unaired',
            ),
            if(queue == null && !widget.episode.hasFile && (widget.episode?.airDateUtc?.toLocal()?.isBefore(DateTime.now()) ?? false)) LunaHighlightedNode(
                backgroundColor: LunaColours.red,
                text: 'Missing',
            ),
        ];
    }

    List<LunaButton> _buttons() {
        return [
            LunaButton.text(
                text: 'Automatic',
                icon: Icons.search_rounded,
                onTap: _automaticSearch,
            ),
            LunaButton.text(
                text: 'Interactive',
                icon: Icons.person_rounded,
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
