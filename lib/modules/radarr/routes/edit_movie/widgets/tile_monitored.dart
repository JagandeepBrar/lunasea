import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditMonitoredTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Monitored'),
            subtitle: LunaText.subtitle(text: 'Monitor movie for new releases'),
            trailing: LunaSwitch(
                value: context.watch<RadarrMoviesEditState>().monitored,
                onChanged: (value) => context.read<RadarrMoviesEditState>().monitored = value,
            ),
        );
    }
}
