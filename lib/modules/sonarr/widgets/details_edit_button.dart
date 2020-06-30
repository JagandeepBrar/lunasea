import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrDetailsEditButton extends StatefulWidget {
    final SonarrCatalogueData data;
    final Function(bool) remove;
    
    SonarrDetailsEditButton({
        @required this.data,
        @required this.remove,
    });

    @override
    State<SonarrDetailsEditButton> createState() => _State();
}

class _State extends State<SonarrDetailsEditButton> {
    @override
    Widget build(BuildContext context) => Consumer<SonarrModel>(
        builder: (context, model, widget) => LSIconButton(
            icon: Icons.edit,
            onPressed: () async => _handlePopup(context),
        ),
    );

    Future<void> _handlePopup(BuildContext context) async {
        List<dynamic> values = await SonarrDialogs.editSeries(context, widget.data);
        if(values[0]) switch(values[1]) {
            case 'refresh_series': _refreshSeries(context); break;
            case 'edit_series': _editSeries(context); break;
            case 'remove_series': _removeSeries(context); break;
            default: Logger.warning('SonarrDetailsEditButton', '_handlePopup', 'Unknown Case: (${values[1]})');
        }
    }

    Future<void> _editSeries(BuildContext context) async {
        final dynamic result = await Navigator.of(context).pushNamed(
            SonarrEditSeries.ROUTE_NAME,
            arguments: SonarrEditSeriesArguments(
                data: widget.data,
            ),
        );
        if(result != null && result[0]) LSSnackBar(
            context: context,
            title: 'Updated',
            message: widget.data.title,
            type: SNACKBAR_TYPE.success,
        );
    }

    Future<void> _refreshSeries(BuildContext context) async {
        SonarrAPI _api = SonarrAPI.from(Database.currentProfileObject);
        await _api.refreshSeries(widget.data.seriesID)
        .then((_) => LSSnackBar(context: context, title: 'Refreshing...', message: widget.data.title))
        .catchError((_) => LSSnackBar(context: context, title: 'Failed to Refresh', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }

    Future<void> _removeSeries(BuildContext context) async {
        final _api = SonarrAPI.from(Database.currentProfileObject);
        List values = await SonarrDialogs.deleteSeries(context);
        if(values[0]) {
            if(values[1]) {
                values = await GlobalDialogs.deleteCatalogueWithFiles(context, widget.data.title);
                if(values[0]) {
                    await _api.removeSeries(widget.data.seriesID, deleteFiles: true)
                    .then((_) => widget.remove(true))
                    .catchError((_) => LSSnackBar(context: context, title: 'Failed to Remove (With Data)', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
                }
            } else {
                await _api.removeSeries(widget.data.seriesID, deleteFiles: false)
                .then((_) => widget.remove(false))
                .catchError((_) => LSSnackBar(context: context, title: 'Failed to Remove', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
            }
        }
    }
}
