import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesLunaSeaAMOLEDTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.THEME_AMOLED.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'AMOLED Dark Theme'),
            subtitle: LSSubtitle(text: 'Pure Black Dark Theme'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.THEME_AMOLED.data,
                onChanged: _changeTheme,
            ),
        ),
    );

    void _changeTheme(bool value) => LunaSeaDatabaseValue.THEME_AMOLED.put(value);
}