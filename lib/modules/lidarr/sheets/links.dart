import 'package:flutter/material.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/modules/lidarr/core/api.dart';
import 'package:lunasea/utils/links.dart';
import 'package:lunasea/widgets/ui.dart';

class LinksSheet extends LunaBottomModalSheet {
  LidarrCatalogueData artist;

  LinksSheet({
    required this.artist,
  });

  @override
  Widget builder(BuildContext context) {
    return LunaListViewModal(
      children: [
        if (artist.bandsintownURI?.isNotEmpty ?? false)
          LunaBlock(
            title: 'Bandsintown',
            leading: const LunaIconButton(
              icon: LunaIcons.BANDSINTOWN,
              iconSize: LunaUI.ICON_SIZE - 4.0,
            ),
            onTap: artist.bandsintownURI!.openLink,
          ),
        if (artist.discogsURI?.isNotEmpty ?? false)
          LunaBlock(
            title: 'Discogs',
            leading: const LunaIconButton(
              icon: LunaIcons.DISCOGS,
              iconSize: LunaUI.ICON_SIZE - 2.0,
            ),
            onTap: artist.discogsURI!.openLink,
          ),
        if (artist.lastfmURI?.isNotEmpty ?? false)
          LunaBlock(
            title: 'Last.fm',
            leading: const LunaIconButton(icon: LunaIcons.LASTFM),
            onTap: artist.lastfmURI!.openLink,
          ),
        LunaBlock(
          title: 'MusicBrainz',
          leading: const LunaIconButton(icon: LunaIcons.MUSICBRAINZ),
          onTap:
              LunaLinkedContent.musicBrainz(artist.foreignArtistID)!.openLink,
        ),
      ],
    );
  }
}
