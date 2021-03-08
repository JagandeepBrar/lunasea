import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDetailsSettingsButton extends StatefulWidget {
    final LidarrCatalogueData data;
    final Function(bool) remove;
    
    LidarrDetailsSettingsButton({
        @required this.data,
        @required this.remove,
    });

    @override
    State<LidarrDetailsSettingsButton> createState() => _State();
}

class _State extends State<LidarrDetailsSettingsButton> {
    @override
    Widget build(BuildContext context) => Consumer<LidarrState>(
        builder: (context, model, widget) => LSIconButton(
            icon: Icons.more_vert,
            onPressed: () async => _handlePopup(context),
        ),
    );

    Future<void> _handlePopup(BuildContext context) async {
        List<dynamic> values = await LidarrDialogs.editArtist(context, widget.data);
        if(values[0]) switch(values[1]) {
            case 'refresh_artist': _refreshArtist(context); break;
            case 'edit_artist': _enterEditArtist(context); break;
            case 'remove_artist': _removeArtist(context); break;
            default: LunaLogger().warning('LidarrDetailsSettingsButton', '_handlePopup', 'Invalid method passed through popup. (${values[1]})');
        }
    }

    Future<void> _enterEditArtist(BuildContext context) async {
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

    Future<void> _refreshArtist(BuildContext context) async {
        final _api = LidarrAPI.from(Database.currentProfileObject);
        await _api.refreshArtist(widget.data.artistID)
        .then((_) => LSSnackBar(context: context, title: 'Refreshing...', message: widget.data.title))
        .catchError((_) => LSSnackBar(context: context, title: 'Failed to Refresh', message: LunaLogger.checkLogsMessage, type: SNACKBAR_TYPE.failure));
    }

    Future<void> _removeArtist(BuildContext context) async {
        final _api = LidarrAPI.from(Database.currentProfileObject);
        List values = await LidarrDialogs.deleteArtist(context);
        if(values[0]) {
            if(values[1]) {
                values = await LunaDialogs().deleteCatalogueWithFiles(context, widget.data.title);
                if(values[0]) {
                    await _api.removeArtist(widget.data.artistID, deleteFiles: true)
                    .then((_) => widget.remove(true))
                    .catchError((_) => LSSnackBar(context: context, title: 'Failed to Remove (With Data)', message: LunaLogger.checkLogsMessage, type: SNACKBAR_TYPE.failure));
                }
            } else {
                await _api.removeArtist(widget.data.artistID)
                .then((_) => widget.remove(false))
                .catchError((_) => LSSnackBar(context: context, title: 'Failed to Remove', message: LunaLogger.checkLogsMessage, type: SNACKBAR_TYPE.failure));
            }
        }
    }
}
