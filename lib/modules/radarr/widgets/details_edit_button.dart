import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrDetailsEditButton extends StatefulWidget {
    final RadarrCatalogueData data;
    final Function() remove;
    
    RadarrDetailsEditButton({
        @required this.data,
        @required this.remove,
    });

    @override
    State<RadarrDetailsEditButton> createState() => _State();
}

class _State extends State<RadarrDetailsEditButton> {
    @override
    Widget build(BuildContext context) => Consumer<RadarrState>(
        builder: (context, model, widget) => LSIconButton(
            icon: Icons.edit,
            onPressed: () async => _handlePopup(context),
        ),
    );

    Future<void> _handlePopup(BuildContext context) async {
        List<dynamic> values = await RadarrDialogs.editMovie(context, widget.data);
        if(values[0]) switch(values[1]) {
            case 'refresh_movie': _refreshMovie(context); break;
            case 'edit_movie': _editMovie(context); break;
            case 'remove_movie': _removeMovie(context); break;
            default: Logger.warning('RadarrDetailsEditButton', '_handlePopup', 'Invalid method passed through popup. (${values[1]})');
        }
    }

    Future<void> _editMovie(BuildContext context) async {
        final dynamic result = await Navigator.of(context).pushNamed(
            RadarrEditMovie.ROUTE_NAME,
            arguments: RadarrEditMovieArguments(data: widget.data),
        );
        if(result != null && result[0]) LSSnackBar(
            context: context,
            title: 'Updated',
            message: widget.data.title,
            type: SNACKBAR_TYPE.success,
        );
    }

    Future<void> _refreshMovie(BuildContext context) async {
        final _api = RadarrAPI.from(Database.currentProfileObject);
        await _api.refreshMovie(widget.data.movieID)
        .then((_) => LSSnackBar(context: context, title: 'Refreshing...', message: widget.data.title))
        .catchError((_) => LSSnackBar(context: context, title: 'Failed to Refresh', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }

    Future<void> _removeMovie(BuildContext context) async {
        final _api = RadarrAPI.from(Database.currentProfileObject);
        List values = await RadarrDialogs.deleteMovie(context);
        if(values[0]) {
            RadarrState _state = Provider.of<RadarrState>(context, listen: false);
            await _api.removeMovie(
                widget.data.movieID,
                deleteFiles: _state.removeDeleteFiles,
                addExclusion: _state.removeAddExclusion,
            )
            .then((_) {
                LSSnackBar(context: context, title: 'Removed', message: widget.data.title, type: SNACKBAR_TYPE.success);
                widget.remove();
            })
            .catchError((_) => LSSnackBar(context: context, title: 'Failed to Remove', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
        }
    }
}
