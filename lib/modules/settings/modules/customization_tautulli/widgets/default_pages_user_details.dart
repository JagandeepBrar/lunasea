import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsCustomizationTautulliDefaultPageUserDetailsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'User Details'),
            subtitle: LSSubtitle(text: TautulliUserDetailsNavigationBar.titles[TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.data]),
            trailing: LSIconButton(icon: TautulliUserDetailsNavigationBar.icons[TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.data]),
            onTap: () async => _defaultPage(context),
        ),
    );

    Future<void> _defaultPage(BuildContext context) async {
        List<dynamic> _values = await TautulliDialogs.setDefaultPage(context, titles: TautulliUserDetailsNavigationBar.titles, icons: TautulliUserDetailsNavigationBar.icons);
        if(_values[0]) TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.put(_values[1]);
    }
}
