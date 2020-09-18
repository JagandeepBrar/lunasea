import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsCustomizationDrawerExpandClientsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS.key,
            LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.key,
        ]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Expand Clients'),
            subtitle: LSSubtitle(text: 'Expand Clients Category Initially'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS.data,
                onChanged: LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.data
                    ? _onChange
                    : null,
                ),
        ),
    );

    void _onChange(bool value) => LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS.put(value);
}
