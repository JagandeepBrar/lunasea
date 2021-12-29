import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditMonitoredTile extends StatelessWidget {
  const RadarrMoviesEditMonitoredTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'radarr.Monitored'.tr(),
      trailing: LunaSwitch(
        value: context.watch<RadarrMoviesEditState>().monitored,
        onChanged: (value) =>
            context.read<RadarrMoviesEditState>().monitored = value,
      ),
    );
  }
}
