import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrMissingTile extends StatefulWidget {
    final LidarrMissingData entry;
    final GlobalKey<ScaffoldState> scaffoldKey;
    final Function refresh;

    LidarrMissingTile({
        @required this.entry,
        @required this.scaffoldKey,
        @required this.refresh,
    });

    @override
    State<LidarrMissingTile> createState() => _State();
}

class _State extends State<LidarrMissingTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: widget.entry.artistTitle),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: <TextSpan>[
                    TextSpan(
                        text: widget.entry.title,
                        style: TextStyle(
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                        ),
                    ),
                    TextSpan(
                        text: '\nReleased ${widget.entry.releaseDateString}',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                ],
            ),
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 2,
        ),
        trailing: LSIconButton(
            icon: Icons.search,
            onPressed: () async => _search(),
        ),
        onTap: () async => _enterAlbum(),
        onLongPress: () async => _enterArtist(),
        decoration: LSCardBackground(
            uri: widget.entry.bannerURI(),
            headers: Database.currentProfileObject.getLidarr()['headers'],
        ),
        padContent: true,
    );

    Future<void> _search() async {
        final _api = LidarrAPI.from(Database.currentProfileObject);
        await _api.searchAlbums([widget.entry.albumID])
        .then((_) => LSSnackBar(context: context, title: 'Searching...', message: widget.entry.title))
        .catchError((_) => LSSnackBar(context: context, title: 'Failed to Search', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }

    Future<void> _enterArtist() async {
        final dynamic result = await Navigator.of(context).pushNamed(
            LidarrDetailsArtist.ROUTE_NAME,
            arguments: LidarrDetailsArtistArguments(
                data: null,
                artistID: widget.entry.artistID,
            ),
        );
        if(result != null) switch(result[0]) {
            case 'remove_artist': {
                LSSnackBar(
                    context: context,
                    title: result[1] ? 'Removed (With Data)' : 'Removed',
                    message: widget.entry.artistTitle,
                    type: SNACKBAR_TYPE.success,
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