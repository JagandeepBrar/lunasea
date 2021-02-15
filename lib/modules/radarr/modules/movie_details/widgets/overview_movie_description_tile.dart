import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsOverviewDescriptionTile extends StatelessWidget {
    final RadarrMovie movie;

    RadarrMovieDetailsOverviewDescriptionTile({
        Key key,
        @required this.movie,
    }) : super(key: key);

    Widget build(BuildContext context) {
        return LunaFourLineCardWithPoster(
            posterPlaceholder: 'assets/images/radarr/nomovieposter.png',
            backgroundUrl: context.read<RadarrState>().getFanartURL(movie.id),
            posterUrl: context.read<RadarrState>().getPosterURL(movie.id),
            posterHeaders: context.read<RadarrState>().headers,
            title: movie.title,
            subtitle1: TextSpan(text: movie.overview == null || movie.overview.isEmpty ? 'No summary is available.\n\n\n' : movie.overview + '\n\n\n'),
            subtitle1MaxLines: 3,
            onTap: () async => LunaDialogs().textPreview(context, movie.title, movie.overview),
        );
    }
}
