import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditMonitoredTile extends StatelessWidget {
  const RadarrMoviesEditMonitoredTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'radarr.Monitored'.tr()),
      subtitle: LunaText.subtitle(text: 'radarr.MonitoredDescription'.tr()),
      trailing: LunaSwitch(
        value: context.watch<RadarrMoviesEditState>().monitored,
        onChanged: (value) =>
            context.read<RadarrMoviesEditState>().monitored = value,
      ),
    );
  }
}
