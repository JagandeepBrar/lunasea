import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SettingsCustomizationSonarrDefaultPageHomeTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.NAVIGATION_INDEX.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: SonarrNavigationBar.titles[SonarrDatabaseValue.NAVIGATION_INDEX.data]),
            trailing: LSIconButton(icon: SonarrNavigationBar.icons[SonarrDatabaseValue.NAVIGATION_INDEX.data]),
            onTap: () async => _defaultPage(context),
        ),
    );

    Future<void> _defaultPage(BuildContext context) async {
        List<dynamic> _values = await SonarrDialogs.setDefaultPage(context, titles: SonarrNavigationBar.titles, icons: SonarrNavigationBar.icons);
        if(_values[0]) SonarrDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
    }
}
