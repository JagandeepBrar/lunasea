import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddSearchResultTile extends StatefulWidget {
  final SonarrSeries series;
  final bool onTapShowOverview;
  final bool exists;
  final bool isExcluded;

  const SonarrSeriesAddSearchResultTile({
    Key key,
    @required this.series,
    @required this.exists,
    @required this.isExcluded,
    this.onTapShowOverview = false,
  }) : super(key: key);

  @override
  State<SonarrSeriesAddSearchResultTile> createState() => _State();
}

class _State extends State<SonarrSeriesAddSearchResultTile> {
  @override
  Widget build(BuildContext context) {
    return LunaFourLineCardWithPoster(
      backgroundUrl: widget.series.remotePoster,
      posterUrl: widget.series.remotePoster,
      posterHeaders: context.watch<SonarrState>().headers,
      posterPlaceholder: LunaAssets.blankVideo,
      title: widget.series.title,
      darken: widget.exists,
      titleColor: widget.isExcluded ? LunaColours.red : Colors.white,
      subtitle1: _subtitle1(),
      subtitle2: _subtitle2(),
      subtitle2MaxLines: 2,
      onTap: _onTap,
      onLongPress: _onLongPress,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(children: [
      TextSpan(text: widget.series.lunaSeasonCount),
      TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
      TextSpan(text: widget.series.lunaYear),
      TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
      TextSpan(text: widget.series.lunaNetwork),
    ]);
  }

  TextSpan _subtitle2() => TextSpan(
        style: TextStyle(
          fontSize: LunaUI.FONT_SIZE_H3,
          fontStyle: FontStyle.italic,
          color: widget.exists ? Colors.white30 : Colors.white70,
        ),
        text: '${widget.series.lunaOverview}\n',
      );

  Future<void> _onTap() async {
    if (widget.onTapShowOverview) {
      LunaDialogs().textPreview(
        context,
        widget.series.title,
        widget.series.overview ?? 'sonarr.NoSummaryAvailable'.tr(),
      );
    } else if (widget.exists) {
      SonarrSeriesDetailsRouter().navigateTo(
        context,
        seriesId: widget.series.id ?? -1,
      );
    } else {
      SonarrAddSeriesDetailsRouter().navigateTo(
        context,
        series: widget.series,
      );
    }
  }

  Future<void> _onLongPress() async =>
      widget.series?.tvdbId?.toString()?.lunaOpenTheTVDB();
}
