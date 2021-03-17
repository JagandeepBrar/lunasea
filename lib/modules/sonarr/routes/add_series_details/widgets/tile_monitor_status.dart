import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsMonitorStatusTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Monitor Status'),
        subtitle: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.key]),
            builder: (context, box, _) => LSSubtitle(
                text: (SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data as SonarrMonitorStatus).name,
            ),
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios_rounded),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async {
        List _values = await SonarrDialogs.editMonitorStatus(context);
        if(_values[0]) {
            SonarrMonitorStatus _status = _values[1];
            _status.process(context.read<SonarrSeriesAddDetailsState>().series.seasons);
            SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.put(_values[1]);
        }
    }
}
