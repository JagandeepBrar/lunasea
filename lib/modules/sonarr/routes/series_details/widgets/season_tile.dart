import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsSeasonTile extends StatefulWidget {
    final SonarrSeriesSeason season;
    final int seriesId;

    SonarrSeriesDetailsSeasonTile({
        Key key,
        @required this.season,
        @required this.seriesId,
    }) : super(key: key);

    @override
    State<SonarrSeriesDetailsSeasonTile> createState() => _State();
}

class _State extends State<SonarrSeriesDetailsSeasonTile> {
    @override
    Widget build(BuildContext context) => widget.season == null
        ? Container()
        : LSCardTile(
            title: LSTitle(text: widget.season.seasonNumber == 0 ? 'Specials' : 'Season ${widget.season.seasonNumber}', darken: !widget.season.monitored),
            subtitle: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: widget.season.monitored ? Colors.white70 : Colors.white30,
                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                    ),
                    children: [
                        TextSpan(text: widget.season?.statistics?.sizeOnDisk?.lunaBytesToString(decimals: 1) ?? '0.0 B'),
                        TextSpan(text: '\n'),
                        TextSpan(
                            style: TextStyle(
                                color: widget.season.lunaPercentageComplete == 100
                                    ? widget.season.monitored ? LunaColours.accent : LunaColours.accent.withOpacity(0.30)
                                    : widget.season.monitored ? LunaColours.red : LunaColours.red.withOpacity(0.30),
                                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                            ),
                            text: '${widget.season.lunaPercentageComplete}% ${Constants.TEXT_EMDASH} ${widget?.season?.statistics?.episodeFileCount ?? 0}/${widget?.season?.statistics?.totalEpisodeCount ?? 0} Episodes Available',
                        ),
                    ],
                ),
            ),
            trailing: _trailing(context),
            onTap: () async => _onTap(context),
            onLongPress: () async => SonarrSeasonDetailsSeasonHeader.handler(context, widget.seriesId, widget.season.seasonNumber),
            padContent: true,
        );

    Widget _trailing(BuildContext context) => LSIconButton(
        icon: widget.season.monitored ? Icons.turned_in : Icons.turned_in_not,
        color: widget.season.monitored ? Colors.white : Colors.white30,
        onPressed: _trailingOnPressed,
    );

    Future<void> _trailingOnPressed() async {
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
        bool _fallbackState = widget.season.monitored;
        await _state.series
        .then((seriesList) {
            SonarrSeries _series = seriesList.firstWhere(
                (series) => series.id == widget.seriesId,
                orElse: () => null,
            );
            if(_series == null) throw Exception('Series not found');
            return _series;
        })
        .then((series) {
            series.seasons.forEach((season) {
                if(season.seasonNumber == widget.season.seasonNumber) season.monitored = !widget.season.monitored;
            });
            return series;
        })
        .then((series) => _state.api.series.updateSeries(series: series))
        .then((_) {
            setState(() {});
            showLunaSuccessSnackBar(
                title: widget.season.monitored
                    ? 'Monitoring'
                    : 'No Longer Monitoring',
                message: widget.season.seasonNumber == 0
                    ? 'Specials'
                    : 'Season ${widget.season.seasonNumber}',
            );
        })
        .catchError((error, stack) {
            setState(() => widget.season.monitored = _fallbackState);
            LunaLogger().error('Failed to toggle monitored state: ${widget.seriesId} / ${widget.season.seasonNumber}', error, stack);
        });
    }

    Future<void> _onTap(BuildContext context) async => SonarrSeasonDetailsRouter().navigateTo(
        context,
        seriesId: widget.seriesId,
        seasonNumber: widget.season.seasonNumber,
    );
}
