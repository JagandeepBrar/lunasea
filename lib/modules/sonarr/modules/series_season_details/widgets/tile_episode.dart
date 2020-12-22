import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesSeasonDetailsEpisodeTile extends StatefulWidget {
    final SonarrEpisode episode;

    SonarrSeriesSeasonDetailsEpisodeTile({
        Key key,
        @required this.episode,
    }) : super(key: key);

    @override
    State<SonarrSeriesSeasonDetailsEpisodeTile> createState() => _State();
}

class _State extends State<SonarrSeriesSeasonDetailsEpisodeTile> {
    final ExpandableController _expandableController = ExpandableController();

    @override
    Widget build(BuildContext context) => LSExpandable(
        controller: _expandableController,
        collapsed: _collapsed,
        expanded: _expanded,
    );

    Widget get _expanded => LSCard(
        child: InkWell(
            child: Row(
                children: [
                    Expanded(
                        child: Padding(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    LSTitle(text: widget.episode.title, softWrap: true, maxLines: 12),
                                    FutureBuilder(
                                        future: context.watch<SonarrState>().queue,
                                        builder: (context, AsyncSnapshot<List<SonarrQueueRecord>> snapshot) {
                                            SonarrQueueRecord _queue = snapshot.hasData
                                                ? snapshot.data.firstWhere(
                                                    (record) => (record?.episode?.id ?? -1) == (widget?.episode?.id ?? -99),
                                                    orElse: () => null,
                                                )
                                                : null;
                                            return Padding(
                                                child: Wrap(
                                                    direction: Axis.horizontal,
                                                    runSpacing: 10.0,
                                                    children: [
                                                        if(!widget.episode.monitored) LSTextHighlighted(
                                                            text: 'Unmonitored',
                                                            bgColor: LunaColours.red,
                                                        ),
                                                        if(_queue != null) LSTextHighlighted(
                                                            text: '${_queue?.quality?.quality?.name ?? 'Unknown'} ${Constants.TEXT_EMDASH} ${_queue.lunaPercentageComplete}%',
                                                            bgColor: LunaColours.purple,
                                                        ),
                                                        if(_queue == null && widget.episode.hasFile) LSTextHighlighted(
                                                            bgColor: widget.episode.episodeFile.qualityCutoffNotMet
                                                                ? LunaColours.orange
                                                                : LunaColours.accent,
                                                            text: [
                                                                widget.episode.episodeFile.quality.quality.name,
                                                                ' ${Constants.TEXT_EMDASH} ',
                                                                widget.episode.episodeFile.size.lunaBytesToString(),
                                                            ].join(),
                                                        ),
                                                        if(_queue == null && !widget.episode.hasFile && (widget.episode?.airDateUtc?.toLocal()?.isAfter(DateTime.now()) ?? true)) LSTextHighlighted(
                                                            bgColor: LunaColours.blue,
                                                            text: 'Unaired',
                                                        ),
                                                        if(_queue == null && !widget.episode.hasFile && (widget.episode?.airDateUtc?.toLocal()?.isBefore(DateTime.now()) ?? false)) LSTextHighlighted(
                                                            bgColor: LunaColours.red,
                                                            text: 'Missing',
                                                        ),
                                                    ],
                                                ),
                                                padding: EdgeInsets.only(top: 8.0, bottom: 2.0),
                                            );
                                        },
                                    ),
                                    Padding(
                                        child: RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                                ),
                                                children: [
                                                    TextSpan(
                                                        text: widget.episode.seasonNumber == 0
                                                            ? 'Specials ${Constants.TEXT_EMDASH} Episode ${widget.episode.episodeNumber}\n'
                                                            : 'Season ${widget.episode.seasonNumber} ${Constants.TEXT_EMDASH} Episode ${widget.episode.episodeNumber}\n',
                                                        style: TextStyle(
                                                            color: LunaColours.accent,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: Constants.UI_FONT_SIZE_STICKYHEADER,
                                                        ),
                                                    ),
                                                    TextSpan(
                                                        text: widget.episode.airDateUtc == null
                                                            ? 'Unknown Date'
                                                            : DateFormat.yMMMMd().format(widget.episode.airDateUtc.toLocal()),
                                                    ),
                                                    TextSpan(text: '\n\n'),
                                                    TextSpan(
                                                        text: widget.episode.overview == null || widget.episode.overview.isEmpty
                                                            ? 'No overview is available.'
                                                            : widget.episode.overview,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle.italic,
                                                        ),
                                                    )
                                                ],
                                            ),
                                        ),
                                        padding: EdgeInsets.only(top: 6.0, bottom: 10.0),
                                    ),
                                    Padding(
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                Expanded(
                                                    child: LSButtonSlim(
                                                        text: 'Automatic',
                                                        onTap: _automaticSearch,
                                                        margin: EdgeInsets.only(right: 6.0),
                                                    ),
                                                ),
                                                Expanded(
                                                    child: LSButtonSlim(
                                                        text: 'Interactive',
                                                        backgroundColor: LunaColours.orange,
                                                        onTap: _interactiveSearch,
                                                        margin: EdgeInsets.only(left: 6.0),
                                                    ),
                                                ),
                                            ],
                                        ),
                                        padding: EdgeInsets.only(bottom: 2.0),
                                    ),
                                ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                        ),
                    )
                ],
            ),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            onTap: () => _expandableController.toggle(),
            onLongPress: () => _handleEpisodeSettings(),
        ),
        color: context.watch<SonarrState>().selectedEpisodes.contains(widget.episode.id)
            ? LunaColours.accent.withOpacity(0.15)
            : LunaDatabaseValue.THEME_AMOLED.data ? Colors.black : LunaColours.secondary,
    );
    
    
    Widget get _collapsed => LSCardTile(
        title: LSTitle(text: widget.episode.title, darken: !widget.episode.monitored),
        subtitle: _subtitle,
        leading: _leading,
        trailing: _trailing,
        padContent: true,
        onTap: () => _expandableController.toggle(),
        onLongPress: () async => _handleEpisodeSettings(),
        color: context.watch<SonarrState>().selectedEpisodes.contains(widget.episode.id)
            ? LunaColours.accent.withOpacity(0.15)
            : LunaDatabaseValue.THEME_AMOLED.data ? Colors.black : LunaColours.secondary,
    );

    Widget get _subtitle => FutureBuilder(
        future: context.watch<SonarrState>().queue,
        builder: (context, AsyncSnapshot<List<SonarrQueueRecord>> snapshot) {
            SonarrQueueRecord _queue = snapshot.hasData
                ? snapshot.data.firstWhere(
                    (record) => (record?.episode?.id ?? -1) == (widget?.episode?.id ?? -99),
                    orElse: () => null,
                )
                : null;
            return RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        color: widget.episode.monitored ? Colors.white70 : Colors.white30,
                    ),
                    children: [
                        TextSpan(
                            text: widget.episode.airDateUtc == null
                                ? 'Unknown Date'
                                : DateFormat.yMMMMd().format(widget.episode.airDateUtc.toLocal()),
                        ),
                        TextSpan(text: '\n'),
                        if(_queue != null) TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: LunaColours.purple,
                            ),
                            children: [
                                TextSpan(text: _queue?.quality?.quality?.name ?? 'Unknown'),
                                TextSpan(text: ' ${Constants.TEXT_EMDASH} '),
                                TextSpan(text: '${_queue.lunaPercentageComplete}%'),
                            ],
                        ),
                        if(_queue == null && widget.episode.hasFile) TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: widget.episode.episodeFile.qualityCutoffNotMet
                                    ? widget.episode.monitored ? LunaColours.orange : LunaColours.orange.withOpacity(0.30)
                                    : widget.episode.monitored ? LunaColours.accent : LunaColours.accent.withOpacity(0.30),
                            ),
                            children: [
                                TextSpan(text: widget.episode.episodeFile.quality.quality.name),
                                TextSpan(text: ' ${Constants.TEXT_EMDASH} '),
                                TextSpan(text: widget.episode.episodeFile.size.lunaBytesToString()),
                            ],
                        ),
                        if(_queue == null && !widget.episode.hasFile && (widget.episode?.airDateUtc?.toLocal()?.isAfter(DateTime.now()) ?? true)) TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: widget.episode.monitored ? LunaColours.blue : LunaColours.blue.withOpacity(0.30),
                            ),
                            text: 'Unaired',
                        ),
                        if(_queue == null && !widget.episode.hasFile && (widget.episode?.airDateUtc?.toLocal()?.isBefore(DateTime.now()) ?? false)) TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: widget.episode.monitored ? LunaColours.red : LunaColours.red.withOpacity(0.30),
                            ),
                            text: 'Missing',
                        ),
                    ],
                ),
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 2,
            );
        },
    );

    Widget get _leading => IconButton(
        icon: context.watch<SonarrState>().selectedEpisodes.contains(widget.episode.id)
            ? LSIcon(icon: Icons.check)
            : Text(
                '${widget.episode.episodeNumber}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: widget.episode.monitored
                        ? Colors.white
                        : Colors.white30,
                    fontWeight: FontWeight.w600,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
            ),
        onPressed: () => context.read<SonarrState>().toggleSelectedEpisode(widget.episode.id),
    );

    Widget get _trailing => LSIconButton(
        icon: Icons.search,
        color: widget.episode.monitored
            ? Colors.white
            : Colors.white30,
        onPressed: _automaticSearch,
        onLongPress: _interactiveSearch,
    );

    Future<void> _automaticSearch() async {
        Provider.of<SonarrState>(context, listen: false).api.command.episodeSearch(episodeIds: [widget.episode.id])
        .then((_) => LSSnackBar(
            context: context,
            title: 'Searching for Episode...',
            message: widget.episode.title,
            type: SNACKBAR_TYPE.success,
        ))
        .catchError((error, stack) {
            LunaLogger().error('Failed to search for episode: ${widget.episode.id}', error, stack);
            LSSnackBar(
                context: context,
                title: 'Failed to Search',
                type: SNACKBAR_TYPE.failure,
            );
        });
    }

    Future<void> _interactiveSearch() async => SonarrReleasesRouter.navigateTo(
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
            LSSnackBar(
                context: context,
                title: 'Deleted Episode File',
                message: widget.episode.title,
                type: SNACKBAR_TYPE.success,
            );
        })
        .catchError((error, stack) {
            LunaLogger().error('Failed to delete episode file: ${widget.episode.episodeFileId}', error, stack);
            LSSnackBar(
                context: context,
                title: 'Failed to Delete Episode File',
                type: SNACKBAR_TYPE.failure,
            );
        });
    }

    Future<void> _handleToggleMonitored() async {
        SonarrEpisode _episode = widget.episode.clone();
        _episode.monitored = !_episode.monitored;
        if(context.read<SonarrState>().api != null) context.read<SonarrState>().api.episode.updateEpisode(episode: _episode)
        .then((_) {
            setState(() => widget.episode.monitored = _episode.monitored);
            LSSnackBar(
                context: context,
                title: _episode.monitored
                    ? 'Monitoring'
                    : 'No Longer Monitoring',
                message: _episode.title,
                type: SNACKBAR_TYPE.success,
            );
        })
        .catchError((error, stack) {
            LunaLogger().error('Failed to set episode monitored state: ${_episode.id}, ${_episode.monitored}', error, stack);
            LSSnackBar(
                context: context,
                title: _episode.monitored
                    ? 'Failed to Start Monitoring'
                    : 'Failed to Stop Monitoring',
                type: SNACKBAR_TYPE.failure,
            );
        });
    }
}
