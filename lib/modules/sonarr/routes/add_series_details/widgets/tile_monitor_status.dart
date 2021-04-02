import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsMonitorStatusTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Monitor Status'),
            subtitle: SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.listen(
                builder: (context, box, _) => LunaText.subtitle(
                    text: (SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data as SonarrMonitorStatus).name,
                ),
            ),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: () async => _onTap(context),
        );
    }

    Future<void> _onTap(BuildContext context) async {
        Tuple2<bool, SonarrMonitorStatus> result = await SonarrDialogs().editMonitorStatus(context);
        if(result.item1) {
            result.item2.process(context.read<SonarrSeriesAddDetailsState>().series.seasons);
            SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.put(result.item2);
        }
    }
}
