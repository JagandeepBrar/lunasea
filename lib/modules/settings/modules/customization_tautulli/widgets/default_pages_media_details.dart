import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsCustomizationTautulliDefaultPageMediaDetailsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Media Details'),
            subtitle: LSSubtitle(text: TautulliMediaDetailsNavigationBar.titles[TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.data]),
            trailing: LSIconButton(icon: TautulliMediaDetailsNavigationBar.icons[TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.data]),
            onTap: () async => _defaultPage(context),
        ),
    );

    Future<void> _defaultPage(BuildContext context) async {
        List<dynamic> _values = await TautulliDialogs.setDefaultPage(context, titles: TautulliMediaDetailsNavigationBar.titles, icons: TautulliMediaDetailsNavigationBar.icons);
        if(_values[0]) TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.put(_values[1]);
    }
}
