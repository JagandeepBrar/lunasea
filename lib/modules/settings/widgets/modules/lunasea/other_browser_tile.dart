import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesLunaSeaBrowserTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.SELECTED_BROWSER.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Open Links In...'),
            subtitle: LSSubtitle(text: (LunaSeaDatabaseValue.SELECTED_BROWSER.data as LSBrowsers).name),
            trailing: LSIconButton(
                icon: (LunaSeaDatabaseValue.SELECTED_BROWSER.data as LSBrowsers).icon,
            ),
            onTap: () async => _changeBrowser(context),
        ),
    );

    Future<void> _changeBrowser(BuildContext context) async {
        List _values = await SettingsDialogs.changeBrowser(context);
        if(_values[0]) LunaSeaDatabaseValue.SELECTED_BROWSER.put(_values[1]);
    }
}