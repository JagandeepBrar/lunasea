import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/router/routes/mylar.dart';

enum _MylarSeriesTileType {
  TILE,
  GRID,
}

class MylarSeriesTile extends StatefulWidget {
  static final itemExtent = LunaBlock.calculateItemExtent(3);

  final MylarSeries series;
  final MylarQualityProfile? profile;
  final _MylarSeriesTileType type;

  const MylarSeriesTile({
    Key? key,
    required this.series,
    required this.profile,
    this.type = _MylarSeriesTileType.TILE,
  }) : super(key: key);

  const MylarSeriesTile.grid({
    Key? key,
    required this.series,
    required this.profile,
    this.type = _MylarSeriesTileType.GRID,
  }) : super(key: key);

  @override
  State<MylarSeriesTile> createState() => _State();
}

class _State extends State<MylarSeriesTile> {
  @override
  Widget build(BuildContext context) {
    return Selector<MylarState, Future<Map<int?, MylarSeries>>?>(
      selector: (_, state) => state.series,
      builder: (context, series, _) {
        switch (widget.type) {
          case _MylarSeriesTileType.TILE:
            return _buildBlockTile();
          case _MylarSeriesTileType.GRID:
            return _buildGridTile();
          default:
            throw Exception('Invalid _MylarSeriesTileType');
        }
      },
    );
  }

  Widget _buildBlockTile() {
    return LunaBlock(
      backgroundUrl: context.read<MylarState>().getFanartURL(widget.series.id),
      backgroundHeaders: context.read<MylarState>().headers,
      posterUrl: context.read<MylarState>().getPosterURL(widget.series.id),
      posterHeaders: context.read<MylarState>().headers,
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      disabled: !widget.series.monitored!,
      title: widget.series.title,
      body: [
        _subtitle1(),
        _subtitle2(),
        _subtitle3(),
      ],
      onTap: _onTap,
      onLongPress: _onLongPress,
    );
  }

  Widget _buildGridTile() {
    MylarSeriesSorting _sorting = context.read<MylarState>().seriesSortType;
    return LunaGridBlock(
      key: ObjectKey(widget.series),
      backgroundUrl: context.read<MylarState>().getFanartURL(widget.series.id),
      posterUrl: context.read<MylarState>().getPosterURL(widget.series.id),
      posterHeaders: context.read<MylarState>().headers,
      backgroundHeaders: context.read<MylarState>().headers,
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      title: widget.series.title,
      subtitle: TextSpan(text: _sorting.value(widget.series, widget.profile)),
      disabled: !widget.series.monitored!,
      onTap: _onTap,
      onLongPress: _onLongPress,
    );
  }

  TextSpan _buildChildTextSpan(String? text, MylarSeriesSorting sorting) {
    TextStyle? style;
    if (context.read<MylarState>().seriesSortType == sorting) {
      style = const TextStyle(
        color: LunaColours.accent,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        fontSize: LunaUI.FONT_SIZE_H3,
      );
    }
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
          MylarSeriesSorting.EPISODES,
        ),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        TextSpan(text: widget.series.lunaSeasonCount),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        _buildChildTextSpan(
          widget.series.lunaSizeOnDisk,
          MylarSeriesSorting.SIZE,
        ),
      ],
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        _buildChildTextSpan(
          widget.series.lunaSeriesType,
          MylarSeriesSorting.TYPE,
        ),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        _buildChildTextSpan(
          widget.profile?.name ?? LunaUI.TEXT_EMDASH,
          MylarSeriesSorting.QUALITY,
        ),
      ],
    );
  }

  TextSpan _subtitle3() {
    MylarSeriesSorting _sorting = context.read<MylarState>().seriesSortType;
    return TextSpan(
      children: [
        _buildChildTextSpan(
          widget.series.lunaNetwork,
          MylarSeriesSorting.NETWORK,
        ),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        if (_sorting == MylarSeriesSorting.DATE_ADDED)
          _buildChildTextSpan(
            widget.series.lunaDateAdded,
            MylarSeriesSorting.DATE_ADDED,
          ),
        if (_sorting == MylarSeriesSorting.PREVIOUS_AIRING)
          _buildChildTextSpan(
            widget.series.lunaPreviousAiring(),
            MylarSeriesSorting.PREVIOUS_AIRING,
          ),
        if (_sorting != MylarSeriesSorting.DATE_ADDED &&
            _sorting != MylarSeriesSorting.PREVIOUS_AIRING)
          _buildChildTextSpan(
            widget.series.lunaNextAiring(),
            MylarSeriesSorting.NEXT_AIRING,
          ),
      ],
    );
  }

  Future<void> _onTap() async {
    MylarRoutes.SERIES.go(params: {
      'series': widget.series.id!.toString(),
    });
  }

  Future<void> _onLongPress() async {
    Tuple2<bool, MylarSeriesSettingsType?> values =
        await MylarDialogs().seriesSettings(
      context,
      widget.series,
    );
    if (values.item1) values.item2!.execute(context, widget.series);
  }
}
