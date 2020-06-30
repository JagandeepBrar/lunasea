import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDetailsEditButton extends StatefulWidget {
    final LidarrCatalogueData data;
    final Function(bool) remove;
    
    LidarrDetailsEditButton({
        @required this.data,
        @required this.remove,
    });

    @override
    State<LidarrDetailsEditButton> createState() => _State();
}

class _State extends State<LidarrDetailsEditButton> {
    @override
    Widget build(BuildContext context) => Consumer<LidarrModel>(
        builder: (context, model, widget) => LSIconButton(
            icon: Icons.edit,
            onPressed: () async => _handlePopup(context),
        ),
    );

    Future<void> _handlePopup(BuildContext context) async {
        List<dynamic> values = await LidarrDialogs.editArtist(context, widget.data);
        if(values[0]) switch(values[1]) {
            case 'refresh_artist': _refreshArtist(context); break;
            case 'edit_artist': _enterEditArtist(context); break;
            case 'remove_artist': _removeArtist(context); break;
            default: Logger.warning('LidarrDetailsEditButton', '_handlePopup', 'Invalid method passed through popup. (${values[1]})');
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
        .catchError((_) => LSSnackBar(context: context, title: 'Failed to Refresh', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }

    Future<void> _removeArtist(BuildContext context) async {
        final _api = LidarrAPI.from(Database.currentProfileObject);
        List values = await LidarrDialogs.deleteArtist(context);
        if(values[0]) {
            if(values[1]) {
                values = await GlobalDialogs.deleteCatalogueWithFiles(context, widget.data.title);
                if(values[0]) {
                    await _api.removeArtist(widget.data.artistID, deleteFiles: true)
                    .then((_) => widget.remove(true))
                    .catchError((_) => LSSnackBar(context: context, title: 'Failed to Remove (With Data)', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
                }
            } else {
                await _api.removeArtist(widget.data.artistID)
                .then((_) => widget.remove(false))
                .catchError((_) => LSSnackBar(context: context, title: 'Failed to Remove', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
            }
        }
    }
}
