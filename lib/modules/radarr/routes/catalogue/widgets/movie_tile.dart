import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/router/routes/radarr.dart';

enum _RadarrCatalogueTileType {
  TILE,
  GRID,
}

class RadarrCatalogueTile extends StatefulWidget {
  static final itemExtent = LunaBlock.calculateItemExtent(2, hasBottom: true);

  final RadarrMovie movie;
  final RadarrQualityProfile? profile;
  final _RadarrCatalogueTileType type;

  const RadarrCatalogueTile({
    Key? key,
    required this.movie,
    required this.profile,
    this.type = _RadarrCatalogueTileType.TILE,
  }) : super(key: key);

  const RadarrCatalogueTile.grid({
    Key? key,
    required this.movie,
    required this.profile,
    this.type = _RadarrCatalogueTileType.GRID,
  }) : super(key: key);

  @override
  State<RadarrCatalogueTile> createState() => _State();
}

class _State extends State<RadarrCatalogueTile> {
  @override
  Widget build(BuildContext context) {
    return Selector<RadarrState, Future<List<RadarrMovie>>?>(
      selector: (_, state) => state.movies,
      builder: (context, movies, _) {
        switch (widget.type) {
          case _RadarrCatalogueTileType.TILE:
            return _buildBlockTile();
          case _RadarrCatalogueTileType.GRID:
            return _buildGridTile();
          default:
            throw Exception('Invalid _RadarrCatalogueTileType');
        }
      },
    );
  }

  Widget _buildBlockTile() {
    return LunaBlock(
      key: ObjectKey(widget.movie),
      backgroundUrl: context.read<RadarrState>().getFanartURL(widget.movie.id),
      posterUrl: context.read<RadarrState>().getPosterURL(widget.movie.id),
      posterHeaders: context.read<RadarrState>().headers,
      backgroundHeaders: context.read<RadarrState>().headers,
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      disabled: !widget.movie.monitored!,
      title: widget.movie.title,
      body: [
        _subtitle1(),
        _subtitle2(),
      ],
      posterIsSquare: false,
      bottom: _subtitle3(),
      onTap: _onTap,
      onLongPress: _onLongPress,
    );
  }

  Widget _buildGridTile() {
    RadarrMoviesSorting _sorting = context.read<RadarrState>().moviesSortType;
    return LunaGridBlock(
      key: ObjectKey(widget.movie),
      backgroundUrl: context.read<RadarrState>().getFanartURL(widget.movie.id),
      posterUrl: context.read<RadarrState>().getPosterURL(widget.movie.id),
      posterHeaders: context.read<RadarrState>().headers,
      backgroundHeaders: context.read<RadarrState>().headers,
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      title: widget.movie.title,
      subtitle: TextSpan(text: _sorting.value(widget.movie, widget.profile)),
      disabled: !widget.movie.monitored!,
      onTap: _onTap,
      onLongPress: _onLongPress,
    );
  }

  TextSpan _buildChildTextSpan(String? text, RadarrMoviesSorting sorting) {
    TextStyle? style;
    if (context.read<RadarrState>().moviesSortType == sorting)
      style = const TextStyle(
        color: LunaColours.accent,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      );
    return TextSpan(
      text: text,
      style: style,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      children: [
        _buildChildTextSpan(widget.movie.lunaYear, RadarrMoviesSorting.YEAR),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        _buildChildTextSpan(
            widget.movie.lunaRuntime, RadarrMoviesSorting.RUNTIME),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        _buildChildTextSpan(
            widget.movie.lunaStudio, RadarrMoviesSorting.STUDIO),
      ],
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        _buildChildTextSpan(widget.profile?.name ?? LunaUI.TEXT_EMDASH,
            RadarrMoviesSorting.QUALITY_PROFILE),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        _buildChildTextSpan(widget.movie.lunaMinimumAvailability,
            RadarrMoviesSorting.MIN_AVAILABILITY),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        if (context.read<RadarrState>().moviesSortType !=
                RadarrMoviesSorting.IN_CINEMAS &&
            context.read<RadarrState>().moviesSortType !=
                RadarrMoviesSorting.DIGITAL_RELEASE &&
            context.read<RadarrState>().moviesSortType !=
                RadarrMoviesSorting.PHYSICAL_RELEASE)
          _buildChildTextSpan(
            widget.movie.lunaDateAdded(),
            RadarrMoviesSorting.DATE_ADDED,
          ),
        if (context.read<RadarrState>().moviesSortType ==
            RadarrMoviesSorting.PHYSICAL_RELEASE)
          _buildChildTextSpan(widget.movie.lunaPhysicalReleaseDate(),
              RadarrMoviesSorting.PHYSICAL_RELEASE),
        if (context.read<RadarrState>().moviesSortType ==
            RadarrMoviesSorting.DIGITAL_RELEASE)
          _buildChildTextSpan(widget.movie.lunaDigitalReleaseDate(),
              RadarrMoviesSorting.DIGITAL_RELEASE),
        if (context.read<RadarrState>().moviesSortType ==
            RadarrMoviesSorting.IN_CINEMAS)
          _buildChildTextSpan(
            widget.movie.lunaInCinemasOn(),
            RadarrMoviesSorting.IN_CINEMAS,
          ),
      ],
    );
  }

  Widget _buildReleaseIcon(IconData icon, Color color, bool highlight) {
    return Padding(
      child: Container(
        child: Icon(
          icon,
          size: LunaUI.FONT_SIZE_H2,
          color: highlight ? color : LunaColours.grey.disabled(),
        ),
        width: LunaBlock.SUBTITLE_HEIGHT,
        height: LunaBlock.SUBTITLE_HEIGHT,
        alignment: Alignment.centerLeft,
      ),
      padding: const EdgeInsets.only(right: LunaUI.DEFAULT_MARGIN_SIZE / 4),
    );
  }

  Widget _subtitle3() {
    return SizedBox(
      height: LunaBlock.SUBTITLE_HEIGHT,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildReleaseIcon(
            Icons.videocam_rounded,
            LunaColours.orange,
            widget.movie.lunaIsInCinemas,
          ),
          _buildReleaseIcon(
            Icons.album_rounded,
            LunaColours.blue,
            widget.movie.lunaIsReleased,
          ),
          _buildReleaseIcon(
            Icons.check_circle_rounded,
            LunaColours.accent,
            widget.movie.hasFile!,
          ),
          Container(
            height: LunaBlock.SUBTITLE_HEIGHT,
            child: widget.movie.hasFile!
                ? widget.movie.lunaHasFileTextObject()
                : widget.movie.lunaNextReleaseTextObject(),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  Future<void> _onTap() async {
    RadarrRoutes.MOVIE.go(params: {
      'movie': widget.movie.id!.toString(),
    });
  }

  Future<void> _onLongPress() async {
    Tuple2<bool, RadarrMovieSettingsType?> values =
        await RadarrDialogs().movieSettings(context, widget.movie);
    if (values.item1) values.item2!.execute(context, widget.movie);
  }
}
