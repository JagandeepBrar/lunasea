import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsMonitorStatusTile extends StatefulWidget {
    final SonarrSeriesLookup series;

    SonarrSeriesAddDetailsMonitorStatusTile({
        Key key,
        @required this.series,
    }) : super(key: key);

    @override
    State<SonarrSeriesAddDetailsMonitorStatusTile> createState() => _State();
}

class _State extends State<SonarrSeriesAddDetailsMonitorStatusTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Monitor Status'),
        subtitle: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.key]),
            builder: (context, box, _) => LSSubtitle(
                text: (SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data as SonarrMonitorStatus).name,
            ),
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: _onTap,
    );

    Future<void> _onTap() async {
        List _values = await SonarrDialogs.editMonitorStatus(context);
        if(_values[0]) {
            SonarrMonitorStatus _status = _values[1];
            _status.process(widget.series.seasons);
            SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.put(_values[1]);
        }
    }
}
