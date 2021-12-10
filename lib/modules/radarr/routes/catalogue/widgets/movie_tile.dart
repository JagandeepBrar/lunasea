import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrCatalogueTile extends StatefulWidget {
  static final itemExtent = LunaBlock.calculateItemExtent(2, hasBottom: true);

  final RadarrMovie movie;
  final RadarrQualityProfile profile;

  const RadarrCatalogueTile({
    Key key,
    @required this.movie,
    @required this.profile,
  }) : super(key: key);

  @override
  State<RadarrCatalogueTile> createState() => _State();
}

class _State extends State<RadarrCatalogueTile> {
  @override
  Widget build(BuildContext context) {
    return Selector<RadarrState, Future<List<RadarrMovie>>>(
      selector: (_, state) => state.movies,
      builder: (context, movies, _) => LunaBlock(
        backgroundUrl:
            context.read<RadarrState>().getFanartURL(widget.movie.id),
        posterUrl: context.read<RadarrState>().getPosterURL(widget.movie.id),
        posterHeaders: context.read<RadarrState>().headers,
        posterPlaceholder: LunaAssets.blankVideo,
        disabled: !widget.movie.monitored,
        title: widget.movie.title,
        body: [
          _subtitle1(),
          _subtitle2(),
        ],
        posterIsSquare: false,
        bottom: _subtitle3(),
        onTap: _onTap,
        onLongPress: _onLongPress,
      ),
    );
  }

  TextSpan _buildChildTextSpan(String text, RadarrMoviesSorting sorting) {
    TextStyle style;
    if (context.read<RadarrState>().moviesSortType == sorting)
      style = TextStyle(
        color: widget.movie.monitored
            ? LunaColours.accent
            : LunaColours.accent.withOpacity(0.30),
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
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        _buildChildTextSpan(
            widget.movie.lunaRuntime, RadarrMoviesSorting.RUNTIME),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
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
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        _buildChildTextSpan(widget.movie.lunaMinimumAvailability,
            RadarrMoviesSorting.MIN_AVAILABILITY),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        if (context.read<RadarrState>().moviesSortType !=
                RadarrMoviesSorting.IN_CINEMAS &&
            context.read<RadarrState>().moviesSortType !=
                RadarrMoviesSorting.DIGITAL_RELEASE &&
            context.read<RadarrState>().moviesSortType !=
                RadarrMoviesSorting.PHYSICAL_RELEASE)
          _buildChildTextSpan(
              widget.movie.lunaDateAdded, RadarrMoviesSorting.DATE_ADDED),
        if (context.read<RadarrState>().moviesSortType ==
            RadarrMoviesSorting.PHYSICAL_RELEASE)
          _buildChildTextSpan(widget.movie.lunaPhysicalReleaseDate,
              RadarrMoviesSorting.PHYSICAL_RELEASE),
        if (context.read<RadarrState>().moviesSortType ==
            RadarrMoviesSorting.DIGITAL_RELEASE)
          _buildChildTextSpan(widget.movie.lunaDigitalReleaseDate,
              RadarrMoviesSorting.DIGITAL_RELEASE),
        if (context.read<RadarrState>().moviesSortType ==
            RadarrMoviesSorting.IN_CINEMAS)
          _buildChildTextSpan(
              widget.movie.lunaInCinemasOn, RadarrMoviesSorting.IN_CINEMAS),
      ],
    );
  }

  Widget _buildReleaseIcon(IconData icon, Color color, bool highlight) {
    Color _color = (highlight ? color : Colors.grey)
        .withOpacity(widget.movie.monitored ? 1 : 0.30);
    return Container(
      child: Icon(
        icon,
        size: LunaUI.FONT_SIZE_H2,
        color: _color,
      ),
      alignment: Alignment.bottomLeft,
      width: LunaListTile.SUBTITLE_HEIGHT + LunaUI.DEFAULT_MARGIN_SIZE / 2,
      height: LunaListTile.SUBTITLE_HEIGHT,
    );
  }

  Widget _subtitle3() {
    return SizedBox(
      height: LunaListTile.SUBTITLE_HEIGHT,
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
            widget.movie.hasFile,
          ),
          Container(
            height: LunaListTile.SUBTITLE_HEIGHT,
            alignment: Alignment.topCenter,
            child: widget.movie.hasFile
                ? widget.movie.lunaHasFileTextObject(widget.movie.monitored)
                : widget.movie
                    .lunaNextReleaseTextObject(widget.movie.monitored),
          ),
        ],
      ),
    );
  }

  Future<void> _onTap() async =>
      RadarrMoviesDetailsRouter().navigateTo(context, movieId: widget.movie.id);

  Future<void> _onLongPress() async {
    Tuple2<bool, RadarrMovieSettingsType> values =
        await RadarrDialogs().movieSettings(context, widget.movie);
    if (values.item1) values.item2.execute(context, widget.movie);
  }
}
