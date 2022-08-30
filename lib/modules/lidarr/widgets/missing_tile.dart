import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/router/routes/lidarr.dart';

class LidarrMissingTile extends StatefulWidget {
  static final double extent = LunaBlock.calculateItemExtent(2);

  final LidarrMissingData entry;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function refresh;

  const LidarrMissingTile({
    Key? key,
    required this.entry,
    required this.scaffoldKey,
    required this.refresh,
  }) : super(key: key);

  @override
  State<LidarrMissingTile> createState() => _State();
}

class _State extends State<LidarrMissingTile> {
  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: widget.entry.artistTitle,
      body: [
        TextSpan(
          text: widget.entry.title,
          style: const TextStyle(
            color: LunaColours.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
        TextSpan(
          text: 'Released ${widget.entry.releaseDateString}',
          style: const TextStyle(
            color: LunaColours.red,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
      ],
      trailing: LunaIconButton(
        icon: LunaIcons.SEARCH,
        onPressed: () async => _search(),
        onLongPress: () async => _interactiveSearch(),
      ),
      onTap: () async => _enterAlbum(),
      onLongPress: () async => _enterArtist(),
      posterUrl: widget.entry.albumCoverURI(),
      posterHeaders: LunaProfile.current.lidarrHeaders,
      posterIsSquare: true,
      posterPlaceholderIcon: LunaIcons.MUSIC,
      backgroundUrl: widget.entry.fanartURI(),
      backgroundHeaders: LunaProfile.current.lidarrHeaders,
    );
  }

  Future<void> _search() async {
    final _api = LidarrAPI.from(LunaProfile.current);
    await _api
        .searchAlbums([widget.entry.albumID])
        .then((_) => showLunaSuccessSnackBar(
            title: 'Searching...', message: widget.entry.title))
        .catchError((error) =>
            showLunaErrorSnackBar(title: 'Failed to Search', error: error));
  }

  Future<void> _interactiveSearch() async {
    LidarrRoutes.ARTIST_ALBUM_RELEASES.go(params: {
      'artist': widget.entry.artistID.toString(),
      'album': widget.entry.albumID.toString(),
    });
  }

  Future<void> _enterArtist() async {
    LidarrRoutes.ARTIST.go(
      params: {
        'artist': widget.entry.artistID.toString(),
      },
    );
  }

  Future<void> _enterAlbum() async {
    LidarrRoutes.ARTIST_ALBUM.go(params: {
      'album': widget.entry.albumID.toString(),
      'artist': widget.entry.artistID.toString(),
    }, queryParams: {
      'monitored': widget.entry.monitored.toString(),
    });
  }
}
