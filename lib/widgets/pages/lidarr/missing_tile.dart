import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class LidarrMissingTile extends StatefulWidget {
    final LidarrMissingEntry entry;
    final GlobalKey<ScaffoldState> scaffoldKey;

    LidarrMissingTile({
        @required this.entry,
        @required this.scaffoldKey,
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
        decoration: LSCardBackground(uri: widget.entry.bannerURI()),
        padContent: true,
    );

    Future<void> _search() async {
        final _api = LidarrAPI.from(Database.currentProfileObject);
        await _api.searchAlbums([widget.entry.albumID])
            ? LSSnackBar(context: context, title: 'Searching...', message: widget.entry.title)
            : LSSnackBar(context: context, title: 'Failed To Search', message: widget.entry.title, failure: true);
            // ? Notifications.showSnackBar(widget.scaffoldKey, 'Searching for ${widget.entry.title}...')
            // : Notifications.showSnackBar(widget.scaffoldKey, 'Failed to search for ${widget.entry.title}');
    }

    Future<void> _enterArtist() async {
        /** TODO */
    }

    Future<void> _enterAlbum() async {
        /** TODO */
    }
}