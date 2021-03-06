import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsMonitoredTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'radarr.Monitored'.tr()),
            subtitle: LunaText.subtitle(text: 'radarr.MonitoredDescription'.tr()),
            trailing: Selector<RadarrAddMovieDetailsState, bool>(
                selector: (_, state) => state.monitored,
                builder: (context, monitored, _) => LunaSwitch(
                    value: monitored,
                    onChanged: (value) => context.read<RadarrAddMovieDetailsState>().monitored = value,
                ),
            ),
        );
    }
}
