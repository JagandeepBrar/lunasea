import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/routes/lidarr/routes.dart';
import 'package:lunasea/widgets.dart';

class LidarrCatalogueTile extends StatefulWidget {
    final LidarrCatalogueEntry entry;
    final GlobalKey<ScaffoldState> scaffoldKey;
    final Function refresh;

    LidarrCatalogueTile({
        @required this.entry,
        @required this.scaffoldKey,
        @required this.refresh,
    });

    @override
    State<LidarrCatalogueTile> createState() => _State();
}

class _State extends State<LidarrCatalogueTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(
            text: widget.entry.title,
            darken: !widget.entry.monitored,
        ),
        subtitle: LSSubtitle(
            text: widget.entry.subtitle,
            darken: !widget.entry.monitored,
            maxLines: 2,
        ),
        trailing: LSIconButton(
            icon: widget.entry.monitored
                ? Icons.turned_in
                : Icons.turned_in_not,
            color: widget.entry.monitored
                ? Colors.white
                : Colors.white30,
            onPressed: () => _toggleMonitoredStatus(),
        ),
        padContent: true,
        decoration: LSCardBackground(uri: widget.entry.bannerURI()),
        onTap: () => _enterArtist(),
        onLongPress: () => _handlePopup(),
    );

    Future<void> _toggleMonitoredStatus() async {
        final _api = LidarrAPI.from(Database.currentProfileObject);
        if(await _api.toggleArtistMonitored(widget.entry.artistID, !widget.entry.monitored)) {
            if(mounted) setState(() => widget.entry.monitored = !widget.entry.monitored);
            Notifications.showSnackBar(widget.scaffoldKey, widget.entry.monitored ? 'Monitoring ${widget.entry.title}' : 'No longer monitoring ${widget.entry.title}');
        } else {
            Notifications.showSnackBar(widget.scaffoldKey, widget.entry.monitored ? 'Failed to stop monitoring ${widget.entry.title}' : 'Failed to start monitoring ${widget.entry.title}');
        }
    }

    Future<void> _enterArtist() async {
        /** TODO */
    }

    Future<void> _enterEditArtist() async {
        final dynamic result = Navigator.of(context).pushNamed(
            LidarrEditArtist.ROUTE_NAME,
            arguments: LidarrEditArtistArguments(entry: widget.entry),
        );
    }

    Future<void> _handlePopup() async {
        List<dynamic> values = await LidarrDialogs.showEditArtistPrompt(context, widget.entry);
        if(values[0]) switch(values[1]) {
            case 'refresh_artist': _refreshArtist(); break;
            case 'edit_artist': _enterEditArtist(); break;
            case 'remove_artist': _removeArtist(); break;
            default: Logger.warning('LidarrCatalogueTile', '_handlePopup', 'Invalid method passed through popup. (${values[1]})');
        }
    }

    Future<void> _refreshArtist() async {
        final _api = LidarrAPI.from(Database.currentProfileObject);
        await _api?.refreshArtist(widget.entry.artistID)
            ? Notifications.showSnackBar(widget.scaffoldKey, 'Refreshing ${widget.entry.title}...')
            : Notifications.showSnackBar(widget.scaffoldKey, 'Failed to refresh ${widget.entry.title}');
    }

    Future<void> _removeArtist() async {
        final _api = LidarrAPI.from(Database.currentProfileObject);
        List values = await LidarrDialogs.showDeleteArtistPrompt(context);
        if(values[0]) {
            if(values[1]) {
                values = await SystemDialogs.showDeleteCatalogueWithFilesPrompt(context, widget.entry.title);
                if(values[0]) {
                    if(await _api.removeArtist(widget.entry.artistID, deleteFiles: true)) {
                        Notifications.showSnackBar(widget.scaffoldKey, 'Removed ${widget.entry.title}');
                        widget.refresh();
                    } else {
                        Notifications.showSnackBar(widget.scaffoldKey, 'Failed to remove ${widget.entry.title}');
                    }
                }
            } else {
                if(await _api.removeArtist(widget.entry.artistID)) {
                    Notifications.showSnackBar(widget.scaffoldKey, 'Removed ${widget.entry.title}');
                    widget.refresh();
                } else {
                    Notifications.showSnackBar(widget.scaffoldKey, 'Failed to remove ${widget.entry.title}');
                }
            }
            
        }
    }
}