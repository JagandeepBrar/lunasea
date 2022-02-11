import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

enum _ReadarrAuthorTileType {
  TILE,
  GRID,
}

class ReadarrAuthorTile extends StatefulWidget {
  static final itemExtent = LunaBlock.calculateItemExtent(3);

  final ReadarrAuthor series;
  final ReadarrQualityProfile? profile;
  final _ReadarrAuthorTileType type;

  const ReadarrAuthorTile({
    Key? key,
    required this.series,
    required this.profile,
    this.type = _ReadarrAuthorTileType.TILE,
  }) : super(key: key);

  const ReadarrAuthorTile.grid({
    Key? key,
    required this.series,
    required this.profile,
    this.type = _ReadarrAuthorTileType.GRID,
  }) : super(key: key);

  @override
  State<ReadarrAuthorTile> createState() => _State();
}

class _State extends State<ReadarrAuthorTile> {
  @override
  Widget build(BuildContext context) {
    return Selector<ReadarrState, Future<Map<int?, ReadarrAuthor>>?>(
      selector: (_, state) => state.authors,
      builder: (context, series, _) {
        switch (widget.type) {
          case _ReadarrAuthorTileType.TILE:
            return _buildBlockTile();
          case _ReadarrAuthorTileType.GRID:
            return _buildGridTile();
          default:
            throw Exception('Invalid _ReadarrAuthorTileType');
        }
      },
    );
  }

  Widget _buildBlockTile() {
    return LunaBlock(
      posterUrl:
          context.read<ReadarrState>().getAuthorPosterURL(widget.series.id),
      posterHeaders: context.read<ReadarrState>().headers,
      posterPlaceholderIcon: LunaIcons.BOOK,
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
    ReadarrAuthorSorting _sorting = context.read<ReadarrState>().seriesSortType;
    return LunaGridBlock(
      key: ObjectKey(widget.series),
      posterUrl:
          context.read<ReadarrState>().getAuthorPosterURL(widget.series.id),
      posterHeaders: context.read<ReadarrState>().headers,
      backgroundHeaders: context.read<ReadarrState>().headers,
      posterPlaceholderIcon: LunaIcons.BOOK,
      title: widget.series.title,
      subtitle: TextSpan(text: _sorting.value(widget.series, widget.profile)),
      disabled: !widget.series.monitored!,
      onTap: _onTap,
      onLongPress: _onLongPress,
    );
  }

  TextSpan _buildChildTextSpan(String? text, ReadarrAuthorSorting sorting) {
    TextStyle? style;
    if (context.read<ReadarrState>().seriesSortType == sorting) {
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
          ReadarrAuthorSorting.EPISODES,
        ),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        _buildChildTextSpan(
          widget.series.lunaSizeOnDisk,
          ReadarrAuthorSorting.SIZE,
        ),
      ],
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        _buildChildTextSpan(
          widget.profile?.name ?? LunaUI.TEXT_EMDASH,
          ReadarrAuthorSorting.QUALITY,
        ),
      ],
    );
  }

  TextSpan _subtitle3() {
    ReadarrAuthorSorting _sorting = context.read<ReadarrState>().seriesSortType;
    return TextSpan(
      children: [
        if (_sorting == ReadarrAuthorSorting.DATE_ADDED)
          _buildChildTextSpan(
            widget.series.lunaDateAdded,
            ReadarrAuthorSorting.DATE_ADDED,
          ),
      ],
    );
  }

  Future<void> _onTap() async => ReadarrAuthorDetailsRouter().navigateTo(
        context,
        widget.series.id!,
      );

  Future<void> _onLongPress() async {
    Tuple2<bool, ReadarrAuthorSettingsType?> values =
        await ReadarrDialogs().authorSettings(
      context,
      widget.series,
    );
    if (values.item1) values.item2!.execute(context, widget.series);
  }
}
