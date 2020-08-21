import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsDrawerExpandClientsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Expand Clients'),
            subtitle: LSSubtitle(text: 'Expand the Clients Category Initially'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS.data,
                onChanged: _onChange,
            ),
        ),
    );

    void _onChange(bool value) => LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS.put(value);
}
