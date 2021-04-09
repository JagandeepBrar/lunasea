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
    Widget build(BuildContext context) {
        return ExpandableNotifier(
            controller: _controller,
            child: Expandable(
                collapsed: _collapsed(context),
                expanded: _expanded(context),
            ),
        );
    }

    Widget _collapsed(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: widget.record.title),
            subtitle: RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                        color: Colors.white70,
                    ),
                    children: [
                        TextSpan(text: widget?.record?.series?.title ?? 'Unknown Series'),
                        TextSpan(text: '\nSeason ${widget.record.episode.seasonNumber} ${LunaUI.TEXT_EMDASH} Episode ${widget.record.episode.episodeNumber}\n'),
                        TextSpan(
                            text: '${widget.record?.quality?.quality?.name ?? 'Unknown'} ${LunaUI.TEXT_EMDASH} ${widget.record?.lunaPercentageComplete ?? LunaUI.TEXT_EMDASH}%',
                            style: TextStyle(
                                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
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
                child: LunaIconButton(icon: widget.record.lunaStatusIcon, color: widget.record.lunaStatusColor),
                padding: EdgeInsets.only(bottom: 12.0),
            ),
            contentPadding: true,
            onTap: () => _controller.toggle(),
        );
    }

    Widget _expanded(BuildContext context) {
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
                                            text: widget.record.title,
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
                                            children: [
                                                LunaHighlightedNode(
                                                    text: widget.record?.protocol?.lunaCapitalizeFirstLetters() ?? LunaUI.TEXT_EMDASH,
                                                    backgroundColor: LunaColours.blue,
                                                ),
                                                LunaHighlightedNode(
                                                    text: widget.record?.quality?.quality?.name ?? 'Unknown',
                                                    backgroundColor: LunaColours.accent,
                                                ),
                                                LunaHighlightedNode(
                                                    text: '${widget.record?.lunaPercentageComplete ?? LunaUI.TEXT_EMDASH}%',
                                                    backgroundColor: LunaColours.blueGrey,
                                                ),
                                                LunaHighlightedNode(
                                                    text: widget.record.lunaStatusText,
                                                    backgroundColor: LunaColours.blueGrey,
                                                ),
                                            ],
                                        ),
                                        padding: EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0, top: 0.0),
                                    ),
                                    Padding(
                                        child: RichText(
                                            text: TextSpan(
                                                children: [
                                                    TextSpan(
                                                        text: '${widget.record.series.title}\n',
                                                        style: TextStyle(
                                                            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                                                            fontSize: LunaUI.FONT_SIZE_BUTTON,
                                                            color: Colors.white,
                                                        ),
                                                    ),
                                                    TextSpan(
                                                        text: widget.record.episode.seasonNumber == 0
                                                            ? 'Specials ${LunaUI.TEXT_EMDASH} Episode ${widget.record.episode.episodeNumber}\n'
                                                            : 'Season ${widget.record.episode.seasonNumber} ${LunaUI.TEXT_EMDASH} Episode ${widget.record.episode.episodeNumber}\n',
                                                        style: TextStyle(
                                                            color: LunaColours.accent,
                                                            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                                                            fontSize: LunaUI.FONT_SIZE_BUTTON,
                                                        ),
                                                    ),
                                                    TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.white70,
                                                            fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                                                        ),
                                                        text: widget.record.episode.airDateUtc == null
                                                            ? 'Unknown Date'
                                                            : DateFormat.yMMMMd().format(widget.record.episode.airDateUtc.toLocal()),
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
                                                text: widget.record.episode.overview != null && widget.record.episode.overview.isNotEmpty
                                                    ? widget.record.episode.overview
                                                    : 'No summary is available.',
                                            ),
                                        ),
                                        padding: EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 4.0),
                                    ),
                                    LunaButtonContainer(
                                        padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 6.0),
                                        children: [
                                            if(widget.record.statusMessages != null && widget.record.statusMessages.isNotEmpty) LunaButton.text(
                                                text: 'Messages',
                                                icon: Icons.messenger_outline_rounded,
                                                onTap: () async {
                                                    LunaDialogs().showMessages(
                                                        context,
                                                        widget.record.statusMessages.map<String>((status) => status.messages.join('\n')).toList(),
                                                    );
                                                },
                                            ),
                                            LunaButton.text(
                                                text: 'Remove',
                                                icon: Icons.delete_rounded,
                                                color: LunaColours.red,
                                                onTap: () async => _deleteQueueRecord(),
                                            ),
                                        ],
                                    ),
                                ],
                            ),
                        )
                    ],
                ),
                borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
                onTap: () => _controller.toggle(),
            ),
        );
    }

    Future<void> _deleteQueueRecord() async {
        bool _result = await SonarrDialogs().confirmDeleteQueue(context);
        if(_result) context.read<SonarrState>().api.queue.deleteQueue(
            id: widget.record.id,
            blacklist: context.read<SonarrState>().removeQueueBlacklist,
        ).then((value) {
            context.read<SonarrState>().resetQueue();
            showLunaSuccessSnackBar(title: 'Removed From Queue', message: widget.record.title);
        })
        .catchError((error, stack) {
            LunaLogger().error('Failed to remove item from queue: ${widget.record.id}', error, stack);
            showLunaErrorSnackBar(title: 'Failed to Delete From Queue', error: error);
        });
    }
}
