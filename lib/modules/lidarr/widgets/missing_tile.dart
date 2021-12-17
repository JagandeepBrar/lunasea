import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrMissingTile extends StatefulWidget {
  static final double extent = LunaBlock.calculateItemExtent(2);

  final LidarrMissingData entry;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function refresh;

  const LidarrMissingTile({
    Key key,
    @required this.entry,
    @required this.scaffoldKey,
    @required this.refresh,
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
            color: Colors.white70,
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
      posterHeaders: Database.currentProfileObject.getLidarr()['headers'],
      posterIsSquare: true,
      posterPlaceholderIcon: LunaIcons.MUSIC,
      backgroundUrl: widget.entry.bannerURI(),
      backgroundHeaders: Database.currentProfileObject.getLidarr()['headers'],
    );
  }

  Future<void> _search() async {
    final _api = LidarrAPI.from(Database.currentProfileObject);
    await _api
        .searchAlbums([widget.entry.albumID])
        .then((_) => showLunaSuccessSnackBar(
            title: 'Searching...', message: widget.entry.title))
        .catchError((error) =>
            showLunaErrorSnackBar(title: 'Failed to Search', error: error));
  }

  Future<void> _interactiveSearch() async => Navigator.of(context).pushNamed(
        LidarrSearchResults.ROUTE_NAME,
        arguments: LidarrSearchResultsArguments(
          albumID: widget.entry.albumID,
          title: widget.entry.title,
        ),
      );

  Future<void> _enterArtist() async {
    final dynamic result = await Navigator.of(context).pushNamed(
      LidarrDetailsArtist.ROUTE_NAME,
      arguments: LidarrDetailsArtistArguments(
        data: null,
        artistID: widget.entry.artistID,
      ),
    );
    if (result != null)
      switch (result[0]) {
        case 'remove_artist':
          {
            showLunaSuccessSnackBar(
              title: result[1] ? 'Removed (With Data)' : 'Removed',
              message: widget.entry.artistTitle,
            );
            widget.refresh();
            break;
          }
      }
  }

  Future<void> _enterAlbum() async => await Navigator.of(context).pushNamed(
        LidarrDetailsAlbum.ROUTE_NAME,
        arguments: LidarrDetailsAlbumArguments(
          albumID: widget.entry.albumID,
          title: widget.entry.title,
          monitored: widget.entry.monitored,
        ),
      );
}
