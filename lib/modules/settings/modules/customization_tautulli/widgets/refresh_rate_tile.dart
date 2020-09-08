import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsCustomizationTautulliRefreshRateTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.REFRESH_RATE.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Refresh Rate'),
            subtitle: LSSubtitle(text: [
                    'Every',
                    TautulliDatabaseValue.REFRESH_RATE.data == 1
                        ? ' '
                        : ' ${TautulliDatabaseValue.REFRESH_RATE.data.toString()} ',
                    TautulliDatabaseValue.REFRESH_RATE.data == 1
                        ? 'Second'
                        : 'Seconds'
                ].join(),
            ),
            trailing: LSIconButton(icon: Icons.refresh),
            onTap: () async => _onTap(context),
        ),
    );

    Future<void> _onTap(BuildContext context) async {
        List<dynamic> _values = await TautulliDialogs.refreshRate(context);
        if(_values[0]) TautulliDatabaseValue.REFRESH_RATE.put(_values[1]);
    }
}
