import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditUpdateSeriesButton extends StatelessWidget {
    final SonarrSeries series;

    SonarrSeriesEditUpdateSeriesButton({
        Key key,
        @required this.series,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => Row(
        children: <Widget>[
            Expanded(
                child: Card(
                    child: InkWell(
                        child: ListTile(
                            title: context.watch<SonarrSeriesEditState>().state == LunaLoadingState.INACTIVE
                                ? Text(
                                    'Update Series',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Constants.UI_FONT_SIZE_STICKYHEADER,
                                    ),
                                    textAlign: TextAlign.center,
                                )
                                : LSLoader(
                                    color: Colors.white,
                                    size: 20.0,
                                ),
                        ),
                        borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                        onTap: context.watch<SonarrSeriesEditState>().state == LunaLoadingState.INACTIVE
                            ? () async => _onTap(context)
                            : null,
                    ),
                    color: LunaColours.accent,
                    margin: Constants.UI_CARD_MARGIN,
                    elevation: Constants.UI_ELEVATION,
                    shape: LSRoundedShape(),
                ),
            ),
        ],
    );

    Future<void> _onTap(BuildContext context) async {
        // Set loading state
        SonarrSeriesEditState _editState = context.read<SonarrSeriesEditState>();
        _editState.state = LunaLoadingState.ACTIVE;
        // Deep copy series, update edits
        SonarrSeries _series = series.clone();
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
            LunaLogger.error(
                'SonarrSeriesEditUpdateSeriesButton',
                '_onTap',
                'Failed to update series: ${series.id}',
                error,
                stack,
                uploadToSentry: !(error is DioError),
            );
            _editState.state = LunaLoadingState.ERROR;
        });
    }
}
