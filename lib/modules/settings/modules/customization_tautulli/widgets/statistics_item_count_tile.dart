import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsCustomizationTautulliStatisticsItemCountTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.STATISTICS_STATS_COUNT.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Item Count'),
            subtitle: LSSubtitle(
                text: [
                    TautulliDatabaseValue.STATISTICS_STATS_COUNT.data.toString(),
                    TautulliDatabaseValue.STATISTICS_STATS_COUNT.data == 1
                        ? ' Item'
                        : ' Items'
                ].join(),
            ),
            trailing: LSIconButton(icon: Icons.format_list_numbered),
            onTap: () async => _onTap(context),
        ),
    );

    Future<void> _onTap(BuildContext context) async {
        List<dynamic> _values = await TautulliDialogs.setStatisticsItemCount(context);
        if(_values[0]) TautulliDatabaseValue.STATISTICS_STATS_COUNT.put(_values[1]);
    }
}
