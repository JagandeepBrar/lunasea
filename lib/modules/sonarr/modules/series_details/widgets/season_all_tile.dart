import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsSeasonAllTile extends StatelessWidget {
    final SonarrSeries series;

    SonarrSeriesDetailsSeasonAllTile({
        Key key,
        @required this.series,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'All Seasons', darken: !series.monitored),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: series.monitored ? Colors.white70 : Colors.white30,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: [
                    TextSpan(text: series?.sizeOnDisk?.lsBytes_BytesToString(decimals: 1) ?? '0.0 B'),
                    TextSpan(text: '\n'),
                    TextSpan(
                        style: TextStyle(
                            color: series.lunaPercentageComplete == 100
                                ? series.monitored ? LunaColours.accent : LunaColours.accent.withOpacity(0.30)
                                : series.monitored ? LunaColours.red : LunaColours.red.withOpacity(0.30),
                            fontWeight: FontWeight.w600,
                        ),
                        text: '${series.lunaPercentageComplete}% ${Constants.TEXT_EMDASH} ${series.episodeFileCount ?? 0}/${series.episodeCount ?? 0} Episodes Available',
                    ),
                ],
            ),
        ),
        padContent: true,
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _onTap(context),
    );
    
    Future<void> _onTap(BuildContext context) async => SonarrSeriesSeasonDetailsRouter.navigateTo(
        context,
        seriesId: series.id,
        seasonNumber: -1,
    );
}
