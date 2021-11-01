import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsMonitorTile extends StatelessWidget {
  const SonarrSeriesAddDetailsMonitorTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Monitor'),
      subtitle: LunaText.subtitle(
        text: context
                .watch<SonarrSeriesAddDetailsState>()
                .monitorType
                ?.lunaName ??
            LunaUI.TEXT_EMDASH,
      ),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, SonarrSeriesMonitorType> result =
        await SonarrDialogs().editMonitorType(context);
    if (result.item1) {
      context.read<SonarrSeriesAddDetailsState>().monitorType = result.item2;
      SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_TYPE
          .put(result.item2.value);
    }
  }
}
