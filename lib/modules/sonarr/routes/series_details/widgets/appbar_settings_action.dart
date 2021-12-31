import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAppBarSeriesSettingsAction extends StatelessWidget {
  final int seriesId;

  const SonarrAppBarSeriesSettingsAction({
    Key? key,
    required this.seriesId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SonarrState>(
      builder: (context, state, _) => FutureBuilder(
        future: state.series,
        builder: (context, AsyncSnapshot<Map<int?, SonarrSeries>> snapshot) {
          if (snapshot.hasError) return Container();
          if (snapshot.hasData) {
            SonarrSeries? series = snapshot.data![seriesId];
            if (series != null)
              return LunaIconButton(
                icon: Icons.more_vert_rounded,
                onPressed: () async {
                  Tuple2<bool, SonarrSeriesSettingsType?> values =
                      await SonarrDialogs().seriesSettings(context, series);
                  if (values.item1) values.item2!.execute(context, series);
                },
              );
          }
          return Container();
        },
      ),
    );
  }
}
