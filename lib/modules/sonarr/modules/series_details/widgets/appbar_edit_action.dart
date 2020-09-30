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
    Widget build(BuildContext context) => Selector<SonarrState, Future<List<SonarrSeries>>>(
        selector: (_, state) => state.series,
        builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<List<SonarrSeries>> snapshot) {
                if(snapshot.hasError) return Container();
                if(snapshot.hasData) {
                    SonarrSeries series = snapshot.data.firstWhere((element) => element.id == seriesId, orElse: () => null);
                    if(series != null) return LSIconButton(
                        icon: Icons.edit,
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
        List values = await SonarrDialogs.seriesSettings(context, series.title);
        if(values[0]) switch(values[1] as SonarrSeriesSettingsType) {
            case SonarrSeriesSettingsType.EDIT: _edit(context, series); break;
            case SonarrSeriesSettingsType.DELETE: _delete(context, series); break;
            case SonarrSeriesSettingsType.REFRESH: _refresh(context, series); break;
            default: LunaLogger.warning('SonarrAppBarSeriesSettingsAction', '_handler', 'Unknown case: ${(values[1] as SonarrSeriesSettingsType)}');
        }
    }

    static Future<void> _edit(
        BuildContext context,
        SonarrSeries series,
    ) async => SonarrSeriesEditRouter.navigateTo(context, seriesId: series.id);

    static Future<void> _refresh(
        BuildContext context,
        SonarrSeries series,
    ) async {
        Sonarr _sonarr = Provider.of<SonarrState>(context, listen: false).api;
        if(_sonarr != null) _sonarr.command.refreshSeries(seriesId: series.id)
        .then((_) {
            LSSnackBar(
                context: context,
                title: 'Refreshing...',
                message: series.title,
            );
        })
        .catchError((error, stack) {
            LunaLogger.error(
                'SonarrAppBarSeriesSettingsAction',
                '_refresh',
                'Unable to refresh series: ${series.id}',
                error,
                stack,
                uploadToSentry: !(error is DioError),
            );
            LSSnackBar(
                context: context,
                title: 'Failed to Refresh',
                type: SNACKBAR_TYPE.failure,
            );
        });
    }

    static Future<void> _delete(
        BuildContext context,
        SonarrSeries series,
    ) async {
        //TODO
    }
}
