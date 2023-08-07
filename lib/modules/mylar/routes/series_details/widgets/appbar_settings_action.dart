import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarAppBarSeriesSettingsAction extends StatelessWidget {
  final int seriesId;

  const MylarAppBarSeriesSettingsAction({
    Key? key,
    required this.seriesId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MylarState>(
      builder: (context, state, _) => FutureBuilder(
        future: state.series,
        builder: (context, AsyncSnapshot<Map<int?, MylarSeries>> snapshot) {
          if (snapshot.hasError) return Container();
          if (snapshot.hasData) {
            MylarSeries? series = snapshot.data![seriesId];
            if (series != null)
              return LunaIconButton(
                icon: Icons.more_vert_rounded,
                onPressed: () async {
                  Tuple2<bool, MylarSeriesSettingsType?> values =
                      await MylarDialogs().seriesSettings(context, series);
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
