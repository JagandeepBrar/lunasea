import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsOverviewDescriptionTile extends StatelessWidget {
  final RadarrMovie movie;

  const RadarrMovieDetailsOverviewDescriptionTile({
    Key key,
    @required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaThreeLineCardWithPoster(
      posterPlaceholder: LunaAssets.blankVideo,
      backgroundUrl: context.read<RadarrState>().getFanartURL(movie.id),
      posterUrl: context.read<RadarrState>().getPosterURL(movie.id),
      posterHeaders: context.read<RadarrState>().headers,
      title: movie.title,
      subtitle1: TextSpan(
        text: movie.overview == null || movie.overview.isEmpty
            ? 'No summary is available.\n\n'
            : '${movie.overview}\n\n',
      ),
      subtitle1MaxLines: 2,
      onTap: () async =>
          LunaDialogs().textPreview(context, movie.title, movie.overview),
    );
  }
}
