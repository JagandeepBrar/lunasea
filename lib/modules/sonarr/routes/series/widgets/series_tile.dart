import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesTile extends StatefulWidget {
  final SonarrSeries series;
  final SonarrQualityProfile profile;

  SonarrSeriesTile({
    Key key,
    @required this.series,
    @required this.profile,
  }) : super(key: key);

  @override
  State<SonarrSeriesTile> createState() => _State();
}

class _State extends State<SonarrSeriesTile> {
  final double _height = 90.0;
  final double _width = 60.0;
  final double _padding = 8.0;

  @override
  Widget build(BuildContext context) =>
      Selector<SonarrState, Future<List<SonarrSeries>>>(
        selector: (_, state) => state.series,
        builder: (context, series, _) => LunaCard(
          context: context,
          child: InkWell(
            child: Row(
              children: [
                _poster,
                Expanded(child: _information),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
            onTap: () async => _tileOnTap(),
            onLongPress: () async => SonarrAppBarSeriesSettingsAction.handler(
                context, widget.series),
          ),
          decoration: LunaCardDecoration(
            uri: Provider.of<SonarrState>(context, listen: false)
                .getBannerURL(widget.series.id),
            headers: Provider.of<SonarrState>(context, listen: false).headers,
          ),
        ),
      );

  Widget get _poster => LunaNetworkImage(
        url: Provider.of<SonarrState>(context, listen: false)
            .getPosterURL(widget.series.id),
        placeholderAsset: LunaAssets.video,
        height: _height,
        width: _width,
        headers: Provider.of<SonarrState>(context, listen: false)
            .headers
            .cast<String, String>(),
      );

  Widget get _information => Padding(
        child: Container(
          child: Column(
            children: [
              LunaText.title(
                  text: widget.series.title,
                  darken: !widget.series.monitored,
                  maxLines: 1),
              _subtitleOne,
              _subtitleTwo,
              _subtitleThree,
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
          ),
          height: (_height - (_padding * 2)),
        ),
        padding: EdgeInsets.all(_padding),
      );

  Widget get _subtitleOne => RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: LunaUI.FONT_SIZE_SUBTITLE,
            color: widget.series.monitored ? Colors.white70 : Colors.white30,
          ),
          children: [
            TextSpan(
              text: widget.series.lunaEpisodeCount,
              style: TextStyle(
                color: Provider.of<SonarrState>(context).seriesSortType ==
                        SonarrSeriesSorting.EPISODES
                    ? widget.series.monitored
                        ? LunaColours.accent
                        : LunaColours.accent.withOpacity(0.30)
                    : null,
                fontWeight: Provider.of<SonarrState>(context).seriesSortType ==
                        SonarrSeriesSorting.EPISODES
                    ? LunaUI.FONT_WEIGHT_BOLD
                    : null,
              ),
            ),
            TextSpan(text: ' ${LunaUI.TEXT_BULLET} '),
            TextSpan(text: widget.series.lunaSeasonCount),
            TextSpan(text: ' ${LunaUI.TEXT_BULLET} '),
            TextSpan(
              text: widget.series.lunaSizeOnDisk,
              style: TextStyle(
                color: Provider.of<SonarrState>(context).seriesSortType ==
                        SonarrSeriesSorting.SIZE
                    ? widget.series.monitored
                        ? LunaColours.accent
                        : LunaColours.accent.withOpacity(0.30)
                    : null,
                fontWeight: Provider.of<SonarrState>(context).seriesSortType ==
                        SonarrSeriesSorting.SIZE
                    ? LunaUI.FONT_WEIGHT_BOLD
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
            fontSize: LunaUI.FONT_SIZE_SUBTITLE,
            color: widget.series.monitored ? Colors.white70 : Colors.white30,
          ),
          children: [
            TextSpan(
              text: widget.series.lunaSeriesType,
              style: TextStyle(
                color: Provider.of<SonarrState>(context).seriesSortType ==
                        SonarrSeriesSorting.TYPE
                    ? widget.series.monitored
                        ? LunaColours.accent
                        : LunaColours.accent.withOpacity(0.30)
                    : null,
                fontWeight: Provider.of<SonarrState>(context).seriesSortType ==
                        SonarrSeriesSorting.TYPE
                    ? LunaUI.FONT_WEIGHT_BOLD
                    : null,
              ),
            ),
            TextSpan(text: ' ${LunaUI.TEXT_BULLET} '),
            TextSpan(
              text: widget.profile?.name ?? 'Unknown',
              style: TextStyle(
                color: Provider.of<SonarrState>(context).seriesSortType ==
                        SonarrSeriesSorting.QUALITY
                    ? widget.series.monitored
                        ? LunaColours.accent
                        : LunaColours.accent.withOpacity(0.30)
                    : null,
                fontWeight: Provider.of<SonarrState>(context).seriesSortType ==
                        SonarrSeriesSorting.QUALITY
                    ? LunaUI.FONT_WEIGHT_BOLD
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
            fontSize: LunaUI.FONT_SIZE_SUBTITLE,
            color: widget.series.monitored ? Colors.white70 : Colors.white30,
          ),
          children: [
            TextSpan(
              text: widget.series.lunaAirsOn,
              style: TextStyle(
                color: Provider.of<SonarrState>(context).seriesSortType ==
                            SonarrSeriesSorting.NETWORK ||
                        Provider.of<SonarrState>(context).seriesSortType ==
                            SonarrSeriesSorting.NEXT_AIRING
                    ? widget.series.monitored
                        ? LunaColours.accent
                        : LunaColours.accent.withOpacity(0.30)
                    : null,
                fontWeight: Provider.of<SonarrState>(context).seriesSortType ==
                            SonarrSeriesSorting.NETWORK ||
                        Provider.of<SonarrState>(context).seriesSortType ==
                            SonarrSeriesSorting.NEXT_AIRING
                    ? LunaUI.FONT_WEIGHT_BOLD
                    : null,
              ),
            ),
            TextSpan(
              text: ' ${LunaUI.TEXT_BULLET} ',
              style: TextStyle(
                color: Provider.of<SonarrState>(context).seriesSortType ==
                        SonarrSeriesSorting.NEXT_AIRING
                    ? widget.series.monitored
                        ? LunaColours.accent
                        : LunaColours.accent.withOpacity(0.30)
                    : null,
              ),
            ),
            if (Provider.of<SonarrState>(context).seriesSortType !=
                SonarrSeriesSorting.NEXT_AIRING)
              TextSpan(
                text: widget.series.lunaDateAdded,
                style: TextStyle(
                  color: Provider.of<SonarrState>(context).seriesSortType ==
                          SonarrSeriesSorting.DATE_ADDED
                      ? widget.series.monitored
                          ? LunaColours.accent
                          : LunaColours.accent.withOpacity(0.30)
                      : null,
                  fontWeight:
                      Provider.of<SonarrState>(context).seriesSortType ==
                              SonarrSeriesSorting.DATE_ADDED
                          ? LunaUI.FONT_WEIGHT_BOLD
                          : null,
                ),
              ),
            if (Provider.of<SonarrState>(context).seriesSortType ==
                SonarrSeriesSorting.NEXT_AIRING)
              TextSpan(
                text: widget.series.lunaNextAiring,
                style: TextStyle(
                  color: widget.series.monitored
                      ? LunaColours.accent
                      : LunaColours.accent.withOpacity(0.30),
                  fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                ),
              ),
          ],
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: 1,
      );

  Future<void> _tileOnTap() async => SonarrSeriesDetailsRouter()
      .navigateTo(context, seriesId: widget.series.id);
}
