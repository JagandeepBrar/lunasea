import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsSeasonTile extends StatefulWidget {
    final SonarrSeriesSeason season;

    SonarrSeriesDetailsSeasonTile({
        Key key,
        @required this.season,
    }) : super(key: key);

    @override
    State<SonarrSeriesDetailsSeasonTile> createState() => _State();
}

class _State extends State<SonarrSeriesDetailsSeasonTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: widget.season.seasonNumber == 0 ? 'Specials' : 'Season ${widget.season.seasonNumber}', darken: !widget.season.monitored),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: widget.season.monitored ? Colors.white70 : Colors.white30,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: [
                    TextSpan(text: widget.season.statistics.sizeOnDisk.lsBytes_BytesToString(decimals: 1)),
                    TextSpan(text: '\n'),
                    TextSpan(
                        style: TextStyle(
                            color: widget.season.lunaPercentageComplete == 100
                                ? widget.season.monitored ? LunaColours.accent : LunaColours.accent.withOpacity(0.30)
                                : widget.season.monitored ? LunaColours.red : LunaColours.red.withOpacity(0.30),
                            fontWeight: FontWeight.w600,
                        ),
                        text: '${widget.season.lunaPercentageComplete}% ${Constants.TEXT_EMDASH} ${widget.season.statistics.episodeFileCount ?? 0}/${widget.season.statistics.totalEpisodeCount ?? 0} Episodes Available',
                    ),
                ],
            ),
        ),
        trailing: _trailing(context),
        padContent: true,
    );

    Widget _trailing(BuildContext context) => LSIconButton(
        icon: widget.season.monitored ? Icons.turned_in : Icons.turned_in_not,
        color: widget.season.monitored ? Colors.white : Colors.white30,
        onPressed: () async {
            setState(() => widget.season.monitored = !widget.season.monitored);
        },
    );
}
