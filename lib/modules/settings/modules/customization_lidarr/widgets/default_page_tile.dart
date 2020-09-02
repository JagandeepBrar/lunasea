import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class SettingsCustomizationLidarrDefaultPageTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LidarrDatabaseValue.NAVIGATION_INDEX.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Default Page'),
            subtitle: LSSubtitle(text: LidarrNavigationBar.titles[LidarrDatabaseValue.NAVIGATION_INDEX.data]),
            trailing: LSIconButton(icon: LidarrNavigationBar.icons[LidarrDatabaseValue.NAVIGATION_INDEX.data]),
            onTap: () async => _defaultPage(context),
        ),
    );

    Future<void> _defaultPage(BuildContext context) async {
        List<dynamic> _values = await LidarrDialogs.defaultPage(context);
        if(_values[0]) LidarrDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
    }
}
