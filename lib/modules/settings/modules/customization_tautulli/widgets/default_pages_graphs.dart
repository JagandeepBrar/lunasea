import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsCustomizationTautulliDefaultPageGraphsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Graphs'),
            subtitle: LSSubtitle(text: TautulliGraphsNavigationBar.titles[TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS.data]),
            trailing: LSIconButton(icon: TautulliGraphsNavigationBar.icons[TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS.data]),
            onTap: () async => _defaultPage(context),
        ),
    );

    Future<void> _defaultPage(BuildContext context) async {
        List<dynamic> _values = await TautulliDialogs.setDefaultPage(context, titles: TautulliGraphsNavigationBar.titles, icons: TautulliGraphsNavigationBar.icons);
        if(_values[0]) TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS.put(_values[1]);
    }
}
