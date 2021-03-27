import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrEditSeriesBottomActionBar extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaBottomActionBar(
            actions: [
                LunaButton(
                    type: LunaButtonType.TEXT,
                    text: 'Update Series',
                    icon: Icons.edit_rounded,
                    onTap: () async => _onTap(context),
                    loadingState: context.watch<SonarrSeriesEditState>().state,
                ),
            ],
        );
    }

    Future<void> _onTap(BuildContext context) async {
        if(context.read<SonarrSeriesEditState>().canExecuteAction) {
            // Set loading state
            SonarrSeriesEditState _editState = context.read<SonarrSeriesEditState>();
            _editState.state = LunaLoadingState.ACTIVE;
            SonarrSeries seriesOld = context.read<SonarrSeriesEditState>().series;
            // Deep copy series, update edits
            SonarrSeries _series = seriesOld.clone();
            _series.updateEdits(_editState);
            // Send to Sonarr
            SonarrState _globalState = context.read<SonarrState>();
            _globalState.api.series.updateSeries(series: _series)
            .then((_) async {
                // Update internal series list, show snackbar, pop route 
                _globalState.resetSeries();
                await _globalState.series.then((_) {
                    LSSnackBar(
                        context: context,
                        title: 'Updated Series',
                        message: _series.title,
                        type: SNACKBAR_TYPE.success,
                    );
                    Navigator.of(context).pop();
                });
            })
            .catchError((error, stack) {
                // Log error, show error message
                LunaLogger().error('Failed to update series: ${seriesOld.id}', error, stack);
                _editState.state = LunaLoadingState.ERROR;
            });
        }
    }
}
