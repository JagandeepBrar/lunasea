import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrHistoryTile extends StatefulWidget {
    final SonarrHistoryRecord record;

    SonarrHistoryTile({
        Key key,
        @required this.record,
    }) : super(key: key);

    @override
    State<SonarrHistoryTile> createState() => _State();
}

class _State extends State<SonarrHistoryTile> {
    final double _height = 90.0;
    final double _padding = 8.0;

    @override
    Widget build(BuildContext context) {
        return LunaCard(
            context: context,
            child: InkWell(
                child: Row(
                    children: [
                        Expanded(child: _information),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                ),
                onTap: _onTap,
                borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
            ),
        );
    }

    Widget get _information => Padding(
        child: Container(
            child: Column(
                children: [
                    LunaText.title(text: widget.record.series.title, maxLines: 1),
                    _subtitleOne,
                    _subtitleTwo,
                    _subtitleThree,
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
            ),
            height: (_height-(_padding*2)),
        ),
        padding: EdgeInsets.symmetric(vertical: _padding, horizontal: _padding+4.0),
    );

    Widget get _subtitleOne => RichText(
        text: TextSpan(
            style: TextStyle(
                fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                color: Colors.white70,
            ),
            children: [
                TextSpan(text: 'Season ${widget.record.episode.seasonNumber}'),
                TextSpan(text: ' ${LunaUI.TEXT_EMDASH} '),
                TextSpan(text: 'Episode ${widget.record.episode.episodeNumber}'),
            ],
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: 1,
    );

    Widget get _subtitleTwo => RichText(
        text: TextSpan(
            style: TextStyle(
                fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                color: Colors.white70,
            ),
            children: [
                TextSpan(text: widget.record.date?.lunaAge ?? 'Unknown'),
            ],
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: 1,
    );

    Widget get _subtitleThree => RichText(
        text: TextSpan(
            style: TextStyle(
                fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                color: widget.record.eventType.lunaColour,
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            ),
            text: widget.record.eventType.lunaMessage(widget.record),
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: 1,
    );

    TextSpan get seasonEpisode => TextSpan(
        text: 'Season ${widget.record.episode.seasonNumber} Episode ${widget.record.episode.episodeNumber}',
    );


    Future<void> _onTap() async =>  SonarrSeriesDetailsRouter().navigateTo(
        context,
        seriesId: widget.record.seriesId,
    );
}
