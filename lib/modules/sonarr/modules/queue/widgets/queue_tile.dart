import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrQueueQueueTile extends StatefulWidget {
    final SonarrQueueRecord record;

    SonarrQueueQueueTile({
        Key key,
        @required this.record,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrQueueQueueTile> {
    final ExpandableController _controller = ExpandableController();

    @override
    Widget build(BuildContext context) => LSExpandable(
        controller: _controller,
        collapsed: _collapsed(context),
        expanded: _expanded(context),
    );

    Widget _collapsed(BuildContext context) => LSCardTile(
        title: LSTitle(text: widget.record.title),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                    color: Colors.white70,
                ),
                children: [
                    TextSpan(text: widget?.record?.series?.title ?? 'Unknown Series'),
                    TextSpan(text: '\nSeason ${widget.record.episode.seasonNumber} ${Constants.TEXT_EMDASH} Episode ${widget.record.episode.episodeNumber}\n'),
                    TextSpan(
                        text: '${widget.record?.quality?.quality?.name ?? 'Unknown'} ${Constants.TEXT_EMDASH} ${widget.record?.lunaPercentageComplete ?? Constants.TEXT_EMDASH}%',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: LunaColours.accent,
                        ),
                    ),
                ],
            ),
            maxLines: 3,
            overflow: TextOverflow.fade,
            softWrap: false,
        ),
        trailing: Padding(
            child: LSIconButton(icon: widget.record.lunaStatusIcon, color: widget.record.lunaStatusColor),
            padding: EdgeInsets.only(bottom: 14.0),
        ),
        padContent: true,
        onTap: () => _controller.toggle(),
    );

    Widget _expanded(BuildContext context) => LSCard( 
        child: InkWell(
            child: Row(
                children: [
                    Expanded(
                        child: Padding(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    LSTitle(text: widget.record.title, softWrap: true, maxLines: 12),
                                    Padding(
                                        child: Wrap(
                                            direction: Axis.horizontal,
                                            runSpacing: 10.0,
                                            children: [
                                                LSTextHighlighted(
                                                    text: widget.record?.protocol?.lsLanguage_Capitalize() ?? Constants.TEXT_EMDASH,
                                                    bgColor: widget.record.protocol == 'torrent'
                                                        ? LunaColours.purple
                                                        : LunaColours.blue,
                                                ),
                                                LSTextHighlighted(
                                                    text: widget.record?.quality?.quality?.name ?? 'Unknown',
                                                    bgColor: LunaColours.accent,
                                                ),
                                                LSTextHighlighted(
                                                    text: '${widget.record?.lunaPercentageComplete ?? Constants.TEXT_EMDASH}%',
                                                    bgColor: LunaColours.blueGrey,
                                                ),
                                                LSTextHighlighted(
                                                    text: widget.record.lunaStatusText,
                                                    bgColor: LunaColours.blueGrey,
                                                ),
                                            ],
                                        ),
                                        padding: EdgeInsets.only(top: 8.0, bottom: 2.0),
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
                                                        text: '${widget.record.series.title}\n',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: Constants.UI_FONT_SIZE_STICKYHEADER,
                                                            color: Colors.white,
                                                        ),
                                                    ),
                                                    TextSpan(
                                                        text: widget.record.episode.seasonNumber == 0
                                                            ? 'Specials ${Constants.TEXT_EMDASH} Episode ${widget.record.episode.episodeNumber}\n'
                                                            : 'Season ${widget.record.episode.seasonNumber} ${Constants.TEXT_EMDASH} Episode ${widget.record.episode.episodeNumber}\n',
                                                        style: TextStyle(
                                                            color: LunaColours.accent,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: Constants.UI_FONT_SIZE_STICKYHEADER,
                                                        ),
                                                    ),
                                                    TextSpan(
                                                        text: widget.record.episode.airDateUtc == null
                                                            ? 'Unknown Date'
                                                            : DateFormat.yMMMMd().format(widget.record.episode.airDateUtc.toLocal()),
                                                    ),
                                                    TextSpan(text: '\n\n'),
                                                    TextSpan(
                                                        text: widget.record.episode.overview == null || widget.record.episode.overview.isEmpty
                                                            ? 'No overview is available.'
                                                            : widget.record.episode.overview,
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
                                                if(widget.record?.statusMessages != null && (widget.record?.statusMessages?.isNotEmpty ?? false)) Expanded(
                                                    child: LSButtonSlim(
                                                        text: 'Messages',
                                                        backgroundColor: LunaColours.accent,
                                                        onTap: () async => LunaDialogs.textPreview(context, 'Warnings', widget.record.statusMessages.fold('', (warnings, status) {
                                                            warnings += status.messages.fold<String>('', (message, element) => message += '\n${Constants.TEXT_BULLET} $element');
                                                            return warnings.trim();
                                                        })),
                                                        margin: EdgeInsets.only(right: 6.0),
                                                    ),
                                                ),
                                                Expanded(
                                                    child: LSButtonSlim(
                                                        text: 'Delete',
                                                        backgroundColor: LunaColours.red,
                                                        onTap: () async => _deleteQueueRecord(context),
                                                        margin: widget.record?.statusMessages != null && (widget.record?.statusMessages?.isNotEmpty ?? false)
                                                            ? EdgeInsets.only(left: 6.0)
                                                            : EdgeInsets.zero,
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
            onTap: () => _controller.toggle(),
        ),
    );

    Future<void> _deleteQueueRecord(BuildContext context) async {
        List _values = await SonarrDialogs.confirmDeleteQueue(context);
        if(_values[0]) context.read<SonarrState>().api.queue.deleteQueue(
            id: widget.record.id,
            blacklist: context.read<SonarrState>().removeQueueBlacklist,
        ).then((value) {
            context.read<SonarrState>().resetQueue();
            showLunaSuccessSnackBar(context: context, title: 'Removed From Queue', message: widget.record.title);
        })
        .catchError((error, stack) {
            LunaLogger().error('Failed to remove item from queue: ${widget.record.id}', error, stack);
            showLunaErrorSnackBar(context: context, title: 'Failed to Delete From Queue');
        });
    }
}
