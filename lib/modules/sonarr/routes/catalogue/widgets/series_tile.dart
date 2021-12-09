import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesTile extends StatefulWidget {
  static final itemExtent = LunaFourLineCardWithPoster.itemExtent;

  final SonarrSeries series;
  final SonarrQualityProfile profile;

  const SonarrSeriesTile({
    Key key,
    @required this.series,
    @required this.profile,
  }) : super(key: key);

  @override
  State<SonarrSeriesTile> createState() => _State();
}

class _State extends State<SonarrSeriesTile> {
  @override
  Widget build(BuildContext context) {
    return Selector<SonarrState, Future<Map<int, SonarrSeries>>>(
      selector: (_, state) => state.series,
      builder: (context, series, _) => LunaFourLineCardWithPoster(
        backgroundUrl:
            context.read<SonarrState>().getPosterURL(widget.series.id),
        posterUrl: context.read<SonarrState>().getPosterURL(widget.series.id),
        posterHeaders: context.read<SonarrState>().headers,
        posterPlaceholder: LunaAssets.blankVideo,
        darken: !widget.series.monitored,
        title: widget.series.title,
        subtitle1: _subtitle1(),
        subtitle2: _subtitle2(),
        subtitle3: _subtitle3(),
        onTap: _onTap,
        onLongPress: _onLongPress,
      ),
    );
  }

  TextSpan _buildChildTextSpan(String text, SonarrSeriesSorting sorting) {
    TextStyle style;
    if (context.read<SonarrState>().seriesSortType == sorting)
      style = TextStyle(
        color: widget.series.monitored
            ? LunaColours.accent
            : LunaColours.accent.withOpacity(0.30),
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        fontSize: LunaUI.FONT_SIZE_H3,
      );
    return TextSpan(
      text: text,
      style: style,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      children: [
        _buildChildTextSpan(
          widget.series.lunaEpisodeCount,
          SonarrSeriesSorting.EPISODES,
        ),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: widget.series.lunaSeasonCount),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        _buildChildTextSpan(
          widget.series.lunaSizeOnDisk,
          SonarrSeriesSorting.SIZE,
        ),
      ],
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        _buildChildTextSpan(
          widget.series.lunaSeriesType,
          SonarrSeriesSorting.TYPE,
        ),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        _buildChildTextSpan(
          widget.profile?.name ?? LunaUI.TEXT_EMDASH,
          SonarrSeriesSorting.QUALITY,
        ),
      ],
    );
  }

  TextSpan _subtitle3() {
    return TextSpan(
      children: [
        _buildChildTextSpan(
          widget.series.lunaNetwork,
          SonarrSeriesSorting.NETWORK,
        ),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        if (context.read<SonarrState>().seriesSortType ==
            SonarrSeriesSorting.DATE_ADDED)
          _buildChildTextSpan(
            widget.series.lunaDateAdded,
            SonarrSeriesSorting.DATE_ADDED,
          ),
        if (context.read<SonarrState>().seriesSortType !=
            SonarrSeriesSorting.DATE_ADDED)
          _buildChildTextSpan(
            widget.series.lunaNextAiringLine,
            SonarrSeriesSorting.NEXT_AIRING,
          ),
      ],
    );
  }

  Future<void> _onTap() async => SonarrSeriesDetailsRouter().navigateTo(
        context,
        seriesId: widget.series.id,
      );

  Future<void> _onLongPress() async {
    Tuple2<bool, SonarrSeriesSettingsType> values =
        await SonarrDialogs().seriesSettings(
      context,
      widget.series,
    );
    if (values.item1) values.item2.execute(context, widget.series);
  }
}
