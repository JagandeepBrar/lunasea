import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

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
            onLongPress: () async => 'https://www.lunasea.app'.lsLinks_OpenLink(),
        ),
    );

    Future<void> _changeBrowser(BuildContext context) async {
        List _values = await LSDialogSettings.changeBrowser(context);
        if(_values[0]) Database.lunaSeaBox.put(
            LunaSeaDatabaseValue.SELECTED_BROWSER.key,
            _values[1],
        );
    }
}