import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrCatalogueTile extends StatefulWidget {
    final LidarrCatalogueData data;
    final GlobalKey<ScaffoldState> scaffoldKey;
    final Function refresh;
    final Function refreshState;

    LidarrCatalogueTile({
        @required this.data,
        @required this.scaffoldKey,
        @required this.refresh,
        @required this.refreshState,
    });

    @override
    State<LidarrCatalogueTile> createState() => _State();
}

class _State extends State<LidarrCatalogueTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(
            text: widget.data.title,
            darken: !widget.data.monitored,
        ),
        subtitle: Selector<LidarrModel, LidarrCatalogueSorting>(
            selector: (_, model) => model.sortCatalogueType,
            builder: (context, type, _) => LSSubtitle(
                text: widget.data.subtitle(type),
                darken: !widget.data.monitored,
                maxLines: 2,
            ),
        ),
        trailing: LSIconButton(
            icon: widget.data.monitored
                ? Icons.turned_in
                : Icons.turned_in_not,
            color: widget.data.monitored
                ? Colors.white
                : Colors.white30,
            onPressed: () => _toggleMonitoredStatus(),
        ),
        padContent: true,
        decoration: LSCardBackground(
            uri: widget.data.bannerURI(),
            headers: Database.currentProfileObject.getLidarr()['headers'],
            darken: !widget.data.monitored,
        ),
        onTap: () async => _enterArtist(),
        onLongPress: () async => _handlePopup(),
    );

    Future<void> _toggleMonitoredStatus() async {
        final _api = LidarrAPI.from(Database.currentProfileObject);
        await _api.toggleArtistMonitored(widget.data.artistID, !widget.data.monitored)
        .then((_) {
            if(mounted) setState(() => widget.data.monitored = !widget.data.monitored);
            widget.refreshState();
            LSSnackBar(
                context: context,
                title: widget.data.monitored ? 'Monitoring' : 'No Longer Monitoring',
                message: widget.data.title,
                type: SNACKBAR_TYPE.success,
            );
        })
        .catchError((_) {
            LSSnackBar(
                context: context,
                title: widget.data.monitored ? 'Failed to Stop Monitoring' : 'Failed to Monitor',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            );
        });
    }

    Future<void> _enterArtist() async {
        final dynamic result = await Navigator.of(context).pushNamed(
            LidarrDetailsArtist.ROUTE_NAME,
            arguments: LidarrDetailsArtistArguments(
                data: widget.data,
                artistID: widget.data.artistID,
            ),
        );
        if(result != null) switch(result[0]) {
            case 'remove_artist': {
                LSSnackBar(
                    context: context,
                    title: result[1] ? 'Removed (With Data)' : 'Removed',
                    message: widget.data.title,
                    type: SNACKBAR_TYPE.success,
                );
                widget.refresh();
                break;
            }
            default: Logger.warning('LidarrCatalogueTile', '_enterArtist', 'Unknown Case: ${result[0]}');
        }
    }

    Future<void> _handlePopup() async {
        List<dynamic> values = await LidarrDialogs.editArtist(context, widget.data);
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
            arguments: LidarrEditArtistArguments(entry: widget.data),
        );
        if(result != null && result[0]) LSSnackBar(
            context: context,
            title: 'Updated',
            message: widget.data.title,
            type: SNACKBAR_TYPE.success,
        );
    }

    Future<void> _refreshArtist() async {
        final _api = LidarrAPI.from(Database.currentProfileObject);
        await _api.refreshArtist(widget.data.artistID)
        .then((_) => LSSnackBar(context: context, title: 'Refreshing...', message: widget.data.title))
        .catchError((_) => LSSnackBar(context: context, title: 'Failed to Refresh', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }

    Future<void> _removeArtist() async {
        final _api = LidarrAPI.from(Database.currentProfileObject);
        List values = await LidarrDialogs.deleteArtist(context);
        if(values[0]) {
            if(values[1]) {
                values = await GlobalDialogs.deleteCatalogueWithFiles(context, widget.data.title);
                if(values[0]) {
                    await _api.removeArtist(widget.data.artistID, deleteFiles: true)
                    .then((_) {
                        LSSnackBar(context: context, title: 'Removed (With Data)', message: widget.data.title, type: SNACKBAR_TYPE.success);
                        widget.refresh();
                    })
                    .catchError((_) => LSSnackBar(context: context, title: 'Failed to Remove (With Data)', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
                }
            } else {
                await _api.removeArtist(widget.data.artistID, deleteFiles: false)
                .then((_) {
                    LSSnackBar(context: context, title: 'Removed', message: widget.data.title, type: SNACKBAR_TYPE.success);
                    widget.refresh();
                })
                .catchError((_) => LSSnackBar(context: context, title: 'Failed to Remove', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
            }
        }
    }
}