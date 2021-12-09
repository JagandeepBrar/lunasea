import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrUpcomingTile extends StatefulWidget {
  static final itemExtent = LunaFourLineCardWithPoster.itemExtent;

  final RadarrMovie movie;
  final RadarrQualityProfile profile;

  const RadarrUpcomingTile({
    Key key,
    @required this.movie,
    @required this.profile,
  }) : super(key: key);

  @override
  State<RadarrUpcomingTile> createState() => _State();
}

class _State extends State<RadarrUpcomingTile> {
  @override
  Widget build(BuildContext context) {
    return Selector<RadarrState, Future<List<RadarrMovie>>>(
      selector: (_, state) => state.missing,
      builder: (context, missing, _) => LunaFourLineCardWithPoster(
        backgroundUrl:
            context.read<RadarrState>().getPosterURL(widget.movie.id),
        posterUrl: context.read<RadarrState>().getPosterURL(widget.movie.id),
        posterHeaders: context.read<RadarrState>().headers,
        posterPlaceholder: LunaAssets.blankVideo,
        darken: !widget.movie.monitored,
        title: widget.movie.title,
        subtitle1: _subtitle1(),
        subtitle2: _subtitle2(),
        subtitle3: _subtitle3(),
        trailing: _trailing(),
        onTap: _onTap,
      ),
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      children: [
        TextSpan(text: widget.movie.lunaYear),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: widget.movie.lunaRuntime),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: widget.movie.lunaStudio),
      ],
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        TextSpan(text: widget.profile.lunaName),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: widget.movie.lunaMinimumAvailability),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: widget.movie.lunaReleaseDate),
      ],
    );
  }

  TextSpan _subtitle3() {
    Color color;
    String _days;
    String type;
    if (widget.movie.lunaIsInCinemas && !widget.movie.lunaIsReleased) {
      color = widget.movie.monitored
          ? LunaColours.blue
          : LunaColours.blue.withOpacity(0.30);
      _days = widget.movie.lunaEarlierReleaseDate.lunaDaysDifference;
      type = 'release';
    } else if (!widget.movie.lunaIsInCinemas && !widget.movie.lunaIsReleased) {
      color = widget.movie.monitored
          ? LunaColours.orange
          : LunaColours.orange.withOpacity(0.30);
      _days = widget.movie.inCinemas.lunaDaysDifference;
      type = 'cinema';
    } else {
      color = widget.movie.monitored ? Colors.white70 : Colors.white30;
      _days = LunaUI.TEXT_EMDASH;
      type = 'unknown';
    }
    return TextSpan(
      style: TextStyle(
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        color: color,
      ),
      children: [
        if (type == 'release')
          TextSpan(
            text: _days == null
                ? 'radarr.AvailabilityUnknown'.tr()
                : _days == 'Today'
                    ? 'radarr.AvailableToday'.tr()
                    : 'radarr.AvailableIn'.tr(args: [_days]),
          ),
        if (type == 'cinema')
          TextSpan(
            text: _days == null
                ? 'radarr.CinemaDateUnknown'.tr()
                : _days == 'Today'
                    ? 'radarr.InCinemasToday'.tr()
                    : 'radarr.InCinemasIn'.tr(args: [_days]),
          ),
        if (type == 'unknown') TextSpan(text: _days),
      ],
    );
  }

  LunaIconButton _trailing() {
    return LunaIconButton(
      icon: Icons.search_rounded,
      onPressed: () async => RadarrAPIHelper().automaticSearch(
          context: context,
          movieId: widget.movie.id,
          title: widget.movie.title),
      onLongPress: () async =>
          RadarrReleasesRouter().navigateTo(context, movieId: widget.movie.id),
    );
  }

  Future<void> _onTap() async =>
      RadarrMoviesDetailsRouter().navigateTo(context, movieId: widget.movie.id);
}
