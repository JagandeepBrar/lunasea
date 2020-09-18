import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsCustomizationTautulliDefaultPageLibrariesDetailsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Library Details'),
            subtitle: LSSubtitle(text: TautulliLibrariesDetailsNavigationBar.titles[TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS.data]),
            trailing: LSIconButton(icon: TautulliLibrariesDetailsNavigationBar.icons[TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS.data]),
            onTap: () async => _defaultPage(context),
        ),
    );

    Future<void> _defaultPage(BuildContext context) async {
        List<dynamic> _values = await TautulliDialogs.setDefaultPage(context, titles: TautulliLibrariesDetailsNavigationBar.titles, icons: TautulliLibrariesDetailsNavigationBar.icons);
        if(_values[0]) TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS.put(_values[1]);
    }
}
