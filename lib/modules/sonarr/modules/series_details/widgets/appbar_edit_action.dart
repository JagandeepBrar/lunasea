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
                        onPressed: () async => _handler(context, series),
                    );
                }       
                return Container();
            },
        ),
    );

    Future<void> _handler(BuildContext context, SonarrSeries series) async {
        List values = await SonarrDialogs.seriesSettings(context, series.title);
        if(values[0]) switch(values[1] as SonarrSeriesSettingsType) {
            case SonarrSeriesSettingsType.EDIT: _edit(context); break;
            case SonarrSeriesSettingsType.DELETE: _delete(context); break;
            case SonarrSeriesSettingsType.REFRESH: _refresh(context, series); break;
            default: LunaLogger.warning('SonarrAppBarSeriesSettingsAction', '_handler', 'Unknown case: ${(values[1] as SonarrSeriesSettingsType)}');
        }
    }

    Future<void> _edit(BuildContext context) async => SonarrSeriesEditRouter.navigateTo(context, seriesId: seriesId);

    Future<void> _refresh(BuildContext context, SonarrSeries series) async {
        //TODO
        LSSnackBar(
            context: context,
            title: 'Refreshing...',
            message: series.title,
            type: SNACKBAR_TYPE.info,
        );
    }

    Future<void> _delete(BuildContext context) async {
        //TODO
    }
}
