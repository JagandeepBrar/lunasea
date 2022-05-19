import 'package:flutter/material.dart';
import 'package:lunasea/extensions/string_links.dart';
import 'package:lunasea/modules/radarr/api.dart';
import 'package:lunasea/utils/link_generator.dart';
import 'package:lunasea/widgets/ui.dart';

class LinksSheet extends LunaBottomModalSheet {
  RadarrMovie movie;

  LinksSheet({
    required this.movie,
  });

  @override
  Widget builder(BuildContext context) {
    final imdb = LinkGenerator.imdb(movie.imdbId);
    final tmdb = LinkGenerator.theMovieDB(movie.tmdbId, ContentType.MOVIE);
    final letterboxd = LinkGenerator.letterboxd(movie.tmdbId);
    final trakt = LinkGenerator.trakt(movie.tmdbId, ContentType.MOVIE);
    final youtube = LinkGenerator.youtube(movie.youTubeTrailerId);

    return LunaListViewModal(
      children: [
        if (imdb != null)
          LunaBlock(
            title: 'IMDb',
            leading: const LunaIconButton(icon: LunaIcons.IMDB),
            onTap: imdb.openLink,
          ),
        if (letterboxd != null)
          LunaBlock(
            title: 'Letterboxd',
            leading: const LunaIconButton(icon: LunaIcons.LETTERBOXD),
            onTap: letterboxd.openLink,
          ),
        if (tmdb != null)
          LunaBlock(
            title: 'The Movie Database',
            leading: const LunaIconButton(icon: LunaIcons.THEMOVIEDATABASE),
            onTap: tmdb.openLink,
          ),
        if (trakt != null)
          LunaBlock(
            title: 'Trakt',
            leading: const LunaIconButton(icon: LunaIcons.TRAKT),
            onTap: trakt.openLink,
          ),
        if (youtube != null)
          LunaBlock(
            title: 'YouTube',
            leading: const LunaIconButton(icon: LunaIcons.YOUTUBE),
            onTap: youtube.openLink,
          ),
      ],
    );
  }
}
