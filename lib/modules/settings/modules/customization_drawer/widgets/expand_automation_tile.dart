import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsCustomizationDrawerExpandAutomationTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION.key,
            LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.key,
        ]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Expand Automation'),
            subtitle: LSSubtitle(text: 'Expand Automation Folder Initially'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION.data,
                onChanged: LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.data
                    ? _onChange
                    : null,
            ),
        ),
    );

    void _onChange(bool value) => LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION.put(value);
}
