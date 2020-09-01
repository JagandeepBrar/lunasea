import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SettingsCustomizationSABnzbdDefaultPageTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SABnzbdDatabaseValue.NAVIGATION_INDEX.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Default Page'),
            subtitle: LSSubtitle(text: SABnzbdNavigationBar.titles[SABnzbdDatabaseValue.NAVIGATION_INDEX.data]),
            trailing: LSIconButton(icon: SABnzbdNavigationBar.icons[SABnzbdDatabaseValue.NAVIGATION_INDEX.data]),
            onTap: () async => _defaultPage(context),
        ),
    );

    Future<void> _defaultPage(BuildContext context) async {
        List<dynamic> _values = await SABnzbdDialogs.defaultPage(context);
        if(_values[0]) SABnzbdDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
    }
}
