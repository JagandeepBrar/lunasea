import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsCustomizationDrawerUseCategoriesTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Group by Category'),
            subtitle: LSSubtitle(text: 'Categorize Modules into Groups'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.data,
                onChanged: _onChange,
            ),
        ),
    );

    void _onChange(bool value) => LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.put(value);
}
