import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAppBarSeriesSettingsAction extends StatelessWidget {
  final int seriesId;

  SonarrAppBarSeriesSettingsAction({
    Key key,
    @required this.seriesId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Selector<SonarrState, Future<List<SonarrSeries>>>(
        selector: (_, state) => state.series,
        builder: (context, future, _) => FutureBuilder(
          future: future,
          builder: (context, AsyncSnapshot<List<SonarrSeries>> snapshot) {
            if (snapshot.hasError) return Container();
            if (snapshot.hasData) {
              SonarrSeries series = snapshot.data.firstWhere(
                  (element) => element.id == seriesId,
                  orElse: () => null);
              if (series != null)
                return LunaIconButton(
                  icon: Icons.more_vert,
                  onPressed: () async => handler(context, series),
                );
            }
            return Container();
          },
        ),
      );

  static Future<void> handler(
    BuildContext context,
    SonarrSeries series,
  ) async {
    Tuple2<bool, SonarrSeriesSettingsType> result =
        await SonarrDialogs().seriesSettings(context, series);
    if (result.item1)
      switch (result.item2) {
        case SonarrSeriesSettingsType.EDIT:
          _edit(context, series);
          break;
        case SonarrSeriesSettingsType.DELETE:
          _delete(context, series);
          break;
        case SonarrSeriesSettingsType.REFRESH:
          _refresh(context, series);
          break;
        case SonarrSeriesSettingsType.MONITORED:
          _monitored(context, series);
          break;
        default:
          LunaLogger().warning('SonarrAppBarSeriesSettingsAction', '_handler',
              'Unknown case: ${result.item2}');
      }
  }

  static Future<void> _edit(
    BuildContext context,
    SonarrSeries series,
  ) async =>
      SonarrEditSeriesRouter().navigateTo(context, seriesId: series.id);

  static Future<void> _monitored(
    BuildContext context,
    SonarrSeries series,
  ) async {
    SonarrState _state = context.read<SonarrState>();
    if (_state.api != null) {
      SonarrSeries _series = series.clone();
      _series.monitored = !_series.monitored;
      _state.api.series.updateSeries(series: _series).then((_) {
        series.monitored = !series.monitored;
        showLunaSuccessSnackBar(
          title: series.monitored ? 'Monitoring' : 'No Longer Monitoring',
          message: series.title,
        );
      }).catchError((error, stack) {
        LunaLogger().error(
            'Failed to toggle monitored state for series: ${series.id} / ${series.monitored}',
            error,
            stack);
        showLunaErrorSnackBar(
          title: series.monitored
              ? 'Failed to Unmonitor Series'
              : 'Failed to Monitor Series',
          error: error,
        );
      });
    }
  }

  static Future<void> _refresh(
    BuildContext context,
    SonarrSeries series,
  ) async {
    Sonarr _sonarr = Provider.of<SonarrState>(context, listen: false).api;
    if (_sonarr != null)
      _sonarr.command.refreshSeries(seriesId: series.id).then((_) {
        showLunaInfoSnackBar(
          title: 'Refreshing...',
          message: series.title,
        );
      }).catchError((error, stack) {
        LunaLogger()
            .error('Unable to refresh series: ${series.id}', error, stack);
        showLunaErrorSnackBar(
          title: 'Failed to Refresh',
          error: error,
        );
      });
  }

  static Future<void> _delete(
    BuildContext context,
    SonarrSeries series,
  ) async {
    SonarrState _state = context.read<SonarrState>();
    List _values = await SonarrDialogs.confirmDeleteSeries(context);
    if (_state.api != null && _values[0])
      _state.api.series
          .deleteSeries(
        seriesId: series.id,
        deleteFiles: _state.removeSeriesDeleteFiles,
      )
          .then((_) {
        showLunaSuccessSnackBar(
          title: _state.removeSeriesDeleteFiles
              ? 'Series Removed (With Data)'
              : 'Series Removed',
          message: series.title,
        );
        _state.reset();
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
      }).catchError((error, stack) {
        LunaLogger()
            .error('Failed to remove series: ${series.id}', error, stack);
        showLunaErrorSnackBar(
          title: 'Failed to Remove Series',
          error: error,
        );
      });
  }
}
