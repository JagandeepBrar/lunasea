import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditMonitoredTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Monitored'),
        subtitle: LSSubtitle(text: 'Monitor series for new releases'),
        trailing: Switch(
            value: context.watch<SonarrSeriesEditState>().monitored,
            onChanged: (value) => context.read<SonarrSeriesEditState>().monitored = value,
        ),
    );
}
