import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAppBarSeriesEditAction extends StatelessWidget {
    final int seriesId;

    SonarrAppBarSeriesEditAction({
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
                    if(series != null) return LunaIconButton(
                        icon: Icons.edit,
                        onPressed: () async => SonarrEditSeriesRouter().navigateTo(context, seriesId: series.id),
                    );
                }
                return Container();
            },
        ),
    );
}
