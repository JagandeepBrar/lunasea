import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrHistoryTile extends StatefulWidget {
    final RadarrHistoryRecord history;
    final bool movieHistory;
    final String title;

    /// If [movieHistory] is false (default), you must supply a title or else a dash will be shown.
    RadarrHistoryTile({
        Key key,
        @required this.history,
        this.movieHistory = false,
        this.title = Constants.TEXT_EMDASH,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrHistoryTile> {
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
                                    Padding(
                                        child: LunaText.title(
                                            text: widget.movieHistory ? widget.history.sourceTitle : widget.title,
                                            softWrap: true,
                                            maxLines: 12,
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                                    ),
                                    Padding(
                                        child: Wrap(
                                            direction: Axis.horizontal,
                                            runSpacing: 10.0,
                                            children: [
                                                LSTextHighlighted(
                                                    text: widget.history.eventType?.readable,
                                                    bgColor: widget.history.eventType?.lunaColour,
                                                ),
                                                ...widget.history.customFormats.map<LSTextHighlighted>((format) => LSTextHighlighted(
                                                    text: format.name,
                                                    bgColor: LunaColours.blueGrey,
                                                )),
                                            ],
                                        ),
                                        padding: EdgeInsets.only(top: 8.0, bottom: 2.0, left: 12.0, right: 12.0),
                                    ),
                                    Padding(
                                        child: Column(
                                            children: widget.history.eventType?.lunaTableContent(widget.history, movieHistory: widget.movieHistory) ?? [],
                                        ),
                                        padding: EdgeInsets.only(top: 6.0, bottom: 0.0),
                                    ),
                                ],
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                    )
                ],
            ),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            onTap: () => _expandableController.toggle(),
            onLongPress: widget.movieHistory ? null : () async => RadarrMoviesDetailsRouter().navigateTo(context, movieId: widget.history?.movieId ?? -1),
        ),
    );
    
    Widget get _collapsed => LSCardTile(
        title: LunaText.title(text: widget.movieHistory ? widget.history.sourceTitle : widget.title),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                    color: Colors.white70,
                ),
                children: [
                    TextSpan(
                        text: [
                            widget.history?.date?.lunaAge ?? Constants.TEXT_EMDASH,
                            widget.history?.date?.lunaDateTimeReadable() ?? Constants.TEXT_EMDASH,
                        ].join(' ${Constants.TEXT_BULLET} '),
                    ),
                    TextSpan(text: '\n'),
                    TextSpan(
                        text: widget.history?.eventType?.lunaReadable(widget.history) ?? Constants.TEXT_EMDASH,
                        style: TextStyle(
                            color: widget.history?.eventType?.lunaColour ?? LunaColours.blueGrey,
                            fontWeight: FontWeight.w600,
                        ),
                    ),
                ],
            ),
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 2,
        ),
        padContent: true,
        onTap: () => _expandableController.toggle(),
        onLongPress: widget.movieHistory ? null : () async => RadarrMoviesDetailsRouter().navigateTo(context, movieId: widget.history?.movieId ?? -1),
    );
}
