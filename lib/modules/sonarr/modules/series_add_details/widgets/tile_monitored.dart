import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsMonitoredTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Monitored'),
        subtitle: LSSubtitle(text: 'Monitor series for new releases'),
        trailing: Switch(
            value: context.watch<SonarrSeriesAddDetailsState>().monitored,
            onChanged: (value) {
                context.read<SonarrSeriesAddDetailsState>().monitored = value;
                SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED.put(value);
            },
        ),
    );
}
