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
            LSSnackBar(
                context: context,
                title: widget.entry.monitored ? 'Monitoring' : 'No Longer Monitoring',
                message: widget.entry.title,
                type: SNACKBAR_TYPE.success,
            );
        } else {
            LSSnackBar(
                context: context,
                title: widget.entry.monitored ? 'Failed to Stop Monitoring' : 'Failed to Monitor',
                message: widget.entry.title,
                type: SNACKBAR_TYPE.failure,
            );
        }
    }

    Future<void> _enterArtist() async {
        final dynamic result = await Navigator.of(context).pushNamed(
            LidarrDetailsArtist.ROUTE_NAME,
            arguments: LidarrDetailsArtistArguments(
                data: widget.entry,
                artistID: widget.entry.artistID,
            ),
        );
        if(result != null) switch(result[0]) {
            case 'remove_artist': {
                LSSnackBar(
                    context: context,
                    title: result[1] ? 'Removed (With Data)' : 'Removed',
                    message: widget.entry.title,
                    type: SNACKBAR_TYPE.success,
                );
                widget.refresh();
                break;
            }
        }
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

    Future<void> _enterEditArtist() async {
        final dynamic result = await Navigator.of(context).pushNamed(
            LidarrEditArtist.ROUTE_NAME,
            arguments: LidarrEditArtistArguments(entry: widget.entry),
        );
        if(result != null && result[0]) LSSnackBar(
            context: context,
            title: 'Updated',
            message: widget.entry.title,
            type: SNACKBAR_TYPE.success,
        );
    }

    Future<void> _refreshArtist() async {
        final _api = LidarrAPI.from(Database.currentProfileObject);
        await _api?.refreshArtist(widget.entry.artistID)
            ? LSSnackBar(context: context, title: 'Refreshing...', message: widget.entry.title)
            : LSSnackBar(context: context, title: 'Failed to Refresh', message: widget.entry.title, type: SNACKBAR_TYPE.failure);
    }

    Future<void> _removeArtist() async {
        final _api = LidarrAPI.from(Database.currentProfileObject);
        List values = await LidarrDialogs.showDeleteArtistPrompt(context);
        if(values[0]) {
            if(values[1]) {
                values = await SystemDialogs.showDeleteCatalogueWithFilesPrompt(context, widget.entry.title);
                if(values[0]) {
                    if(await _api.removeArtist(widget.entry.artistID, deleteFiles: true)) {
                        LSSnackBar(context: context, title: 'Removed (With Data)', message: widget.entry.title, type: SNACKBAR_TYPE.success);
                        widget.refresh();
                    } else {
                        LSSnackBar(context: context, title: 'Failed to Remove (With Data)', message: widget.entry.title, type: SNACKBAR_TYPE.failure);
                    }
                }
            } else {
                if(await _api.removeArtist(widget.entry.artistID)) {
                    LSSnackBar(context: context, title: 'Removed', message: widget.entry.title, type: SNACKBAR_TYPE.success);
                    widget.refresh();
                } else {
                    LSSnackBar(context: context, title: 'Failed to Remove', message: widget.entry.title, type: SNACKBAR_TYPE.failure);
                }
            }
        }
    }
}