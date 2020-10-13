import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsMonitoredTile extends StatefulWidget {
    final SonarrSeriesLookup series;

    SonarrSeriesAddDetailsMonitoredTile({
        Key key,
        @required this.series,
    }) : super(key: key);

    @override
    State<SonarrSeriesAddDetailsMonitoredTile> createState() => _State();
}

class _State extends State<SonarrSeriesAddDetailsMonitoredTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Monitored'),
        subtitle: LSSubtitle(text: 'Monitor series for new releases'),
        trailing: Switch(
            value: widget.series.monitored,
            onChanged: (value) {
                setState(() => widget.series.monitored = value);
                SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED.put(value);
            },
        ),
    );
}
