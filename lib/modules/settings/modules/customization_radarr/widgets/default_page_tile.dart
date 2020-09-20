import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class SettingsCustomizationRadarrDefaultPageTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [RadarrDatabaseValue.NAVIGATION_INDEX.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: RadarrNavigationBar.titles[RadarrDatabaseValue.NAVIGATION_INDEX.data]),
            trailing: LSIconButton(icon: RadarrNavigationBar.icons[RadarrDatabaseValue.NAVIGATION_INDEX.data]),
            onTap: () async => _defaultPage(context),
        ),
    );

    Future<void> _defaultPage(BuildContext context) async {
        List<dynamic> _values = await RadarrDialogs.defaultPage(context);
        if(_values[0]) RadarrDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
    }
}
