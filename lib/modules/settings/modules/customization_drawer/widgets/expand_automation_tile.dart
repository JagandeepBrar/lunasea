import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsCustomizationDrawerExpandAutomationTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Expand Automation'),
            subtitle: LSSubtitle(text: 'Expand the Automation Category Initially'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION.data,
                onChanged: _onChange,
            ),
        ),
    );

    void _onChange(bool value) => LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION.put(value);
}
