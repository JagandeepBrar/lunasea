import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieSearchResultTile extends StatefulWidget {
    final RadarrMovie movie;
    final bool onTapShowOverview;
    final bool exists;
    final bool isExcluded;

    RadarrAddMovieSearchResultTile({
        Key key,
        @required this.movie,
        @required this.exists,
        @required this.isExcluded,
        this.onTapShowOverview = false,
    }) : super(key: key);

    @override
    State<RadarrAddMovieSearchResultTile> createState() => _State();
}

class _State extends State<RadarrAddMovieSearchResultTile> {
    @override
    Widget build(BuildContext context) {
        return LunaFourLineCardWithPoster(
            backgroundUrl: widget.movie.remotePoster,
            posterUrl: widget.movie.remotePoster,
            posterHeaders: context.watch<RadarrState>().headers,
            posterPlaceholder: 'assets/images/radarr/nomovieposter.png',
            title: widget.movie.title,
            darken: widget.exists,
            titleColor: widget.isExcluded ? LunaColours.red : Colors.white,
            subtitle1: _subtitle1,
            subtitle2: _subtitle2,
            subtitle2MaxLines: 2,
            onTap: _onTap,
            onLongPress: _onLongPress,
        );
    }

    TextSpan get _subtitle1 => TextSpan(
        children: [
            TextSpan(text: widget.movie.lunaYear),
            TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
            TextSpan(text: widget.movie.lunaRuntime),
            TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
            TextSpan(text: widget.movie.lunaStudio),
        ],
    );

    TextSpan get _subtitle2 => TextSpan(
        style: TextStyle(fontStyle: FontStyle.italic),
        text: widget.movie.overview == null || widget.movie.overview.isEmpty ? 'No summary is available.\n' : widget.movie.overview,
    );

    Future<void> _onTap() async {
        if(widget.onTapShowOverview) {
            LunaDialogs().textPreview(context, widget.movie.title, widget.movie.overview ?? 'No summary is available.');
        } else if(widget.exists) {
            RadarrMoviesDetailsRouter().navigateTo(context, movieId: widget.movie.id ?? -1);
        } else {
            RadarrAddMovieDetailsRouter().navigateTo(context, tmdbId: widget.movie.tmdbId ?? -1);
        }
    }

    Future<void> _onLongPress() async => widget.movie?.tmdbId?.toString()?.lunaOpenTheMovieDBMovie();
}
