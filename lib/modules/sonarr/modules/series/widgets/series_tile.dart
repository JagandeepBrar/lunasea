import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesTile extends StatefulWidget {
    final SonarrSeries series;

    SonarrSeriesTile({
        Key key,
        @required this.series,
    }) : super(key: key);

    @override
    State<SonarrSeriesTile> createState() => _State();
}

class _State extends State<SonarrSeriesTile> {
    final double _height = 90.0;
    final double _width = 60.0;
    final double _padding = 8.0;

    @override
    Widget build(BuildContext context) => LSCard(
        child: InkWell(
            child: Row(
                children: [
                    _poster,
                    Expanded(child: _information),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
            ),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            onTap: () async => _tileOnTap(),
        ),
        decoration: LSCardBackground(
            uri: Provider.of<SonarrState>(context, listen: false).getBannerURL(widget.series.id),
            headers: Provider.of<SonarrState>(context, listen: false).headers,
        ),
    );

    Widget get _poster => LSNetworkImage(
        url: Provider.of<SonarrState>(context, listen: false).getPosterURL(widget.series.id),
        placeholder: 'assets/images/sonarr/noseriesposter.png',
        height: _height,
        width: _width,
        headers: Provider.of<SonarrState>(context, listen: false).headers.cast<String, String>(),
    );

    Widget get _information => Padding(
        child: Container(
            child: Column(
                children: [
                    LSTitle(text: widget.series.title, darken: !widget.series.monitored, maxLines: 1),
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
        padding: EdgeInsets.all(_padding),
    );

    Widget get _subtitleOne => RichText(
        text: TextSpan(
            style: TextStyle(
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                color: widget.series.monitored ? Colors.white70 : Colors.white30,
            ),
            children: [
                TextSpan(
                    text: widget.series.lunaSeriesType,
                    style: TextStyle(
                        color: Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.type
                            ? LunaColours.accent
                            : null,
                        fontWeight: Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.type
                            ? FontWeight.w600
                            : null,
                    ),
                ),
                TextSpan(text: ' ${Constants.TEXT_BULLET} '),
                TextSpan(text: widget.series.lunaSeasonCount),
                TextSpan(text: ' ${Constants.TEXT_BULLET} '),
                TextSpan(
                    text: widget.series.lunaSizeOnDisk,
                    style: TextStyle(
                        color: Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.size
                            ? LunaColours.accent
                            : null,
                        fontWeight: Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.size
                            ? FontWeight.w600
                            : null,
                    ),
                ),
            ],
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: 1,
    );

    Widget get _subtitleTwo => RichText(
        text: TextSpan(
            style: TextStyle(
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                color: widget.series.monitored ? Colors.white70 : Colors.white30,
            ),
            children: [
                TextSpan(
                    text: widget.series.lunaEpisodeCount,
                    style: TextStyle(
                        color: Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.episodes
                            ? LunaColours.accent
                            : null,
                        fontWeight: Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.episodes
                            ? FontWeight.w600
                            : null,
                    ),
                ),
                TextSpan(text: ' ${Constants.TEXT_BULLET} '),
                TextSpan(
                    text: 'HD 720p/1080p', //widget.series.qualityProfileId.toString(),
                    style: TextStyle(
                        color: Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.quality
                            ? LunaColours.accent
                            : null,
                        fontWeight: Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.quality
                            ? FontWeight.w600
                            : null,
                    ),
                ),
            ],
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: 1,
    );

    Widget get _subtitleThree => RichText(
        text: TextSpan(
            style: TextStyle(
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                color: widget.series.monitored ? Colors.white70 : Colors.white30,
            ),
            children: [
                TextSpan(
                    text: widget.series.lunaAirsOn,
                    style: TextStyle(
                        color:
                            Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.network ||
                            Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.nextAiring
                                ? LunaColours.accent
                                : null,
                        fontWeight:
                            Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.network ||
                            Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.nextAiring
                                ? FontWeight.w600
                                : null,
                    ),
                ),
                TextSpan(
                    text: ' ${Constants.TEXT_BULLET} ',
                    style: TextStyle(
                        color: Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.nextAiring
                            ? LunaColours.accent
                            : null,
                    ),
                ),
                if(Provider.of<SonarrState>(context).seriesSortType != SonarrSeriesSorting.nextAiring) TextSpan(
                    text: widget.series.lunaDateAdded,
                    style: TextStyle(
                        color: Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.dateAdded
                            ? LunaColours.accent
                            : null,
                        fontWeight: Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.dateAdded
                            ? FontWeight.w600
                            : null,
                    ),
                ),
                if(Provider.of<SonarrState>(context).seriesSortType == SonarrSeriesSorting.nextAiring) TextSpan(
                    text: widget.series.lunaNextAiring,
                    style: TextStyle(
                        color: LunaColours.accent,
                        fontWeight: FontWeight.w600,
                    ),
                ),
            ],
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: 1,
    );

    Future<void> _tileOnTap() async => SonarrSeriesDetailsRouter.navigateTo(context, seriesId: widget.series.id);
}
