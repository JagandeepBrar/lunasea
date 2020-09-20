import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class SettingsCustomizationNZBGetDefaultPageTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [NZBGetDatabaseValue.NAVIGATION_INDEX.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: NZBGetNavigationBar.titles[NZBGetDatabaseValue.NAVIGATION_INDEX.data]),
            trailing: LSIconButton(icon: NZBGetNavigationBar.icons[NZBGetDatabaseValue.NAVIGATION_INDEX.data]),
            onTap: () async => _defaultPage(context),
        ),
    );

    Future<void> _defaultPage(BuildContext context) async {
        List<dynamic> _values = await NZBGetDialogs.defaultPage(context);
        if(_values[0]) NZBGetDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
    }
}
