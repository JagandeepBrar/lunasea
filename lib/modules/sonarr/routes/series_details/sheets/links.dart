import 'package:flutter/material.dart';
import 'package:lunasea/extensions/string_links.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/utils/link_generator.dart';
import 'package:lunasea/widgets/ui.dart';

class LinksSheet extends LunaBottomModalSheet {
  SonarrSeries series;

  LinksSheet({
    required this.series,
  });

  @override
  Widget builder(BuildContext context) {
    final imdb = LinkGenerator.imdb(series.imdbId);
    final tvdb = LinkGenerator.theTVDB(series.tvdbId, ContentType.SERIES);
    final trakt = LinkGenerator.trakt(series.tvdbId, ContentType.SERIES);
    final tvMaze = LinkGenerator.tvMaze(series.tvMazeId);

    return LunaListViewModal(
      children: [
        if (imdb != null)
          LunaBlock(
            title: 'IMDb',
            leading: const LunaIconButton(icon: LunaIcons.IMDB),
            onTap: imdb.openLink,
          ),
        if (tvdb != null)
          LunaBlock(
            title: 'TheTVDB',
            leading: const LunaIconButton(icon: LunaIcons.THETVDB),
            onTap: tvdb.openLink,
          ),
        if (trakt != null)
          LunaBlock(
            title: 'Trakt',
            leading: const LunaIconButton(icon: LunaIcons.TRAKT),
            onTap: trakt.openLink,
          ),
        if (tvMaze != null)
          LunaBlock(
            title: 'TVmaze',
            leading: const LunaIconButton(icon: LunaIcons.TVMAZE),
            onTap: tvMaze.openLink,
          ),
      ],
    );
  }
}
