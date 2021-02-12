import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrCatalogueTile extends StatefulWidget {
    final RadarrMovie movie;
    final RadarrQualityProfile profile;

    RadarrCatalogueTile({
        Key key,
        @required this.movie,
        @required this.profile,
    }) : super(key: key);

    @override
    State<RadarrCatalogueTile> createState() => _State();
}

class _State extends State<RadarrCatalogueTile> {
    @override
    Widget build(BuildContext context) => Selector<RadarrState, Future<List<RadarrMovie>>>(
        selector: (_, state) => state.movies,
        builder: (context, movies, _) => LunaFourLineCardWithPoster(
            backgroundUrl: context.read<RadarrState>().getPosterURL(widget.movie.id),
            posterUrl: context.read<RadarrState>().getPosterURL(widget.movie.id),
            posterHeaders: context.read<RadarrState>().headers,
            posterPlaceholder: 'assets/images/radarr/nomovieposter.png',
            darken: !widget.movie.monitored,
            title: widget.movie.title,
            subtitle1: _subtitle1(),
            subtitle2: _subtitle2(),
            customSubtitle3: _subtitle3(),
            onTap: _onTap,
            onLongPress: _onLongPress,
        ),
    );

    TextSpan _buildChildTextSpan(String text, RadarrMoviesSorting sorting) {
        TextStyle style;
        if(context.read<RadarrState>().moviesSortType == sorting) style = TextStyle(
            color: widget.movie.monitored ? LunaColours.accent : LunaColours.accent.withOpacity(0.30),
            fontWeight: FontWeight.w600,
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
                _buildChildTextSpan(widget.movie.lunaRuntime, RadarrMoviesSorting.RUNTIME),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                _buildChildTextSpan(widget.movie.lunaStudio, RadarrMoviesSorting.STUDIO),
            ],
        );
    }

    TextSpan _subtitle2() {
        return TextSpan(
            children: [
                _buildChildTextSpan(widget.profile?.name ?? LunaUI.TEXT_EMDASH, RadarrMoviesSorting.QUALITY_PROFILE),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                _buildChildTextSpan(widget.movie.lunaMinimumAvailability, RadarrMoviesSorting.MIN_AVAILABILITY),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                _buildChildTextSpan(widget.movie.lunaDateAdded, RadarrMoviesSorting.DATE_ADDED),
            ],
        );
    }

    Widget _buildReleaseIcon(IconData icon, Color color, bool highlight) {
        Color _color = highlight
            ? color.withOpacity(widget.movie.monitored ? 1 : 0.30)
            : Colors.grey.withOpacity(widget.movie.monitored ? 1 : 0.30);
        return Padding(
            child: Icon(icon, size: 16.0, color: _color),
            padding: EdgeInsets.only(right: 8.0),
        );
    }

    Widget _subtitle3() {
        return Row(
            children: [
                _buildReleaseIcon(Icons.videocam, LunaColours.orange, widget.movie.lunaIsInCinemas),
                _buildReleaseIcon(Icons.album, LunaColours.blue, widget.movie.lunaIsReleased),
                _buildReleaseIcon(Icons.check_circle, LunaColours.accent, widget.movie.hasFile),
                Padding(
                    child: widget.movie.hasFile
                        ? widget.movie.lunaHasFileTextObject(widget.movie.monitored)
                        : widget.movie.lunaNextReleaseTextObject(widget.movie.monitored),
                    padding: EdgeInsets.only(top: 1.5),
                ),
            ],
        );
    }

    Future<void> _onTap() async => RadarrMoviesDetailsRouter().navigateTo(context, movieId: widget.movie.id);

    Future<void> _onLongPress() async {
        Tuple2<bool, RadarrMovieSettingsType> values = await RadarrDialogs().movieSettings(context, widget.movie);
        if(values.item1) values.item2.execute(context, widget.movie);
    }
}
