import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class SettingsCustomizationHomeDefaultPageTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.NAVIGATION_INDEX.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: HomeNavigationBar.titles[HomeDatabaseValue.NAVIGATION_INDEX.data]),
            trailing: LSIconButton(icon: HomeNavigationBar.icons[HomeDatabaseValue.NAVIGATION_INDEX.data]),
            onTap: () async => _defaultPage(context),
        ),
    );

    Future<void> _defaultPage(BuildContext context) async {
        List<dynamic> _values = await HomeDialogs.defaultPage(context);
        if(_values[0]) HomeDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
    }
}
