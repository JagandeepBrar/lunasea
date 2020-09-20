import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsCustomizationDrawerUseCategoriesTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Use Folders'),
            subtitle: LSSubtitle(text: 'Group Modules into Categories'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.data,
                onChanged: _onChange,
            ),
        ),
    );

    void _onChange(bool value) => LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.put(value);
}
