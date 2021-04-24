import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditMonitoredTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Monitored'),
      subtitle: LunaText.subtitle(text: 'Monitor series for new releases'),
      trailing: LunaSwitch(
        value: context.watch<SonarrSeriesEditState>().monitored,
        onChanged: (value) =>
            context.read<SonarrSeriesEditState>().monitored = value,
      ),
    );
  }
}
